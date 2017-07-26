require 'rails_helper'

RSpec.describe 'admin_mailer/user_details', type: :view do
  subject :rendered_view do
    render
    PDF::Inspector::Text.analyze(rendered).strings.join(' ')
  end

  before { assign :user, user }
  let(:user) { build_stubbed :user }

  it 'renders user attributes', :aggregate_failures do
    %i[id role email full_name small_biography].each do |attribute|
      expect(rendered_view).to have_content user[attribute]
    end
    expect(rendered_view).to have_content I18n.l(user.birth_date, format: :long)
  end

  context 'when #small_biography has non-cp1252 compatible characters' do
    before { user.small_biography = 'Опа' }

    it 'renders without errors' do
      expect(rendered_view).to have_content user.small_biography
    end
  end
end
