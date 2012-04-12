module BothHelper
  # Finds links id by tags id
  def find_links_id(tags, total)
    linksID = []
    i = 0
    # Creates an array for each location in the current array with relation to the number of tags
    while i < tags.count
      linksID[i] = []
      i+=1
    end
    i = 1
    # Scans the database in order to find all the links with those tags
    while i < Both.count + 1
      tmp = Both.find(i)
      j = 0
      while j < tags.count
	if tmp.tagID == tags[j]
	  # Checks if reached maximum number of images with one of the tag
	  if (isFull(linksID[j], total))
	    linksID[j] << tmp.linkID
	    # Checks if reached maximum number of pictures with all tags
	    if (!isFull(linksID.flatten,total*3))
	      # Joins all the arrays together and returns them as one
	      return linksID.flatten
	    end
	  end
	end
	j+=1
      end
      i+=1
    end
    # Joins all the arrays together and returns them as one
    return linksID.flatten
  end

  def isFull(arr, max)
    # Checks if reached maximum number of images - returns false if true
    if arr.count == max
      return false
    end
    return true
  end
  
  # Finds tags id by tags
  def find_tag_id(tags)
    tagIdList = []
    i = 0
    # Scans the database in order to find all the tags id by tag
    while i < tags.count do
      t = Teg.find_by_teg(tags[i].strip)
      # If the tag exists, puts his id into array, else puts nil
      if !t.nil?
	tagIdList << t.id
      else
	tagIdList << nil
      end
      i+=1
    end
    # Returns the list of tags id
    return tagIdList
  end
  
  # Finds tags id by links id
  def get_tagIDs_by_linkID(linkID)
    idList = []
    i = 1
    # Scans the database in order to find all the tags id by links id
    while i < Both.count + 1 do
      temp = Both.find(i)
      if linkID.include?(temp.linkID)
	idList << temp.tagID
      end
      i += 1
    end
    # Returns the list of tags id
    return idList
  end
  
  # Finds tags by tags id
  def get_tags_byID(idList)
    idList = Teg.find(idList)
    i = 0
    tags = []
    # Scans the database in order to find all the tags by tags id
    while i< idList.count do
      tags << idList[i].teg
      i+=1
    end
    # Returns the list of tags
    return tags
  end
  
  # Creates child array with json for each image
  def child_array(linksID)
    # Scanning for tags that relate to the links
    tags    =	get_tags_byID(get_tagIDs_by_linkID(linksID))
    # Creates an array with image's data
    objects =	Link.find(linksID)
    i = 0
    images = []
    # Creates json for each image with its data - size, link, width, height
    while i < objects.count do   
      images <<  {:"#{objects[i].size}" => {:link => objects[i].image.url, :width => objects[i].width,:height => objects[i].height}}
      i+=1
    end
    # Adds the date and time, when the images was created and tags to those images
    child   =	{:created_at => objects[0].created_at, :tags => tags, :images => images}
    return child
  end	
  
  # Creates json for all images 
  def father(lks,last,per_req)
    @output = []
    i=0
    same = []
    # Begins to read the links from the last link that was sent on the last reply
    # if reached the end of the array return nil
    if last*3 < lks.count
      lks = lks[last*3..lks.count]
    else
      return nil
    end
    # Collects links of images with different sizes
    while i < lks.count && i/3 != per_req do 
      j = 0
      same.clear
      while j < lks.count do
	if Link.find(lks[i]).original == Link.find(lks[j]).original
	  same << lks[j]
	end
	j +=1
      end
      # Creates father array with json for all images 
      @output <<  child_array(same)
      i += 3
    end
  end
end




