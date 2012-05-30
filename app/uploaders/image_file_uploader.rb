class ImageFileUploader < CarrierWave::Uploader::Base
  storage :file
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    "/assets/fallback/" + [version_name, "default.jpg"].compact.join('_')
  end
  include CarrierWave::MiniMagick
  process :resize_to_fill => [1980, 300]

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg)
  end
end