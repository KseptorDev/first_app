module TegsHelper
   
  def add_tag_return_IDs(tag)
    tags = tag.split(",").collect{|x| x.strip}
    i = 0
    @IDs = []
    while  i < tags.count  do
      if Teg.find_by_teg(tags[i]).nil?
	Teg.new(:teg => tags[i]).save
      end
      @IDs << Teg.find_by_teg(tags[i]).id
      i +=1
    end
    return @IDs
  end
  
end