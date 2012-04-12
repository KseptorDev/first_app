class ApplicationController < ActionController::Base
  protect_from_forgery
  include BothHelper
  include TegsHelper
  include LinksHelper
  include TempHelper
end
    

