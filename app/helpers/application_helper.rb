module ApplicationHelper
  BOOTSTRAP_FLASH_CLASSES = {notice: 'alert-success', alert: 'alert-danger'}.freeze

  def bootstrap_class_for_flash(type)
    BOOTSTRAP_FLASH_CLASSES.fetch type.to_sym, type.to_s
  end
end
