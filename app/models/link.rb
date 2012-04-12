class Link < ActiveRecord::Base
  # Include the uploader
  mount_uploader :image, ImageUploader
  
end
