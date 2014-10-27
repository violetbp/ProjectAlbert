class UsersController < ApplicationController
  
  def new
  end
  

  def index
    @users = User.all
  end
  # GET /users/1
  # GET /users/1.json
  def show
    
  end
end
