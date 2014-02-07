module DataFixup::ReassociateConversationAttachments

  def self.run
    conn = ConversationMessage.connection
    adapter_name = conn.adapter_name.downcase
    temp_table_options = adapter_name =~ /mysql/ ? 'engine=innodb' : 'AS'
    cmas = []

    ConversationMessage.transaction do
      conn.execute <<-SQL
        CREATE TEMPORARY TABLE _conversation_message_attachments #{temp_table_options}
        SELECT context_id AS conversation_message_id,
          (SELECT author_id FROM conversation_messages WHERE id = a.context_id) AS author_id,
          id AS attachment_id
        FROM attachments a
        WHERE context_type = 'ConversationMessage'
      SQL
      conn.add_index :_conversation_message_attachments, :conversation_message_id, :name => '_cma_cmid_index'
      conn.add_index :_conversation_message_attachments, :attachment_id, :name => '_cma_aid_index'
      conn.execute "ANALYZE _conversation_message_attachments" if adapter_name =~ /postgres/
  
      # make sure users w/ conversation attachments have root folders
      conn.execute <<-SQL
        INSERT INTO folders(context_id, context_type, name, full_name, workflow_state)
        SELECT DISTINCT author_id, 'User', 'my files', 'my files', 'visible'
        FROM _conversation_message_attachments
        WHERE NOT EXISTS (SELECT 1 FROM folders WHERE context_id = author_id AND context_type = 'User' AND name = 'my files')
      SQL
  
      # and conversation attachment folders
      conn.execute <<-SQL
        INSERT INTO folders(context_id, context_type, name, full_name, workflow_state, parent_folder_id)
        SELECT DISTINCT author_id, 'User', 'conversation attachments', 'conversation attachments', 'visible', folders.id
        FROM _conversation_message_attachments, folders
        WHERE folders.context_id = author_id AND folders.context_type = 'User'
          AND NOT EXISTS (SELECT 1 FROM folders WHERE context_id = author_id AND context_type = 'User' AND name = 'conversation attachments')
      SQL
  
      conn.execute <<-SQL
        INSERT INTO attachment_associations(attachment_id, context_id, context_type)
        SELECT attachment_id, conversation_message_id, 'ConversationMessage'
        FROM _conversation_message_attachments
        WHERE author_id IS NOT NULL
      SQL
      cmas = conn.select_all("SELECT * FROM _conversation_message_attachments WHERE author_id IS NOT NULL")
      conn.execute "DROP TABLE _conversation_message_attachments"
    end

    cmas.group_by{ |r| r['conversation_message_id'] }.each_slice(1000) do |groups|
      conn.execute <<-SQL
        UPDATE conversation_messages
        SET attachment_ids = CASE id #{groups.map{ |id, rows| "WHEN #{id} THEN '#{rows.map{ |r| r['attachment_id'] }.join(",")}' "}.join} END
        WHERE id IN (#{groups.map(&:first).join(', ')})
      SQL
    end

    cmas.each_slice(1000) do |rows|
      attachment2user = "CASE attachments.id #{rows.map{ |r| "WHEN #{r['attachment_id']} THEN #{r['author_id']} "}.join} END"
      conn.execute <<-SQL
        UPDATE attachments
        SET context_type = 'User',
          context_id = #{attachment2user},
          folder_id = (SELECT f.id FROM folders f WHERE f.name = 'conversation attachments' AND f.context_type = 'User' AND f.context_id = #{attachment2user} LIMIT 1)
        WHERE attachments.id IN (
          #{rows.map{ |r| r['attachment_id'] }.join(', ')}
        )
      SQL
    end
  end
end
