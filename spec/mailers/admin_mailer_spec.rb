require 'rails_helper'

RSpec.describe AdminMailer, type: :mailer do
  describe '.user_details' do
    subject(:email) { described_class.user_details user }

    let(:user) { build_stubbed :user }

    it 'sets email Subject header' do
      expect(email.subject).to eq "User Admin: details of user ##{user.id}"
    end

    it 'keeps email body empty' do
      expect(email.body).to eq ''
    end

    it 'sets email TO field' do
      expect(email.to).to eq ['recipient@example.com']
    end

    it 'adds a PDF attachment into email' do
      expect(email.attachments['User Admin - User details.pdf']).to have_attributes(
        content_type: 'application/pdf; filename="User Admin - User details.pdf"',
        filename: 'User Admin - User details.pdf'
      )
    end

    it 'can be delivered' do
      expect { email.deliver_now }.to change(ActionMailer::Base.deliveries, :count).by 1
    end

    it 'can be enqueued' do
      expect { email.deliver_later }.to change(enqueued_jobs, :count).by 1
    end
  end
end
