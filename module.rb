require('pry')

module OurModule

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
    roles_elements = @driver.find_elements(:css, "td.roles input[name='membership[role_ids][]']")
    roles_elements.select{|el| el.attribute('checked') == 'checked'}.each(&:click)
    roles_data = {'Manager' => '3', 'Developer' => '4', 'Reporter' => '5'}
    value = roles_data[role_name]
    roles_elements.find{|el| el.attribute('value') == value}.click
  end

  def create_project_version
    version_name = 'version' + rand(9).to_s
    @driver.find_element(:id, 'tab-versions').click
    @driver.find_element(:css, '#tab-content-versions .icon.icon-add').click
    @driver.find_element(:css, 'input#version_name').send_keys version_name
    @driver.find_element(:name, 'commit').click
  end

  def select_issue_type(issue_type)
    issues_elements = @driver.find_elements(:css, '#issue_tracker_id option')
    issues_data = {'Bug' => '1', 'Feature' => '2', 'Support' => '3'}
    value = issues_data[issue_type]
    issues_elements.find{|el| el.attribute('value') == value}.click
    @driver.find_element(:id, 'issue_subject').send_keys 'Test'
    @driver.find_element(:name, 'commit').click
  end

  def teardown
    @driver.quit
  end

end


#Just to be able to create a pull request 