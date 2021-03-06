require 'rails_helper'

describe 'Users can CRUD tasks' do
  before :each do
    User.create(first_name: 'Missy', last_name: 'Louie', email: 'missy@mail.com', password: 'password', admin: true)
    visit '/signin'
    fill_in 'email', with: 'missy@mail.com'
    fill_in 'password', with: 'password'
    within('form') do
      click_on 'Sign In'
    end
    @task = Task.create(description: "First Task", due_date: '2015-03-20', project_id: 1)
    @project = Project.create(name: 'First Project')
  end

  scenario 'User can create Task' do
    visit project_task_path(@project, @task)
    expect(page).to have_content('First Task')
  end

  scenario 'User can edit Task' do
    visit project_task_path(@project, @task)
    click_on 'Edit'
    fill_in 'task[description]', with: 'Second Task'
    click_on 'Update Task'
    expect(page).to have_content('Second Task')
  end

  scenario 'User can delete Task' do
    visit project_task_path(@project, @task)
    click_on 'Delete'
    expect(page).to have_no_content('First Task')
  end

end
