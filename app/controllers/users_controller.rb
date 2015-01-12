class UsersController < ApplicationController
  before_action :set_user,  only: [:show, :edit, :update, :destroy]
  before_filter :authorizeuser, :only => [:show ]
  before_filter :authorize, :only => [:index] #authenticates differently
  
  #dont think new should exist
  #def new  end

  def index
    @users = User.all
  end
  
  def show
    unless admin? || (current_user.id == params[:id])
      render_401
    end
    @jobs = @user.jobs.order("problem_id")
    
    @best = @user.best   
  end
  
  def edit
    authorizeuser(@user)
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
