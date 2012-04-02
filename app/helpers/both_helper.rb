module BothHelper
#   def img_by_all_tags(total, linksID, tagsID)
#     i = 0 
#     found,temp = [], []
#     while i < linksID.count do
#       j = 0 
#       temp.clear
#       while j < tagsID.count do
# 	z = 1
# 	while z < Both.count + 1 do
# 	  both = Both.find(z)
# 	  if both.linkID == linksID[i]
# 	    if both.tagID == tagsID[j]
# 	      temp << both.tagID
# 	    end
# 	  end
# 	  if temp == tagsID
# 	    found << linksID[i]
# 	    z = Both.count + 1
# 	    if found.count >= total*3
# 	      return found
# 	    end
# 	  end
# 	  z +=1
# 	end
# 	j+=1
#       end
#       i+=1
#     end
#     return found
#   end
#   
#   def find_links_id(tagId, linksID)
#     i = 1
#     while i < Both.count + 1 do
#       temp = Both.find(i)
#       if tagId == temp.tagID && !linksID.include?(temp.linkID)
# 	linksID << temp.linkID
#       end
#       i += 1
#     end
#     return linksID
#   end
  
  def find_links_id(tags, total)
    linksID = []
    i = 0
    while i < tags.count
      linksID[i] = []
      i+=1
    end
    i = 1
    while i < Both.count + 1
      tmp = Both.find(i)
      j = 0
      while j < tags.count
	if tmp.tagID == tags[j]
	  if (isFull(linksID[j], total))
	    linksID[j] << tmp.linkID
	    if (!isFull(linksID.flatten,total*3))
	      return linksID.flatten
	    end
	  end
	end
	j+=1
      end
      i+=1
    end
    return linksID.flatten
  end
  
  def isFull(arr, max)
    if arr.count == max
      return false
    end
    return true
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
  
  def get_tagIDs_by_linkID(linkID)
    idList = []
    i = 1
    while i < Both.count + 1 do
      temp = Both.find(i)
      if linkID.include?(temp.linkID)
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
  
  def child_array(linksID)
    tags    =	get_tags_byID(get_tagIDs_by_linkID(linksID))
    objects =	Link.find(linksID)
    i = 0
    images = []
    while i < objects.count do   
      images <<  {:"#{objects[i].size}" => {:link => objects[i].image.url, :width => objects[i].width,:height => objects[i].height}}
      i+=1
    end
    child   =	{:created_at => objects[0].created_at, :tags => tags, :images => images}
    return child
  end	
  
  def father(lks,last,per_req)
    @output = []
    i=0
    same = []
    if last*3 < lks.count
      lks = lks[last*3..lks.count]
    else
      return nil
    end
    while i < lks.count && i/3 != per_req do 
      j = 0
      same.clear
      while j < lks.count do
	if Link.find(lks[i]).original == Link.find(lks[j]).original
	  same << lks[j]
	end
	j +=1
      end
      @output <<  child_array(same)
      i += 3
    end
  end
end




