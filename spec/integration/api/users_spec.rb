require 'spec_helper'

feature "/api/users API endpoint" do

  before(:all) { User.destroy_all }
  before do
    Fabricate(:user, :email => 'paul@rslw.com', :name => 'Paul Campbell')
  end
  
  scenario "create user" do
    post('/users.json', :user => {
      :email => 'kevin@rkn.la',
      :name => 'Kevin Nelson',
      :password => 'testing123'
    })
    result = ActiveSupport::JSON.decode(response.body)
    result['email'].should == 'kevin@rkn.la'
    result['id'].should_not == nil
    hasAuth = result.include?('authentication_token')
    hasAuth.should == true
  end
  
end