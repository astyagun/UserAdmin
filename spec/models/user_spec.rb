require 'rails_helper'

RSpec.describe User, type: :model do
  let(:instance) { build :user }

  describe 'validity' do
    subject { instance.valid? }

    it { is_expected.to be true }

    %i[role email full_name birth_date small_biography].each do |field|
      context "when ##{field} is nil" do
        before { instance[field] = nil }

        it { is_expected.to be false }
      end

      context "when ##{field} is an empty string" do
        before { instance[field] = '' }

        it { is_expected.to be false }
      end
    end

    context 'when #role is manager' do
      before { instance.role = 'manager' }

      it { is_expected.to be false }
    end

    context 'when #email is 123' do
      before { instance.email = 123 }

      it { is_expected.to be false }
    end

    context 'when #email is email' do
      before { instance.email = 'email' }

      it { is_expected.to be false }
    end

    context 'when #email is email@domain' do
      before { instance.email = 'email@domain' }

      it { is_expected.to be false }
    end

    context 'when user with the same email already exists' do
      before { create :user, email: instance.email }

      it { is_expected.to be false }
    end

    context 'when password is changed' do
      before { instance.assign_attributes password: password, password_confirmation: password_confirmation }

      let(:password) { '12345678' }
      let(:password_confirmation) { password }

      it { is_expected.to be true }

      context 'when changed to nil' do
        let(:password) { nil }

        it { is_expected.to be false }
      end

      context 'when changed to an empty string' do
        let(:password) { '' }

        it { is_expected.to be false }
      end

      context 'when changed to a string 7 characters long' do
        let(:password) { '1234567' }

        it { is_expected.to be false }
      end

      context 'and password_confirmation does not match it' do
        let(:password_confirmation) { '123' }

        it { is_expected.to be false }
      end
    end

    context 'when password is not changed (but some other field is changed)' do
      before { instance.small_biography = '123' }

      let(:instance) { described_class.find create(:user).id }

      it { is_expected.to be true }
    end
  end

  describe 'factory' do
    subject { build :user }

    it { is_expected.to be_valid }

    describe 'admin trait' do
      subject { build :user, :admin }

      it { is_expected.to be_valid }
    end
  end

  describe '#admin?' do
    subject { instance.admin? }

    it { is_expected.to be false }

    context 'when user is an admin' do
      before { instance.role = 'admin' }

      it { is_expected.to be true }
    end
  end
end
