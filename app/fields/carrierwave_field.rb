require 'administrate/field/base'

class CarrierwaveField < Administrate::Field::Base
  delegate :url, to: :data

  def thumbnail_url
    data.url(:thumbnail)
  end

  def to_s
    data
  end
end
