class TegsController < ApplicationController
  
  def show
    @params = params['tag']
    if !@params.nil?
      @tegsID = if_tag_exist
      @i = 0
      while @i < @tegsID.count do
	@array = search_linkID_by_tagID(@tegsID[@i].id)
	@i +=1
      end
      @i = 0
      @finalList = []
      while @i < @array.count  do
	@finalList << create_List_of_links(@array[@i])
	@i +=1
      end
    end
  end
  
end
 