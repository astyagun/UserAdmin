require 'rails_helper'

RSpec.describe 'Authentication', type: :feature do
  xspecify 'allows user to register' do
    visit root_path

    fill_in 'Email'
  end

  context 'when user role is admin' do
    let(:user) { create :user, :admin }

    it 'logs user in and out' do
      log_in user

      expect(page).to have_content 'Logged in successfully'
      expect(page).to have_content 'Admin Dashboard'

      within '.navbar' do
        click_link 'Log out'
      end

      expect(page).to have_content 'Logged out successfully'
      within 'h1' do
        expect(page).to have_content 'Log in'
      end
    end
  end

  context 'when user role is user' do
    let(:user) { create :user }

    it 'logs user in and out' do
      log_in user

      expect(page).to have_content 'Logged in successfully'
      expect(page).to have_content 'Welcome'

      within '.navbar' do
        click_link 'Log out'
      end

      expect(page).to have_content 'Logged out successfully'
      within 'h1' do
        expect(page).to have_content 'Log in'
      end
    end

    context 'and incorrect credentials are entered' do
      it 'displays error message' do
        visit new_session_path
        fill_in 'Email', with: user.email + '123'
        fill_in 'Password', with: user.password
        click_button 'Log in'

        expect(page).to have_content 'Incorrect email or password'
      end
    end
  end
end
