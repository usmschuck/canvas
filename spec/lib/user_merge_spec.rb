
require File.expand_path(File.dirname(__FILE__) + '/../sharding_spec_helper.rb')

describe UserMerge do
  describe 'with simple users' do
    let!(:user1) { user_model }
    let!(:user2) { user_model }
    let(:course1) { course(:active_all => true) }
    let(:course2) { course(:active_all => true) }

    it 'should delete the old user' do
      UserMerge.from(user2).into(user1)
      user1.reload
      user2.reload
      user1.should_not be_deleted
      user2.should be_deleted
    end

    it "should move pseudonyms to the new user" do
      user2.pseudonyms.create!(:unique_id => 'sam@yahoo.com')
      UserMerge.from(user2).into(user1)
      user2.reload
      user2.pseudonyms.should be_empty
      user1.reload
      user1.pseudonyms.map(&:unique_id).should be_include('sam@yahoo.com')
    end

    it "should move submissions to the new user (but only if they don't already exist)" do
      a1 = assignment_model
      s1 = a1.find_or_create_submission(user1)
      s2 = a1.find_or_create_submission(user2)
      a2 = assignment_model
      s3 = a2.find_or_create_submission(user2)
      user2.submissions.length.should eql(2)
      user1.submissions.length.should eql(1)
      UserMerge.from(user2).into(user1)
      user2.reload
      user1.reload
      user2.submissions.length.should eql(1)
      user2.submissions.first.id.should eql(s2.id)
      user1.submissions.length.should eql(2)
      user1.submissions.map(&:id).should be_include(s1.id)
      user1.submissions.map(&:id).should be_include(s3.id)
    end

    it "should move ccs to the new user (but only if they don't already exist)" do
      # unconfirmed => active conflict
      user1.communication_channels.create!(:path => 'a@usms.com')
      user2.communication_channels.create!(:path => 'A@usms.com') { |cc| cc.workflow_state = 'active' }
      # active => unconfirmed conflict
      user1.communication_channels.create!(:path => 'b@usms.com') { |cc| cc.workflow_state = 'active' }
      user2.communication_channels.create!(:path => 'B@usms.com')
      # active => active conflict
      user1.communication_channels.create!(:path => 'c@usms.com') { |cc| cc.workflow_state = 'active' }
      user2.communication_channels.create!(:path => 'C@usms.com') { |cc| cc.workflow_state = 'active' }
      # unconfirmed => unconfirmed conflict
      user1.communication_channels.create!(:path => 'd@usms.com')
      user2.communication_channels.create!(:path => 'D@usms.com')
      # retired => unconfirmed conflict
      user1.communication_channels.create!(:path => 'e@usms.com') { |cc| cc.workflow_state = 'retired' }
      user2.communication_channels.create!(:path => 'E@usms.com')
      # unconfirmed => retired conflict
      user1.communication_channels.create!(:path => 'f@usms.com')
      user2.communication_channels.create!(:path => 'F@usms.com') { |cc| cc.workflow_state = 'retired' }
      # retired => active conflict
      user1.communication_channels.create!(:path => 'g@usms.com') { |cc| cc.workflow_state = 'retired' }
      user2.communication_channels.create!(:path => 'G@usms.com') { |cc| cc.workflow_state = 'active' }
      # active => retired conflict
      user1.communication_channels.create!(:path => 'h@usms.com') { |cc| cc.workflow_state = 'active' }
      user2.communication_channels.create!(:path => 'H@usms.com') { |cc| cc.workflow_state = 'retired' }
      # retired => retired conflict
      user1.communication_channels.create!(:path => 'i@usms.com') { |cc| cc.workflow_state = 'retired' }
      user2.communication_channels.create!(:path => 'I@usms.com') { |cc| cc.workflow_state = 'retired' }
      # <nothing> => active
      user2.communication_channels.create!(:path => 'j@usms.com') { |cc| cc.workflow_state = 'active' }
      # active => <nothing>
      user1.communication_channels.create!(:path => 'k@usms.com') { |cc| cc.workflow_state = 'active' }
      # <nothing> => unconfirmed
      user2.communication_channels.create!(:path => 'l@usms.com')
      # unconfirmed => <nothing>
      user1.communication_channels.create!(:path => 'm@usms.com')
      # <nothing> => retired
      user2.communication_channels.create!(:path => 'n@usms.com') { |cc| cc.workflow_state = 'retired' }
      # retired => <nothing>
      user1.communication_channels.create!(:path => 'o@usms.com') { |cc| cc.workflow_state = 'retired' }

      UserMerge.from(user1).into(user2)
      user1.reload
      user2.reload
      user2.communication_channels.map { |cc| [cc.path, cc.workflow_state] }.sort.should == [
          ['A@usms.com', 'active'],
          ['B@usms.com', 'retired'],
          ['C@usms.com', 'active'],
          ['D@usms.com', 'unconfirmed'],
          ['E@usms.com', 'unconfirmed'],
          ['F@usms.com', 'retired'],
          ['G@usms.com', 'active'],
          ['H@usms.com', 'retired'],
          ['I@usms.com', 'retired'],
          ['a@usms.com', 'retired'],
          ['b@usms.com', 'active'],
          ['c@usms.com', 'retired'],
          ['d@usms.com', 'retired'],
          ['e@usms.com', 'retired'],
          ['f@usms.com', 'unconfirmed'],
          ['g@usms.com', 'retired'],
          ['h@usms.com', 'active'],
          ['i@usms.com', 'retired'],
          ['j@usms.com', 'active'],
          ['k@usms.com', 'active'],
          ['l@usms.com', 'unconfirmed'],
          ['m@usms.com', 'unconfirmed'],
          ['n@usms.com', 'retired'],
          ['o@usms.com', 'retired']
      ]
      user1.communication_channels.should be_empty
    end

    it "should move and uniquify enrollments" do
      enrollment1 = course1.enroll_user(user1)
      enrollment2 = course1.enroll_user(user2, 'StudentEnrollment', :enrollment_state => 'active')
      enrollment3 = StudentEnrollment.create!(:course => course1, :course_section => course1.course_sections.create!, :user => user1)
      enrollment4 = course1.enroll_teacher(user1)

      UserMerge.from(user1).into(user2)
      enrollment1.reload
      enrollment1.user.should == user2
      enrollment1.should be_deleted
      enrollment2.reload
      enrollment2.should be_active
      enrollment2.user.should == user2
      enrollment3.reload
      enrollment3.should be_invited
      enrollment4.reload
      enrollment4.user.should == user2
      enrollment4.should be_invited

      user1.reload
      user1.enrollments.should be_empty
    end

    it "should move and uniquify observee enrollments" do
      course2
      enrollment1 = course1.enroll_user(user1)
      enrollment2 = course1.enroll_user(user2)

      observer1 = user_model
      observer2 = user_model
      user1.observers << observer1 << observer2
      user2.observers << observer2
      ObserverEnrollment.count.should eql 3

      UserMerge.from(user1).into(user2)
      user1.observee_enrollments.should be_empty
      user2.observee_enrollments.size.should eql 3 # 1 deleted
      user2.observee_enrollments.active_or_pending.size.should eql 2
      observer1.observer_enrollments.active_or_pending.size.should eql 1
      observer2.observer_enrollments.active_or_pending.size.should eql 1
    end

    it "should move and uniquify observers" do
      observer1 = user_model
      observer2 = user_model
      user1.observers << observer1 << observer2
      user2.observers << observer2

      UserMerge.from(user1).into(user2)
      user1.reload
      user1.observers.should be_empty
      user2.reload
      user2.observers.sort_by(&:id).should eql [observer1, observer2]
    end

    it "should move and uniquify observed users" do
      student1 = user_model
      student2 = user_model
      user1.observed_users << student1 << student2
      user2.observed_users << student2

      UserMerge.from(user1).into(user2)
      user1.reload
      user1.observed_users.should be_empty
      user2.reload
      user2.observed_users.sort_by(&:id).should eql [student1, student2]
    end

    it "should move conversations to the new user" do
      c1 = user1.initiate_conversation([user, user]) # group conversation
      c1.add_message("hello")
      c1.update_attribute(:workflow_state, 'unread')
      c2 = user1.initiate_conversation([user]) # private conversation
      c2.add_message("hello")
      c2.update_attribute(:workflow_state, 'unread')
      old_private_hash = c2.conversation.private_hash

      UserMerge.from(user1).into(user2)
      c1.reload.user_id.should eql user2.id
      c1.conversation.participants.should_not include(user1)
      user1.reload.unread_conversations_count.should eql 0

      c2.reload.user_id.should eql user2.id
      c2.conversation.participants.should_not include(user1)
      c2.conversation.private_hash.should_not eql old_private_hash
      user2.reload.unread_conversations_count.should eql 2
    end

    it "should point other user's observers to the new user" do
      observer = user_model
      course1.enroll_student(user1)
      oe = course1.enroll_user(observer, 'ObserverEnrollment')
      oe.update_attribute(:associated_user_id, user1.id)
      UserMerge.from(user1).into(user2)
      oe.reload.associated_user_id.should == user2.id
    end
  end

  it "should update account associations" do
    account1 = account_model
    account2 = account_model
    pseudo1 = (user1 = user_with_pseudonym :account => account1).pseudonym
    pseudo2 = (user2 = user_with_pseudonym :account => account2).pseudonym
    subsubaccount1 = (subaccount1 = account1.sub_accounts.create!).sub_accounts.create!
    subsubaccount2 = (subaccount2 = account2.sub_accounts.create!).sub_accounts.create!
    course_with_student(:account => subsubaccount1, :user => user1)
    course_with_student(:account => subsubaccount2, :user => user2)

    user1.associated_accounts.map(&:id).sort.should == [account1, subaccount1, subsubaccount1].map(&:id).sort
    user2.associated_accounts.map(&:id).sort.should == [account2, subaccount2, subsubaccount2].map(&:id).sort

    pseudo1.user.should == user1
    pseudo2.user.should == user2

    UserMerge.from(user1).into(user2)

    pseudo1, pseudo2 = [pseudo1, pseudo2].map{|p| Pseudonym.find(p.id)}
    user1, user2 = [user1, user2].map{|u| User.find(u.id)}

    pseudo1.user.should == pseudo2.user
    pseudo1.user.should == user2

    user1.associated_accounts.map(&:id).sort.should == []
    user2.associated_accounts.map(&:id).sort.should == [account1, account2, subaccount1, subaccount2, subsubaccount1, subsubaccount2].map(&:id).sort
  end

  context "sharding" do
    specs_require_sharding

    it "should merge a user across shards" do
      user1 = user_with_pseudonym(:username => 'user1@example.com', :active_all => 1)
      p1 = @pseudonym
      cc1 = @cc
      @shard1.activate do
        account = Account.create!
        @user2 = user_with_pseudonym(:username => 'user2@example.com', :active_all => 1, :account => account)
        @p2 = @pseudonym
      end

      @shard2.activate do
        UserMerge.from(user1).into(@user2)
      end

      user1.should be_deleted
      p1.reload.user.should == @user2
      cc1.reload.should be_retired
      @user2.communication_channels.all.map(&:path).sort.should == ['user1@example.com', 'user2@example.com']
      @user2.all_pseudonyms.should == [@p2, p1]
      @user2.associated_shards.should == [@shard1, Shard.default]
    end

    it "should associate the user with all shards" do
      user1 = user_with_pseudonym(:username => 'user1@example.com', :active_all => 1)
      p1 = @pseudonym
      cc1 = @cc
      @shard1.activate do
        account = Account.create!
        @p2 = account.pseudonyms.create!(:unique_id => 'user1@exmaple.com', :user => user1)
      end

      @shard2.activate do
        account = Account.create!
        @user2 = user_with_pseudonym(:username => 'user2@example.com', :active_all => 1, :account => account)
        @p3 = @pseudonym
        UserMerge.from(user1).into(@user2)
      end

      @user2.associated_shards.sort_by(&:id).should == [Shard.default, @shard1, @shard2].sort_by(&:id)
      @user2.all_pseudonyms.sort_by(&:id).should == [p1, @p2, @p3].sort_by(&:id)
    end

    it "should move ccs to the new user (but only if they don't already exist)" do
      user1 = user_model
      @shard1.activate do
        @user2 = user_model
      end

      # unconfirmed => active conflict
      user1.communication_channels.create!(:path => 'a@usms.com')
      @user2.communication_channels.create!(:path => 'A@usms.com') { |cc| cc.workflow_state = 'active' }
      # active => unconfirmed conflict
      user1.communication_channels.create!(:path => 'b@usms.com') { |cc| cc.workflow_state = 'active' }
      @user2.communication_channels.create!(:path => 'B@usms.com')
      # active => active conflict
      user1.communication_channels.create!(:path => 'c@usms.com') { |cc| cc.workflow_state = 'active' }
      @user2.communication_channels.create!(:path => 'C@usms.com') { |cc| cc.workflow_state = 'active' }
      # unconfirmed => unconfirmed conflict
      user1.communication_channels.create!(:path => 'd@usms.com')
      @user2.communication_channels.create!(:path => 'D@usms.com')
      # retired => unconfirmed conflict
      user1.communication_channels.create!(:path => 'e@usms.com') { |cc| cc.workflow_state = 'retired' }
      @user2.communication_channels.create!(:path => 'E@usms.com')
      # unconfirmed => retired conflict
      user1.communication_channels.create!(:path => 'f@usms.com')
      @user2.communication_channels.create!(:path => 'F@usms.com') { |cc| cc.workflow_state = 'retired' }
      # retired => active conflict
      user1.communication_channels.create!(:path => 'g@usms.com') { |cc| cc.workflow_state = 'retired' }
      @user2.communication_channels.create!(:path => 'G@usms.com') { |cc| cc.workflow_state = 'active' }
      # active => retired conflict
      user1.communication_channels.create!(:path => 'h@usms.com') { |cc| cc.workflow_state = 'active' }
      @user2.communication_channels.create!(:path => 'H@usms.com') { |cc| cc.workflow_state = 'retired' }
      # retired => retired conflict
      user1.communication_channels.create!(:path => 'i@usms.com') { |cc| cc.workflow_state = 'retired' }
      @user2.communication_channels.create!(:path => 'I@usms.com') { |cc| cc.workflow_state = 'retired' }
      # <nothing> => active
      @user2.communication_channels.create!(:path => 'j@usms.com') { |cc| cc.workflow_state = 'active' }
      # active => <nothing>
      user1.communication_channels.create!(:path => 'k@usms.com') { |cc| cc.workflow_state = 'active' }
      # <nothing> => unconfirmed
      @user2.communication_channels.create!(:path => 'l@usms.com')
      # unconfirmed => <nothing>
      user1.communication_channels.create!(:path => 'm@usms.com')
      # <nothing> => retired
      @user2.communication_channels.create!(:path => 'n@usms.com') { |cc| cc.workflow_state = 'retired' }
      # retired => <nothing>
      user1.communication_channels.create!(:path => 'o@usms.com') { |cc| cc.workflow_state = 'retired' }

      @shard2.activate do
        UserMerge.from(user1).into(@user2)
      end

      user1.reload
      @user2.reload
      @user2.communication_channels.map { |cc| [cc.path, cc.workflow_state] }.sort.should == [
          ['A@usms.com', 'active'],
          ['B@usms.com', 'retired'],
          ['C@usms.com', 'active'],
          ['D@usms.com', 'unconfirmed'],
          ['E@usms.com', 'unconfirmed'],
          ['F@usms.com', 'retired'],
          ['G@usms.com', 'active'],
          ['H@usms.com', 'retired'],
          ['I@usms.com', 'retired'],
          ['b@usms.com', 'active'],
          ['f@usms.com', 'unconfirmed'],
          ['h@usms.com', 'active'],
          ['i@usms.com', 'retired'],
          ['j@usms.com', 'active'],
          ['k@usms.com', 'active'],
          ['l@usms.com', 'unconfirmed'],
          ['m@usms.com', 'unconfirmed'],
          ['n@usms.com', 'retired'],
          ['o@usms.com', 'retired']
      ]
      # on cross shard merges, the deleted user retains all CCs (pertinent ones were
      # duplicated over to the surviving shard)
      user1.communication_channels.map { |cc| [cc.path, cc.workflow_state] }.sort.should == [
          ['a@usms.com', 'retired'],
          ['b@usms.com', 'retired'],
          ['c@usms.com', 'retired'],
          ['d@usms.com', 'retired'],
          ['e@usms.com', 'retired'],
          ['f@usms.com', 'retired'],
          ['g@usms.com', 'retired'],
          ['h@usms.com', 'retired'],
          ['i@usms.com', 'retired'],
          ['k@usms.com', 'retired'],
          ['m@usms.com', 'retired'],
          ['o@usms.com', 'retired']
      ]
    end

    it "should not fail copying retired sms channels" do
      user1 = User.create!
      @shard1.activate do
        @user2 = User.create!
      end

      cc1 = @user2.communication_channels.sms.create!(:path => 'abc')
      cc1.retire!

      UserMerge.from(@user2).into(user1)
      user1.communication_channels.reload.length.should == 1
      cc2 = user1.communication_channels.first
      cc2.path.should == 'abc'
      cc2.workflow_state.should == 'retired'
    end

  end

end
