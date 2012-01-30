class Temp < ActiveRecord::Base
  attr_accessible :link, :tags, :image_name
  
  validates :link, :presence => true
  validates :tags, :presence => true
  validates_format_of :tags, :with => /^[a-zA-Z,]*$/
				
end
