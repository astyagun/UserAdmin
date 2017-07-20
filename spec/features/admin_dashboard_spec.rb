require 'rails_helper'

RSpec.describe 'Admin Dashboard', type: :feature do
  let(:admin) { create :user, :admin }

  specify 'Allows listing, viewing, editing and deleting users' do
    log_in admin

    expect(page.current_path).to eq admin_users_path
    expect(page).to have_content 'Admin Dashboard'

    within 'table' do
      # TODO: Test, that other user data is shown
      expect(page).to have_content 'User1'
      expect(page).to have_content 'User2'
      expect(page).to have_content 'User3'
    end

    click 'Show'

    exepct(page).to have_content 'User1 details'
  end
end
