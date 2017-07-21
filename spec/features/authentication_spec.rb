require 'rails_helper'

RSpec.describe 'Authentication', type: :feature do
  specify 'allows admin to log in' do
    admin = create(:user, :admin)

    log_in admin

    expect(page).to have_content 'Logged in successfully'
    expect(page).to have_content 'Admin Dashboard'
  end

  specify 'allows user to register'
  specify 'allows user to log in'
end
