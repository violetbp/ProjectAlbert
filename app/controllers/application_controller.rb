class ApplicationController < ActionController::Base  
  before_action :set_problemsets
  before_action :set_users
  
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  
  include UsersHelper
  helper_method :current_user
  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end
  
  def render_401
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/401", :layout => false, :status => :not_found }
      format.xml  { head :not_found }
      format.any  { head :not_found }
    end
  end
  
  helper_method :admin?  
  protected
  def admin?
    current_user && current_user.is_admin
  end  
  def authorize
    unless admin?
      flash[:error] = "Unauthorized access";
      render_401
      false
    end
  end

  
  private 
  def set_problemsets
    if current_user
      @problemsets = current_user.problemsets
    else
      @problemsets = nil
    end  
  end
  
  def set_users
    @users = User.all
  end
  
end
