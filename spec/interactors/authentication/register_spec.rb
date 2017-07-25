require 'rails_helper'

RSpec.describe Authentication::Register do
  describe '.call' do
    let(:user_attributes) { attributes_for :user }
    subject { described_class.call user_attributes }

    it { is_expected.to be_success }

    it 'creates a new user' do
      expect { subject }.to change(User, :count).by 1
    end

    it 'uses attributes provided' do
      subject
      expect(User.last).to have_attributes user_attributes.except(:role, :password, :password_confirmation)
    end

    context 'when user validation failed' do
      before { user_attributes[:full_name] = nil }

      it { is_expected.to be_failure }

      it 'does nor create a new user' do
        expect { subject }.not_to change(User, :count)
      end

      it 'returns the invalid user' do
        expect(subject.user).to be_a User
        expect(subject.user.email).to eq user_attributes[:email]
        expect(subject.user).to be_invalid
      end
    end
  end
end
