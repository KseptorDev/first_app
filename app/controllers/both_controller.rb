class BothController < ApplicationController
  
  def new
    @both = Both.new
  end
  
  def show
    if !params['tag'].nil?
      @tags = params['tag']
      tagsID = find_tag_id(@tags)
      @linksID = []
      if !tagsID[0].nil?
	i = 0
	while i < @tags.count do
	  @linksID <<  find_links_id(tagsID[i])
	  i +=1
	end
      end
    end
  end
  
end

