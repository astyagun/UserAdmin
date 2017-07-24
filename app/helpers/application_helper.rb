module ApplicationHelper
  BOOTSTRAP_FLASH_CLASSES = {notice: 'alert-success', alert: 'alert-danger'}

  def bootstrap_class_for(flash_type)
    BOOTSTRAP_FLASH_CLASSES.fetch flash_type.to_sym, flash_type.to_s
  end
end
