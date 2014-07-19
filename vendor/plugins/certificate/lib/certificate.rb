#The plugin class.
module Certificate
	#Method that will be called on, 'void' parameter couldn't figure out a way to have no parameters.
  def certificate (certificate, name) 
    require('pdf_forms')
    #Where ever your PDF gem was installed
		#Gets the plugin settings for this plugin, from the settings page.
		!!(PluginSetting.settings_for_plugin(:certificate))
		settings = PluginSetting.settings_for_plugin(:certificate);
		if (settings == nil)
			return
		end
		#The indexes are from the _colored_div_tag_settings.html.erb, the names of the text_field's.
		pdf = settings['pdfLocation'] + certificate
    user = @current_user.name
    
    # adjust the pdftk path to suit your pdftk installation
    toolkit = "/usr/bin/pdftk"
    pdftk = PdfForms.new(toolkit,:flatten => true, :encrypt => true, :encrypt_options => 'allow Printing')

    # find out the field names that are present in form.pdf
    pdftk.get_field_names pdf
    
    # take form.pdf, set the 'foo' field to 'bar' and save the document to myform.pdf
    pdftk.fill_form pdf, "/var/www/canvas/public/pp/pdfs/" + name + " " + user + ".pdf", :NAME => user
  end

end
