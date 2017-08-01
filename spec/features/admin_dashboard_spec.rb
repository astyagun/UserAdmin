require 'rails_helper'

# rubocop:disable RSpec/ExampleLength, RSpec/MultipleExpectations
RSpec.describe 'Admin Dashboard', type: :feature do
  let(:admin) { create :user, :admin }

  it 'allows listing, viewing, editing and deleting users' do
    log_in admin

    # Index
    expect(page.current_path).to eq admin_users_path
    within('h1') { expect(page).to have_content 'Users' }

    expect(page).to have_css "img[src*='thumbnail_avatar_default']"
    expect(page).to have_content admin.role
    expect(page).to have_content admin.email
    expect(page).to have_content admin.full_name

    # Create
    user_attributes = attributes_for :user
    click_on 'New user'

    select user_attributes[:role],   from: 'Role'
    fill_in 'Email',                 with: user_attributes[:email]
    fill_in 'Password',              with: user_attributes[:password], match: :prefer_exact
    fill_in 'Password confirmation', with: user_attributes[:password_confirmation], match: :prefer_exact
    fill_in 'Full name',             with: user_attributes[:full_name]
    fill_in 'Birth date',            with: user_attributes[:birth_date]
    fill_in 'Small biography',       with: user_attributes[:small_biography]
    attach_file 'Avatar',            Rails.root.join('spec', 'files', 'avatar.jpg')

    click_on 'Create User'

    # Show
    within('h1') { expect(page).to have_content 'Show User #' }
    expect(page).to have_css "img[src$='avatar.jpg']"
    expect(page).to have_content User.last.id
    expect(page).to have_content user_attributes[:role]
    expect(page).to have_content user_attributes[:email]
    expect(page).to have_content user_attributes[:full_name]
    expect(page).to have_content user_attributes[:birth_date]
    expect(page).to have_content user_attributes[:small_biography]

    # Edit
    click_on 'Edit User #'

    new_biography = "#{user_attributes[:small_biography]} True story."
    fill_in 'Small biography', with: new_biography
    click_on 'Update User'

    expect(page).to have_content new_biography

    # Index

    within('.navigation') { click_on 'Users' }
    expect(page).to have_css "img[src$='thumbnail_avatar.jpg']"
    expect(page).to have_content user_attributes[:role]
    expect(page).to have_content user_attributes[:email]
    expect(page).to have_content user_attributes[:full_name]
  end

  it 'allows to send a PDF with user details' do
    user = create :user, :with_avatar

    log_in admin

    click_on user.email
    perform_enqueued_jobs do
      expect do
        click_on 'Send user details by email'
        expect(page).to have_content 'Email delivery was scheduled successfully'
      end.to change(ActionMailer::Base.deliveries, :count).by 1
    end

    # Check Email
    email = ActionMailer::Base.deliveries.last

    expect(email.subject).to eq "User Admin: details of user ##{user.id}"
    expect(email.to).to eq ['recipient@example.com']

    pdf_file = email.attachments['User Admin - User details.pdf'].read
    pdf = PDF::Inspector::Text.analyze(pdf_file).strings.join(' ')

    expect(pdf).to have_content user.id
    expect(pdf).to have_content user.email
    expect(pdf).to have_content user.role
    expect(pdf).to have_content user.full_name
    expect(pdf).to have_content I18n.l(user.birth_date, format: :long)
    expect(pdf).to have_content user.small_biography

    images = PDF::Inspector::XObject.analyze(pdf_file).page_xobjects.first
    expect(images.count).to eq 1
  end
end
