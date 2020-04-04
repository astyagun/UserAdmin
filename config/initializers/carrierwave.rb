CarrierWave.configure do |config|
  # NOTE: Should be cloud storage, but keeping it simple, since there's no need to deploy this app
  config.storage = :file
  config.enable_processing = !Rails.env.test?
end
