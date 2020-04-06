require 'test/unit'
require 'selenium-webdriver'
require_relative 'module'

class TestUserAction < Test::Unit::TestCase
  include OurModule
  def setup
    @driver = Selenium::WebDriver.for :chrome
    @wait = Selenium::WebDriver::Wait.new(:timeout => 10)
  end

   def test_registration
    register_user
    expected_text = 'Your account has been activated. You can now log in.'
    actual_text = @driver.find_element(:id, 'flash_notice').text
    assert_equal(expected_text, actual_text)
  end

   def test_login
     register_user
     user_name = @driver.find_element(:css, 'a.user.active').text
     logout
     @driver.find_element(:class, 'login').click
     @driver.find_element(:id, 'username').send_keys user_name
     @driver.find_element(:id, 'password').send_keys user_name
     @driver.find_element(:name, 'login').click
     assert(@driver.find_element(:class, 'logout').displayed?)
   end

  def test_change_password
    register_user
    user_passwd = @driver.find_element(:css, 'a.user.active').text
    @driver.find_element(:class, 'my-account').click
    @driver.find_element(:css, 'a.icon.icon-passwd').click
    @driver.find_element(:name, 'password').send_keys user_passwd
    user_passwd2 = 'paswqa'
    @driver.find_element(:name, 'new_password').send_keys user_passwd2
    @driver.find_element(:name, 'new_password_confirmation').send_keys user_passwd2
    @driver.find_element(:name, 'commit').click
    expected_text = 'Password was successfully updated.'
    actual_text = @driver.find_element(:id, 'flash_notice').text
    assert_equal(expected_text, actual_text)
  end

  def test_create_project
    register_user
    create_project
    expected_text = 'Successful creation.'
    actual_text = @driver.find_element(:id, 'flash_notice').text
    assert_equal(expected_text, actual_text)
  end

   def test_add_user_to_project
     register_user
     create_project
     add_user_to_project
     expected_text = 'Successful creation.'
     actual_text = @driver.find_element(:id, 'flash_notice').text
     assert_equal(expected_text, actual_text)
   end

  def test_edit_user_role
    register_user
    create_project
    sleep 3
    @driver.find_element(:id, 'tab-members').click
    @driver.find_element(:css, 'a.icon.icon-edit').click
    sleep 3
    check_role('Manager')
    check_role('Developer')
    sleep 2
    @driver.find_element(:css, 'input.small').click
    assert(@driver.find_element(:css, 'a.icon.icon-edit').displayed?)
  end

  def test_create_project_version
    register_user
    create_project
    create_project_version
    expected_text = 'Successful creation.'
    actual_text = @driver.find_element(:id, 'flash_notice').text
    assert_equal(expected_text, actual_text)
  end

  def test_create_new_bug
    register_user
    create_project
    @driver.find_element(:class, 'new-issue').click
    @driver.find_element(:id, 'issue_tracker_id').click
    select_issue_type('Bug')
    assert(@driver.find_element(:id, 'flash_notice').displayed?)
  end

  def test_create_new_feature
    register_user
    create_project
    @driver.find_element(:class, 'new-issue').click
    @driver.find_element(:id, 'issue_tracker_id').click
    select_issue_type('Feature')
    assert(@driver.find_element(:id, 'flash_notice').displayed?)
  end

  def test_create_new_support_issue
    register_user
    create_project
    @driver.find_element(:class, 'new-issue').click
    @driver.find_element(:id, 'issue_tracker_id').click
    select_issue_type('Support')
    assert(@driver.find_element(:id, 'flash_notice').displayed?)
  end

end
