require 'rails_helper'

# rubocop:disable RSpec/MultipleExpectations
RSpec.describe 'Authorization', type: :feature do
  describe 'visiting admin section' do
    subject(:visit_admin_section) { visit admin_root_path }

    context 'when logged in as user' do
      before { log_in create :user }

      it 'redirects to home page and renders a flash message' do
        visit_admin_section

        expect(page).to have_content 'Please log in as administrator to access that page'
        within('h1') { expect(page).to have_content 'Welcome' }
      end
    end

    context 'when logged in as admin' do
      before { log_in create(:user, :admin) }

      it 'renders admin section' do
        visit_admin_section
        within('h1') { expect(page).to have_content 'Users' }
      end
    end
  end

  describe 'visiting sidekiq' do
    subject(:visit_sidekiq) { visit sidekiq_web_path }

    context 'when logged in as user' do
      before { log_in create(:user) }

      it 'redirects to home page and renders a flash message' do
        visit_sidekiq

        expect(page).to have_content 'Please log in as administrator to access that page'
        within('h1') { expect(page).to have_content 'Welcome' }
      end
    end

    context 'when logged in as admin' do
      before { log_in create(:user, :admin) }

      it 'renders admin section' do
        visit_sidekiq
        within('.navbar-brand') { expect(page).to have_content 'Sidekiq' }
      end
    end
  end
end
