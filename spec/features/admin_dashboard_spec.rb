require 'rails_helper'

RSpec.describe 'Admin Dashboard', type: :feature do
  let(:admin) { create :user, :admin }

  specify 'Allows listing, viewing, editing and deleting users' do
    log_in admin

    # Index
    expect(page.current_path).to eq admin_users_path
    within('h1') { expect(page).to have_content 'Users' }

    expect(page).to have_content admin.role
    expect(page).to have_content admin.email
    expect(page).to have_content admin.full_name

    # Create
    user_attributes = attributes_for :user
    click_link 'New user'

    select user_attributes[:role], from: 'Role'
    fill_in 'Email',                 with: user_attributes[:email]
    fill_in 'Password',              with: user_attributes[:password], match: :prefer_exact
    fill_in 'Password confirmation', with: user_attributes[:password_confirmation], match: :prefer_exact
    fill_in 'Full name',             with: user_attributes[:full_name]
    fill_in 'Birth date',            with: user_attributes[:birth_date]
    fill_in 'Small biography',       with: user_attributes[:small_biography]

    click_button 'Create User'

    # Show
    within('h1') { expect(page).to have_content 'Show User #' }
    expect(page).to have_content user_attributes[:role]
    expect(page).to have_content user_attributes[:email]
    expect(page).to have_content user_attributes[:full_name]
    expect(page).to have_content user_attributes[:birth_date]
    expect(page).to have_content user_attributes[:small_biography]

    # Edit
    click_link 'Edit User #'

    new_biography = "#{user_attributes[:small_biography]} True story."
    fill_in 'Small biography', with: new_biography
    click_button 'Update User'

    expect(page).to have_content new_biography

    # Index

    within('.navigation') { click_link 'Users' }
    expect(page).to have_content user_attributes[:role]
    expect(page).to have_content user_attributes[:email]
    expect(page).to have_content user_attributes[:full_name]
  end
end
