class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(request.env["omniauth.auth"])
    session[:user_id] = user.id
    
    if user.uid = 104995822718249204458
      user.is_admin = true
      user.save
    end
    
    unless user.groups.exists?(Group.find(1))
      user.groups << Group.find(1)# ADD ALL USERS THAT LOG IN TO THIS GROUP
    end
    
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
