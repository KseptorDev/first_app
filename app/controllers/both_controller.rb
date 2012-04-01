class BothController < ApplicationController
  def new
    @both = Both.new
  end
  
  def show
    if !params['tag'].nil?
      tags 	= params['tag']
      tags 	= tags.split(",")
      per_req 	= params['per_req'].to_i
      last 	= params['last'].to_i
      total 	= params['total'].to_i
      tagsID 	= find_tag_id(tags,total)
      linksID 	= []
      if !tagsID.empty?
	i = 0
	while i < tags.count and linksID.count <= total do
	  linksID +=find_links_id(tagsID[i],linksID)
	  i +=1
	end
      end
      father(img_by_all_tags(total, linksID, tagsID),last,per_req)
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

