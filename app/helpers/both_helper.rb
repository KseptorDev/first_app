module BothHelper

  
  def find_tag_id(tags)
    tagIdList = []
    i = 0
    while i < tags.count do
      if !Teg.find_by_teg(tags[i]).nil?
	tagIdList << Teg.find_by_teg(tags[i]).id
      else
	tagIdList << nil
      end
      i+=1
    end
    return tagIdList
  end
  
  def find_links_id(tagId)
    linkIdList = []
    i = 1
    while i < Both.count + 1 do
      temp = Both.find(i)
      if tagId == temp.tagID
	linkIdList << temp.linkID
      end
      i += 1
    end
    return linkIdList
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
    images = [{"Small" => ["#{root_url}images/small/#{linkID}_small.jpg",@main[0][2],@main[0][3]]},
	      {"Medium" => ["#{root_url}images/medium/#{linkID}_medium.jpg",@main[1][2],@main[1][3]]},
	      {"Large"  => ["#{root_url}images/large/#{linkID}_large.jpg",@main[2][2],@main[2][3]]}]
    child  = [{"Created at" => Link.find(linkID).created_at }, {"Tags" => tags}, {"Images" => images}]
    return child
  end	
  
end