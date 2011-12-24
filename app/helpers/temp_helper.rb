module TempHelper
  
  def create_images
    @tempo  		 = 	Temp.first
    @uri		 = 	URI.parse(@tempo.link)
    @response		 = 	Net::HTTP.start(@uri.host, @uri.port) { |http| http.request_head(@uri.path) }  
    @original_image_name = 	@tempo.image_name

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
