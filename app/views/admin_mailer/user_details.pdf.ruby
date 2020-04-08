font_styles = {
  black:         'Black',
  black_italic:  'BlackItalic',
  bold:          'Bold',
  bold_italic:   'BoldItalic',
  italic:        'Italic',
  light:         'Light',
  light_italic:  'LightItalic',
  medium:        'Medium',
  medium_italic: 'MediumItalic',
  normal:        'Regular',
  thin:          'Thin',
  thin_italic:   'ThinItalic'
}.transform_values { |value| Rails.root.join('app', 'assets', 'fonts', "Roboto-#{value}.ttf") }

Prawn::Document.new do |pdf| # rubocop:disable Metrics/BlockLength
  pdf.font_families.update('Roboto' => font_styles)
  pdf.font 'Roboto'
  pdf.default_leading 5

  line_height = pdf.font_size + pdf.default_leading
  values_offset =
    pdf.width_of(User.human_attribute_name(@user.attributes.keys.max_by(&:length))) +
    line_height
  avatar_size = 200

  pdf.pad(line_height) { pdf.text "#{t 'application_name'}: user details", style: :bold, size: 24 }
  pdf.stroke_color '929292'
  pdf.stroke_horizontal_rule

  pdf.move_down line_height * 2

  if @user.avatar?
    pdf.text User.human_attribute_name(:avatar), style: :bold
    pdf.image(
      @user.avatar.path,
      at:  [values_offset, pdf.cursor + line_height],
      fit: [avatar_size, avatar_size]
    )
    pdf.move_down avatar_size
  end

  pdf.text User.human_attribute_name(:id), style: :bold
  pdf.text_box @user.id.to_s, at: [values_offset, pdf.cursor + line_height]

  pdf.text User.human_attribute_name(:role), style: :bold
  pdf.text_box @user.role, at: [values_offset, pdf.cursor + line_height]

  pdf.text User.human_attribute_name(:email), style: :bold
  pdf.text_box @user.email, at: [values_offset, pdf.cursor + line_height]

  pdf.text User.human_attribute_name(:full_name), style: :bold
  pdf.text_box @user.full_name, at: [values_offset, pdf.cursor + line_height]

  pdf.text User.human_attribute_name(:birth_date), style: :bold
  pdf.text_box I18n.l(@user.birth_date, format: :long), at: [values_offset, pdf.cursor + line_height]

  pdf.text User.human_attribute_name(:small_biography), style: :bold
  pdf.text_box @user.small_biography, at: [values_offset, pdf.cursor + line_height]
end.render
