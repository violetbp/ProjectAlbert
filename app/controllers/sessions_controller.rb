class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(request.env["omniauth.auth"])
    session[:user_id] = user.id
    unless user.groups.exists?(Group.find(2))
      user.groups << Group.find(2)# ADD ALL USERS THAT LOG IN TO THIS GROUP
    end
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
