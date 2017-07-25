require 'rails_helper'

RSpec.describe 'Authentication', type: :feature do
  describe 'registration' do
    let(:user_attributes) { attributes_for :user }
    subject do
      visit root_path
      within '.navbar' do
        click_link 'Register'
      end

      fill_in 'Email', with: user_attributes[:email]
      fill_in 'Password', with: user_attributes[:password], match: :prefer_exact
      fill_in 'Password confirmation', with: user_attributes[:password], match: :prefer_exact
      fill_in 'Full name', with: user_attributes[:full_name]
      fill_in 'Birth date', with: user_attributes[:birth_date]
      fill_in 'Small biography', with: user_attributes[:small_biography]
      click_button 'Register'
    end

    it 'registers user' do
      subject

      expect(page).to have_content 'Registration was successful'
      within '.content' do
        expect(page).to have_content 'Log in'
      end
    end

    context 'when invalid data is entered' do
      before { user_attributes.delete :full_name }

      it 'displays error message' do
        subject

        expect(page).to have_content 'Error performing registration'
        within '.content' do
          expect(page).to have_content 'Register'
        end
      end
    end
  end

  describe 'logging in and loggin out' do
    let(:user) { create :user, role: role }

    context 'when user role is admin' do
      let(:role) { 'admin' }

      it 'logs user in and out' do
        log_in user

        expect(page).to have_content 'Logged in successfully'
        expect(page).to have_content 'Admin Dashboard'

        within '.navbar' do
          click_link 'Log out'
        end

        expect(page).to have_content 'Logged out successfully'
        within '.content' do
          expect(page).to have_content 'Log in'
        end
      end
    end

    context 'when user role is user' do
      let(:role) { 'user' }

      it 'logs user in and out' do
        visit new_session_path
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        click_button 'Log in'

        expect(page).to have_content 'Logged in successfully'
        expect(page).to have_content 'Welcome'

        within '.navbar' do
          click_link 'Log out'
        end

        expect(page).to have_content 'Logged out successfully'
        within '.content' do
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
end
