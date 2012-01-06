class TempController < ApplicationController
  def new
    @temp = Temp.new
  end
  
  def index
    @req = Temp.all
  end
  
  def show
   @temp = Temp.new(params[:temp])
    if !@temp.link.nil? || !@temp.tags.nil? 
      if Link.find_by_link(@temp.link).nil? 
	@temp.update_attributes( :image_name => Digest::MD5.hexdigest(image_name(@temp.link)))
	@output = ":) You have added a new link! :)"
	@temp.save 
      else
	@output = " ;) This link already exist!"
      end
    else
      @output = "You have no link to add, sorry :("
    end
  end  
  
end