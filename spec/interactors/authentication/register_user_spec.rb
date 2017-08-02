require 'rails_helper'

RSpec.describe Authentication::RegisterUser do
  describe '.call' do
    subject(:result) { described_class.call user_attributes }

    let(:user_attributes) { attributes_for :user }

    it { is_expected.to be_success }

    it 'creates a new user' do
      expect { result }.to change(User, :count).by 1
    end

    it 'uses attributes provided' do
      result
      expect(User.last).to have_attributes user_attributes.except(:password, :password_confirmation)
    end

    context 'when user validation failed' do
      before { user_attributes[:full_name] = nil }

      it { is_expected.to be_failure }

      it 'does nor create a new user' do
        expect { result }.not_to change(User, :count)
      end

      it 'returns the invalid user', :aggregate_failures do
        expect(result.user).to be_a User
        expect(result.user.email).to eq user_attributes[:email]
        expect(result.user).to be_invalid
      end
    end
  end
end
