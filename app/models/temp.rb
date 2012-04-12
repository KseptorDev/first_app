class Temp < ActiveRecord::Base
  # validates link not empty
  validates :link, :presence => true
  # validates tags not empty
  validates :tags, :presence => true
  # validates tags only words, without space
  validates_format_of :tags, :with => /^[a-zA-Z,]*$/
				
end
