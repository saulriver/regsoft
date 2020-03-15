class ApplicationController < ActionController::Base
    protect_from_forgery 
    before_action :authenticate_login!
    add_flash_types :danger, :info, :warning, :success
  
end
