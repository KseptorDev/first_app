class BothController < ApplicationController
  def new
    @both = Both.new
  end
  
  def show
    if !params['tag'].nil?
      tags = params['tag']
      @tagsID = find_tag_id(tags)
      @linksID = []
      if !@tagsID.empty?
	i = 0
	while i < tags.count do
	  find_links_id(@tagsID[i])
	  i +=1
	end
      end
      father(img_by_all_tags).to_json.html_safe
    end
    respond_to do |format|
      format.html
      format.json { render :json => @output}
    end
  end 
end

