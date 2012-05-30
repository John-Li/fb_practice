class Image < ActiveRecord::Base
  attr_accessible :content_type, :file_name, :file_size, :path, :promotion_id
  include Rails.application.routes.url_helpers
  mount_uploader :file, ImageFileUploader
  belongs_to :promotion

  #one convenient method to pass jq_upload the necessary information
  def to_jq_upload
    {
      "name" => read_attribute(:file),
      "size" => file.size,
      "url" => file.url,
      "delete_url" => promotion_image_path(:promotion_id => promotion_id, :id => id),
      "delete_type" => "DELETE" 
    }
  end
end
