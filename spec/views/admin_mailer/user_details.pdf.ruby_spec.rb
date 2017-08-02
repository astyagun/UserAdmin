require 'rails_helper'

RSpec.describe 'admin_mailer/user_details', type: :view do
  subject :rendered_view do
    render
    PDF::Inspector::Text.analyze(rendered).strings.join(' ')
  end

  before { assign :user, user }
  let(:user) { build_stubbed :user }
  let(:rendered_images) { PDF::Inspector::XObject.analyze(rendered).page_xobjects.first }

  it 'renders user attributes and no images', :aggregate_failures do
    %i[id role email full_name small_biography].each do |attribute|
      expect(rendered_view).to have_content user[attribute]
    end
    expect(rendered_view).to have_content I18n.l(user.birth_date, format: :long)
    expect(rendered_images.count).to eq 0
  end

  context 'when #small_biography has non-cp1252 compatible characters' do
    before { user.small_biography = 'Опа' }

    it 'renders without errors' do
      expect(rendered_view).to have_content user.small_biography
    end
  end

  context 'when user has an avatar' do
    let(:user) { build_stubbed :user, :with_avatar }

    it 'renders an image' do
      rendered_view
      expect(rendered_images.count).to eq 1
    end
  end
end
