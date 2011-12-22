module TempHelper
  
  def add_link_and_tags
    @req = Temp.new(:link => @temp["link"], :tags => @temp["tags"], :image_name => "#{@original_image_name}")
    if Temp.find_by_link(@temp["link"]).nil?
      @req.save
    end
  end
  
  def create_images
    @tempo  		 = 	Temp.first
    @url 		 = 	@tempo.link
    @uri		 = 	URI.parse(@url)
    @response		 = 	Net::HTTP.start(@uri.host, @uri.port) { |http| http.request_head(@uri.path) }  
    @original_image_name =	Digest::MD5.hexdigest(image_name())

    if url_file_extension != false && get_file_size
      @imageID = Temp.first.id
      download_image
      if server_file_type("images/original/#{@original_image_name}")
	convert_image
	return true
      end
      return false
    end
    return false
  end
  
end
