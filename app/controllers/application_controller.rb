class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  before_action :authenticate_user!
  
  class NotAuthorized < StandardError; end
  rescue_from NotAuthorized do |exception|
    head :forbidden
  end
end
