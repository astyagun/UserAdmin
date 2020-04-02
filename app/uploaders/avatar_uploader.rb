class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  process resize_to_fit: [200, 200]

  version(:thumbnail) { process resize_to_fit: [40, 40] }

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.id}/#{mounted_as}"
  end

  def default_url(*)
    ActionController::Base.helpers.asset_path(
      'fallback/' + [version_name, 'avatar', 'default.png'].compact.join('_')
    )
  end

  def extension_whitelist
    %w[jpg jpeg gif png]
  end

  def content_type_whitelist
    %r{image/}
  end
end
