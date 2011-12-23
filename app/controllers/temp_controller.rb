class TempController < ApplicationController
  
  def new
    @temp = Temp.new
  end
  
  def show
    create_images 
  end
  
  def url_file_extension
     if  @response['content-type'].match(/image/)
       return true
     end
       return false
  end 
   
#   def get_file_type(str) # cut last 4 char and check it
#     last = ""
#     i = 1
#     while !(str.last i ).match(/image|png|jpg|jpeg|gif/) do
#       if (str.last i)["/"] == "/"
# 	return false
#       end
#       i +=1
#     end
#     return str.last i
#   end
  
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
	  resp = http.get(@url)
	  open("images/original/#{@original_image_name}", "wb") do |file|
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
      i = 0
      main = [small	=	["jpg","small",240,160], 
	       medium	=	["jpg","medium",640,427], 
	       large	=	["jpg","large",1024,683]]
      while i < main.count
	resize_image(main[i])
	i +=1
      end
  end

  def resize_image(params)
     width, height = params[2], params[3]
     img =  file.read("images/original/#{@original_image_name}").first
     thumb = img.resize(width, height)
     thumb.write("images/#{params[1]}/#{@tempo.id}_#{params[1]}.#{params[0]}")
  end
  
  def image_name()
    i = 1
    until ((@url.last i)["/"] == "/") do
      i +=1
    end
    return @url.last i-1
  end          
end

