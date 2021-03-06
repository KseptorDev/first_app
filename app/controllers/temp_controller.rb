class TempController < ApplicationController
  
  def new
    @temp = Temp.new
  end
  
  def index 
    @title = "Index of Images"
    @req = Temp.all
  end
  
  #Function that adds links to Temp DB
  def add_link
  #Requests the parameters
   link = (params['link']) # link
   tags = (params['tags']) # tag/s
    #Checks the get request if empty
    if !link.nil? && !tags.empty?  
      #Creates a new variable with the parameters of the link and generates encoded name to the image
      @temp = Temp.new(:link => link, :tags => tags, :image_name => Digest::MD5.hexdigest(image_name(link)))
      #Checks if the image is unique and saves it in the DB
      if Link.find_by_original(@temp.link).nil? && Temp.find_by_link(@temp.link).nil?
	if @temp.save 
	  @output = ":) You have added a new link! :)"
	end	
      end
    end  
  end  
  
  def run
    create_images
  end
  
  def destroy
    @req = Temp.find(params[:id])
    @req.delete
    respond_to do |format|
      format.html { redirect_to index_path }
    end
  end
end
