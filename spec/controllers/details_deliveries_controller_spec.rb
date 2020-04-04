require 'rails_helper'

RSpec.describe DetailsDeliveriesController, type: :controller do
  describe '#create' do
    subject(:controller_action) { post :create, params: {'user_id' => inspected_user.id} }

    before do
      allow(admin_mailer).to receive(:user_details).and_return(message_delivery)
      allow(message_delivery).to receive :deliver_later
      log_in user
    end

    let(:admin_mailer) { class_double('AdminMailer').as_stubbed_const }
    let(:message_delivery) { instance_double ActionMailer::MessageDelivery }
    let(:role) { 'admin' }
    let(:user) { create(:user, role: role) }
    let(:inspected_user) { create :user }

    it 'passes requested user to the mailer and calls .deliver_later on the mailer', :aggregate_failures do
      controller_action
      expect(admin_mailer).to have_received(:user_details).with(inspected_user)
      expect(message_delivery).to have_received :deliver_later
    end

    it 'sets flash notice' do
      expect { controller_action }.to change(flash, :notice)
        .from(nil).to('Email delivery was scheduled successfully')
    end

    it { is_expected.to redirect_to admin_user_path inspected_user }

    context 'when user is not logged in' do
      before { log_out }

      it { is_expected.to redirect_to new_session_path }

      it 'sets flash alert message' do
        expect { controller_action }.to change(flash, :alert).from(nil).to('Please log in first')
      end
    end

    context 'when user role is user' do
      let(:role) { 'user' }

      it { is_expected.to redirect_to root_path }

      it 'sets flash alert message' do
        expect { controller_action }.to change(flash, :alert)
          .from(nil).to('Please log in as administrator to access that page')
      end
    end

    context 'when wrong user_id is given in params' do
      let(:inspected_user) { instance_double User, id: 1 }

      it 'raises error' do
        expect { controller_action }.to raise_exception ActiveRecord::RecordNotFound
      end
    end
  end
end
