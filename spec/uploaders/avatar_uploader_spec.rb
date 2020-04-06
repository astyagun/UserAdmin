require 'rails_helper'
require 'carrierwave/test/matchers'

RSpec.describe AvatarUploader, type: :uploader do
  let(:user) { build_stubbed :user }
  let(:instance) { described_class.new(user, :avatar) }
  let(:path_to_file) { Rails.root.join 'spec/files/avatar.jpg' }

  before do
    described_class.enable_processing = true
    File.open(path_to_file) { |f| instance.store!(f) }
  end

  after do
    described_class.enable_processing = false
    instance.remove!
  end

  describe 'the original' do
    subject { instance }

    it { is_expected.to have_dimensions(200, 200) }
  end

  describe 'the thumbnail version' do
    subject { instance.thumbnail }

    it { is_expected.to have_dimensions(40, 40) }
  end
end
