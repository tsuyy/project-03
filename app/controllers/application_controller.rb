class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper

  # def page_not_found
  #   render :file => "#{Rails.root}/public/404.html",  :status => 404
  # end

  def authorize!
    redirect_to root_path unless current_user
  end

end
