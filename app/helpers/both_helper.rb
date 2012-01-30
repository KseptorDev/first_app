module BothHelper
  def img_by_all_tags
    i = 0 
    found,temp = [], []
    while i < @linksID.count do
      j = 0 
      temp.clear
      while j < @tagsID.count do
	z = 1
	while z < Both.count + 1 do
	  both = Both.find(z)
	  if both.linkID == @linksID[i]
	    if both.tagID == @tagsID[j]
	      temp << both.tagID
	    end
	  end
	  z +=1
	end
	if temp == @tagsID
	  found << @linksID[i]
	end
	j+=1
      end
      i+=1
    end
    return found
  end
  
  def find_tag_id(tags)
    tagIdList = []
    i = 0
    while i < tags.count do
      if !Teg.find_by_teg(tags[i].strip).nil?
	tagIdList << Teg.find_by_teg(tags[i].strip).id
      else
	tagIdList << nil
      end
      i+=1
    end
    return tagIdList
  end
  
  def find_links_id(tagId)
    i = 1
    while i < Both.count + 1 do
      temp = Both.find(i)
      if tagId == temp.tagID && !@linksID.include?(temp.linkID)
	@linksID << temp.linkID
      end
      i += 1
    end
  end
  
  def get_tagIDs_by_linkID(linkID)
    idList = []
    i = 1
    while i < Both.count + 1 do
      temp = Both.find(i)
      if linkID == temp.linkID
	idList << temp.tagID
      end
      i += 1
    end
    return idList
  end
  
  def get_tags_byID(idList)
    idList = Teg.find(idList)
    i = 0
    tags = []
    while i< idList.count do
      tags << idList[i].teg
      i+=1
    end
    return tags
  end
  
  
  def child_array(linkID)
    @main  =  [small	=	["jpg","small",240,160], 
	       medium	=	["jpg","medium",640,427], 
	       large	=	["jpg","large",1024,683]]
    tags   = get_tags_byID(get_tagIDs_by_linkID(linkID))
    images = [{"small" => ["#{root_url}images/small/#{linkID}_small.jpg",@main[0][2],@main[0][3]]},
	      {"medium" => ["#{root_url}images/medium/#{linkID}_medium.jpg",@main[1][2],@main[1][3]]},
	      {"large"  => ["#{root_url}images/large/#{linkID}_large.jpg",@main[2][2],@main[2][3]]}]
    child  = {:created_at => Link.find(linkID).created_at }, {:tags => tags}, {:images => images}
    return child
  end	
  
  def father(found)
    @output = []
    i=0
    while i < found.count do 
      @output << child_array(found[i])
      i += 1
    end
  end
  

  
end