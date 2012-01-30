class TempController < ApplicationController
  def new
    @temp = Temp.new
  end
  
  def index
    @req = Temp.all
  end
  
  def add_link
   link = (params['link'])
   tags = (params['tags'])
    if !link.nil? && !tags.empty? 
      @temp = Temp.new(:link => link, :tags => tags, :image_name => Digest::MD5.hexdigest(image_name(link)))
      if Link.find_by_link(@temp.link).nil? && Temp.find_by_link(@temp.link).nil?
	if @temp.save 
	  @output = ":) You have added a new link! :)"
	end
      else
	@output = " ;) This link already exist!"
      end
    else
      @output = "You have no link or tags to add, sorry :("
    end
  end  
  
  def run
    create_images
  end
end