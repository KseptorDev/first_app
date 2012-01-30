module TempHelper
  
  def create_images
      @tempo  		 = 	Temp.first
      @uri		 = 	URI.parse(@tempo.link)
      @response		 = 	Net::HTTP.start(@uri.host, @uri.port) { |http| http.request_head(@uri.path) }  
      image_name?
      @original_image_name = 	@tempo.image_name
      if url_file_extension != false && get_file_size
	@imageID = Temp.first.id
	download_image
	if server_file_type("public/images/original/#{@original_image_name}")
	  convert_image
	  add_linkID_tagsID
	  Temp.first.delete
	  return true
	end
	return false
      end
    return false
  end
  
  def image_name?
    if @tempo.image_name.nil?
      @tempo.update_attributes( :image_name => Digest::MD5.hexdigest(image_name(@tempo.link)))
    end
  end

  def url_file_extension
    if  @response["content-type"].match(/image/)
      return true
    end
      return false
  end 

  def get_file_size
    file_size = @response["content-length"].to_i  
    if file_size >1 && file_size < 5242880 then
      return true
    else
      return false
    end
  end

  def download_image
    Net::HTTP.start(@uri.host, @uri.port) do |http|
	if http.head(@uri.request_uri).code == "200"
	resp = http.get(@tempo.link)
	open("public/images/original/#{@original_image_name}", "wb") do |file|
	    file.write(resp.body)
	end
      end
    end
  end 
   
  def server_file_type(path)
  content_type = `file --raw --brief "#{path}"`.chomp
    if content_type.match(/image|png|jpg|jpeg|gif/)
      return true
    else
      return false
    end
  end
  
  def convert_image
    @main  =  [small	=	["jpg","small",240,160], 
	       medium	=	["jpg","medium",640,427], 
	       large	=	["jpg","large",1024,683]]
    i = 0
    while i < @main.count
      resize_image(@main[i])
      i +=1
    end
  end

  def resize_image(params)
     width, height = params[2], params[3]
     img =  Magick::Image.read("public/images/original/#{@original_image_name}").first
     thumb = img.resize(width, height)
     thumb.write("public/images/#{params[1]}/#{@tempo.id}_#{params[1]}.#{params[0]}")
  end
  
  def add_linkID_tagsID
    i=0
    tag_link = [add_tag_return_IDs(@tempo.tags), add_link_return_ID(@tempo.link)]
    while i < tag_link[0].count
	Both.new(:tagID => (tag_link[0][i]), :linkID => (tag_link[1])).save
	i+=1
    end
  end
  
  def add_link_return_ID(link)
    if Link.find_by_link(link).nil?
      Link.new(:link => link).save
    end
    return Link.find_by_link(link).id
  end
  
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
  
  def image_name(url)
    i = 1
    until ((url.last i)["/"] == "/") do
      i +=1
    end
    return url.last i-1
  end          
  
end

