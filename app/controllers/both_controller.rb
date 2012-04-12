class BothController < ApplicationController
  
  def new
    @both = Both.new
  end
  
  def wall
    @title = "Gallery - Wall"
    # Checks the get request if empty
    if !params['tag'].nil?
      # Requests tags from Users request and find the ID of those tags
      tags 	= find_tag_id(params['tag'].split(","))
      # Requests the rest of the parameters and convert them to integer
      per_req 	= params['per_req'].to_i 	# number of imeges, to find per request
      last 	= params['last'].to_i 		# the last image that was found in the last request (Default 0)
      total 	= params['total'].to_i 		# total number of images
      linksID 	= []
      if !tags.empty?
	# Find the ID of the Links that relate to this tag/s
	linksID = find_links_id(tags,total)
      end
      #G enerates the json response
      father(linksID,last,per_req)
    end
    # Sends the result in Json format, with the possibility of callback function
    respond_to do |format|
      format.html
      format.json { render :json => @output.to_json, :callback => params[:callback]}
    end 
  end
  
  def index
    
  end
  
end

