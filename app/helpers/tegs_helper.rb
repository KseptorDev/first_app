module TegsHelper
  
  def if_tag_exist
    @i = 0
    tegsID = []
    while @i < @params.count  do
      if !Teg.find_by_teg(@params[@i]).nil?
	tegsID << Teg.find_by_teg(@params[@i])
      end
      @i +=1
    end
    return tegsID
  end
  
  def add_tag_return_IDs(tag)
    @tags = tag.split(",").collect{|x| x.strip}
    @i = 0
    @IDs = []
    while  @i < @tags.count  do
      @ta = Teg.new(:teg => @tags[@i])
      if @ta.save
	@IDs << Teg.find(@ta).id
      end
      @i +=1
    end
    return @IDs
  end
  
  def if_tag_exist?(tag)
    
  end
  
end