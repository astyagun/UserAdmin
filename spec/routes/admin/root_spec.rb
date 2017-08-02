require 'rails_helper'

RSpec.describe 'Admin root path', type: :request do
  subject { get '/admin' }

  it { is_expected.to eq 302 }
  it { is_expected.to redirect_to admin_users_path }
end
