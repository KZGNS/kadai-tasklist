
class ApplicationController < ActionController::Base
  #helperのlogged_inをもらう  
  include SessionsHelper

  #全てのコントローラーでlogged_inを求めるために必要    
    private

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
    
end

