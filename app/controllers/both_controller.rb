class BothController < ApplicationController
  def new
    @both = Both.new
  end
  
  def show
    if !params['tag'].nil?
      tags 	= find_tag_id(params['tag'].split(","))
      per_req 	= params['per_req'].to_i
      last 	= params['last'].to_i
      total 	= params['total'].to_i
      linksID 	= []
      if !tags.empty?
	  linksID = find_links_id(tags,total)
      end
      father(linksID,last,per_req)
    end
    respond_to do |format|
      format.html
      format.json { render :json => @output.to_json, :callback => params[:callback]}
    end
  end
  
  def index
    
  end
  
    def auto_launch
    
  end
end

