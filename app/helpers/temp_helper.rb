module TempHelper
  # The main function that runs all the other functions
  def create_images
    if Temp.first != Temp.last
      @tempo  		   = 	Temp.first
      @uri		   = 	URI.parse(URI.encode(@tempo.link))
      @response		   = 	Net::HTTP.start(@uri.host, @uri.port) { |http| http.request_head(@uri.path) }  
      @original_image_name = 	@tempo.image_name
      # If file extension and file size valid - downloads image, converts it and delete the link from Both DB, after the process done
      if url_file_extension && get_file_size
	download_image
	if server_file_type("public/images/original/#{@original_image_name}")
	  convert_image
	  File.delete("public/images/original/#{@original_image_name}")
	  Temp.first.delete
	  return true
	end
	return false
      end
      return false
    end
  end
  
  # Check if image, if not - delete the link
  def url_file_extension
    if  @response["content-type"].match(/image/)
      return true
    end
      Temp.first.delete
      return false
  end 
  
  # Gets the file size, limit 5mb, if over - delete link
  def get_file_size
    file_size = @response["content-length"].to_i  
    if file_size >1 && file_size < 5242880 then
      return true
    else
      Temp.first.delete
      return false
    end
  end
  
  # Downloads the image to server 
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

  # Checks again the file type, after download. If not image - delete link
  def server_file_type(path)
  content_type = `file --raw --brief "#{path}"`.chomp
    if content_type.match(/image|png|jpg|jpeg|gif/)
      return true
    else
      Temp.first.delete
      return false
    end
  end
  
  # Converts images to 3 sizes - small, medium, large in jpg format
  def convert_image
    i = 0  
    main  =  [small	=	["jpg","small",240,160], 
	       medium	=	["jpg","medium",640,427], 
	       large	=	["jpg","large",1024,683]]
    while i < main.count
      # Runs the resize function with params to each size
      resize_image(main[i])
      i +=1
    end
  end

  # Resizes the images with params from above
  def resize_image(params)
    # The path of the image
     path = "public/images/#{params[1]}/#{@tempo.id}_#{params[1]}.#{params[0]}"
     # Read the image
     img =  Magick::Image.read("public/images/original/#{@original_image_name}").first
     # Resize and Crop the image
     target = Magick::Image.new(params[2], params[3])
     thumb = img.resize_to_fill!(params[2], params[3])
     target.composite(thumb, Magick::CenterGravity, Magick::CopyCompositeOp).write(path)
     # Insert the width and height into an object
     @tempo.width, @tempo.height = "#{params[2]}", "#{params[3]}"
     # Add the link and tags to its DB
     add_linkID_tagsID(path,params[1])
     # Delete the image after uploading it to the storage
     File.delete(path)
  end
  # Adds link id and tags id to the Both DB  
  def add_linkID_tagsID(path,size)
    i=0
    # Gets link id and tag id after adding link and tags to its db
    tag_link = [add_tag_return_IDs(@tempo.tags), add_link_return_ID(path,size)]
    while i < tag_link[0].count
	Both.new(:tagID => (tag_link[0][i]), :linkID => (tag_link[1])).save
	i+=1
    end
  end
  
  # Add the link, of the uploaded image, to Links DB and return its ID
  def add_link_return_ID(path,size)
     # Create an object with the parameters of the image
     image = Link.new( :original => @tempo.link, :width => @tempo.width, :height => @tempo.height, :size => size)
     # Upload the image to the storage
     image.image = File.open(path)
     image.save!
     image.link = image.image.url
     image.save
     # Return the id of the image
     return image.id
  end
  
  # Add the tags of the image to Tegs DB and return IDs
  def add_tag_return_IDs(tag)
    # Split and strip the tags
    tags = tag.split(",").collect{|x| x.strip}
    i = 0
    iDs = []
    while  i < tags.count  do
      # Check if tag exist, if not - add it
      if Teg.find_by_teg(tags[i]).nil?
	Teg.new(:teg => tags[i]).save
      end
      # Insert into array the id of the tag
      iDs << Teg.find_by_teg(tags[i]).id
      i +=1
    end
    # return the IDs
    return iDs
  end
  # Get the image name from url and returns it
  def image_name(url)
    i = 1
    until ((url.last i)["/"] == "/") do
      i +=1
    end
    return url.last i-1
  end          
  
end

