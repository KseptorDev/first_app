class Link < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  
end
