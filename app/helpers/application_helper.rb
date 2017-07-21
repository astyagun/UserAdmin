module ApplicationHelper
  BOOTSTRAP_FLASH_CLASSES = {notice: 'alert-success', alert: 'alert-danger'}

  def flash_messages
    flash.each do |type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(type)} fade in") do
        concat content_tag(:button, 'x', class: 'close', data: {dismiss: 'alert'})
        concat message
      end)
    end

    nil
  end

  def bootstrap_class_for(flash_type)
    BOOTSTRAP_FLASH_CLASSES.fetch flash_type.to_sym, flash_type.to_s
  end
end
