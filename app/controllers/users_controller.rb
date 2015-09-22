class UsersController < ApplicationController
  before_action :set_user,  only: [:show, :edit, :update, :destroy]
  before_filter :authorizeuser, :only => [:show ]
  before_filter :authorize, :only => [:index] #authenticates differently
  
  #dont think new should exist, purge later
  def new
    render_401
  end

  #dont really know where to put this return true
  def help
    respond_to do |format|
      format.html
      format.js
    end
    #render "application/_help.html.erb" 
  end

  def abou
    respond_to do |format|
      format.html
      format.js
    end
    #render "application/_help.html.erb" 
  end

  def join
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def joinclass
    if params[:code] == Settings.adminpass
      current_user.is_admin = true;
      current_user.save
      flash[:success] = "Set as admin"
      redirect_to root_path and return
    else
      Group.all.each do |g|
        if params[:code] == g.joincode
          unless g.users.exists?(current_user)#user not in group
            g.users << current_user
            g.save
            flash[:success] = "Code accepted"
          else                    #user in group
            flash[:success] = "You are already in that group"
            redirect_to root_path and return
          end
        end
      end
      flash[:error] = "Nope!"
      redirect_to root_path
    end
  end
  
  def index
    @users = User.all
  end
  
  def show
    @jobs = @user.jobs.order("problem_id")
    
    @best = @user.best   
  end
  
  def edit
    authorizeuser
  end
  
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  
  #############Private behind the scenes stuff#############  
  private

    # Use callbacks to share common setup or constraints between actions.
    # this is VERY usefull, its basicly the most importaint part
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      if admin? #cant set self as admin
        params.require(:user).permit(:name, :about, :image, :is_admin, :grade)
      else
        params.require(:user).permit(:about, :image, :grade)
      end
    end

    def authorizeuser
      unless admin? || current_user.id == @user.id #ADMINS CAN EDIT USERS
        puts "PREVENTED USER FROM EDITING OR VIEWING PROFILE "
        puts "current user: #{current_user.name}"
        puts "attempted access to user id user: #{@user.name}"
        #flash[:error] = "Unauthorized access";
        render_401
        true
      end
    end
  
end


