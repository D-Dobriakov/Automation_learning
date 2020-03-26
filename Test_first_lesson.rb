require 'test/unit'
require 'selenium-webdriver'

class TestUserAction < Test::Unit::TestCase
  def setup
    @driver = Selenium::WebDriver.for :chrome
    @wait = Selenium::WebDriver::Wait.new(:timeout => 10)
  end

  #  def test_possitive
  #   register_user
  #   expected_text = 'Your account has been activated. You can now log in.'
  #   actual_text = @driver.find_element(:id, 'flash_notice').text
  #   assert_equal(expected_text, actual_text)
  # end

   # def test_login
   #   register_user
   #   user_name = @driver.find_element(:css, 'a.user.active').text
   #   logout
   #   @driver.find_element(:class, 'login').click
   #   @driver.find_element(:id, 'username').send_keys user_name
   #   @driver.find_element(:id, 'password').send_keys user_name
   #   @driver.find_element(:name, 'login').click
   #   assert(@driver.find_element(:class, 'logout').displayed?)
   # end

  # def test_change_password
  #   register_user
  #   user_passwd = @driver.find_element(:css, 'a.user.active').text
  #   @driver.find_element(:class, 'my-account').click
  #   @driver.find_element(:css, 'a.icon.icon-passwd').click
  #   @driver.find_element(:name, 'password').send_keys user_passwd
  #   user_passwd2 = 'paswqa'
  #   @driver.find_element(:name, 'new_password').send_keys user_passwd2
  #   @driver.find_element(:name, 'new_password_confirmation').send_keys user_passwd2
  #   @driver.find_element(:name, 'commit').click
  #   expected_text = 'Password was successfully updated.'
  #   actual_text = @driver.find_element(:id, 'flash_notice').text
  #   assert_equal(expected_text, actual_text)
  # end

  # def test_create_project
  #   register_user
  #   create_project
  #   expected_text = 'Successful creation.'
  #   actual_text = @driver.find_element(:id, 'flash_notice').text
  #   assert_equal(expected_text, actual_text)
  # end

   # def test_add_user_to_project
   #   register_user
   #   create_project
   #   add_user_to_project
   #   expected_text = 'Successful creation.'
   #   actual_text = @driver.find_element(:id, 'flash_notice').text
   #   assert_equal(expected_text, actual_text)
   # end

  def test_edit_user_role
    register_user
    create_project
    add_user_to_project
    sleep 3
    @driver.find_element(:css, 'a.icon.icon-edit').click
    sleep 3
    check_role('Developer')
    sleep 2
  end

  def register_user
    @driver.navigate.to 'http://demo.redmine.org'
    @driver.find_element(:class, 'register').click()

    login = 'login' + rand(9000).to_s

    @driver.find_element(:id, 'user_login').send_keys login
    @driver.find_element(:id, 'user_password').send_keys login
    @driver.find_element(:id, 'user_password_confirmation').send_keys login
    @driver.find_element(:id, 'user_firstname').send_keys login
    @driver.find_element(:id, 'user_lastname').send_keys login
    @driver.find_element(:id, 'user_mail').send_keys (login + '@rd.cr')
    @driver.find_element(:name, 'commit').click
  end

  def create_project
    project_name = 'Test' +rand(9000).to_s
     @driver.find_element(:class, 'projects').click
     @driver.find_element(:css, 'a.icon.icon-add').click
     @driver.find_element(:id, 'project_name').send_keys project_name
     @driver.find_element(:name, 'commit').click
  end

  def add_user_to_project
    @driver.find_element(:id, 'tab-members').click
    @driver.find_element(:css, 'a.icon.icon-add').click
    sleep 2
    @driver.find_element(:css, 'div#principals>*').click
    @driver.find_element(:css, 'div.roles-selection>*').click
    @driver.find_element(:css, 'input#member-add-submit').click
  end

  def logout
    @driver.find_element(:class, 'logout').click
  end

  def check_role(role_name)
    roles_elements = @driver.find_elements(:css, 'p')
    roles_data = {'Manager' => '3', 'Developer' => '4', 'Reporter' => '5'}
    value = roles_data[role_name]
    roles_elements.find{|el| el.value == value}.click
  end

   def teardown
      @driver.quit
  end

end
