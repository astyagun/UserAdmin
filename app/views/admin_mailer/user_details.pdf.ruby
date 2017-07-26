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

Prawn::Document.new do |pdf|
  pdf.font_families.update('Roboto' => font_styles)
  pdf.font 'Roboto'
  pdf.default_leading 5

  line_height = pdf.font_size + pdf.default_leading
  values_offset = pdf.width_of 'Small biography:    '

  pdf.pad(20) { pdf.text "#{t 'application_name'}: user details", style: :bold, size: 32 }
  pdf.stroke_horizontal_rule

  pdf.pad_top(40) { pdf.text 'ID:', style: :bold }
  pdf.text_box @user.id.to_s, at: [values_offset, pdf.cursor + line_height]

  pdf.text 'Role:', style: :bold
  pdf.text_box @user.role, at: [values_offset, pdf.cursor + line_height]

  pdf.text 'Email:', style: :bold
  pdf.text_box @user.email, at: [values_offset, pdf.cursor + line_height]

  pdf.text 'Full name:', style: :bold
  pdf.text_box @user.full_name, at: [values_offset, pdf.cursor + line_height]

  pdf.text 'Birth date:', style: :bold
  pdf.text_box I18n.l(@user.birth_date, format: :long), at: [values_offset, pdf.cursor + line_height]

  pdf.text 'Small biography:', style: :bold
  pdf.text_box @user.small_biography, at: [values_offset, pdf.cursor + line_height]
end.render
