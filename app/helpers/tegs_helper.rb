module TegsHelper
  # Adds tags and returns ID
  def add_tag_return_IDs(tag)
    tags = tag.split(",").collect{|x| x.strip}
    i = 0
    iDs = []
    while  i < tags.count  do
      # Checks if the tag does not exist
      if Teg.find_by_teg(tags[i]).nil?
	Teg.new(:teg => tags[i]).save
      end
      iDs << Teg.find_by_teg(tags[i]).id
      i +=1
    end
    return iDs
  end
  
end