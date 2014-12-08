class ApplicationController < ActionController::Base
  before_action :set_problemsets
  before_action :set_users
  
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  
  include UsersHelper
  helper_method :current_user, :populate
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
  
  def populate(prob)
    numfiles = 3
    puts "making and populting directory  scripts/Problems/#{prob}"
    FileUtils::mkdir_p "scripts/Problems/#{prob}"
    for num in 1..numfiles
      inFile = File.new("scripts/Problems/#{prob}/#{num}.in", "w")
      puts "scripts/Problems/#{prob}/#{num}.in"
      outFile = File.new("scripts/Problems/#{prob}/#{num}.out", "w")
      inFile.close
      outFile.close
    end
    gradefile = File.new("scripts/Problems/#{prob}/graderData.conf", "w")
    gradefile.close
    File.open("scripts/Problems/#{prob}/graderData.conf", 'w') do |file|
      file.write("autograde=static\n")
      
      file.write("inputs=( ")
      for num in 1..numfiles
        file.write("'#{num}' ")
      end
      file.write(")\n")
      
      file.write("declare -A outputs\n")
      for num in 1..numfiles
        file.write("outputs['#{num}']='#{num}'\n")
      end
      
    end
  end
  ###############PROTECTED
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
  
  #not finished
  helper_method :authorize?  
  def authorized?
    current_user && (current_user == params[:id] || current_user.is_admin)
  end    
  helper_method :is_user_authorized?
  def is_user_authorized
    unless authorized?
      flash[:error] = "Unauthorized access";
      render_401
      false
    end
  end
  #end not finished

  
  
  
  private 
  def set_problemsets
    if current_user
      if admin?
        @problemsets = Problemset.all
      else
       @problemsets = current_user.problemsets
      end 
    else
      @problemsets = nil
    end  
  end
  
  def set_users
    @users = User.all
  end
  
end
