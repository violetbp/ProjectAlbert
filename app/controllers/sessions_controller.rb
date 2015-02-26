class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(request.env["omniauth.auth"])
    session[:user_id] = user.id
    
    if user.uid.to_s == "104995822718249204458" #make victor admin
      user.is_admin = true
      user.save
    end
    
    if Group.find(1) && !user.groups.exists?(Group.find(1))
      user.groups << Group.find(1)# ADD ALL USERS THAT LOG IN TO EXAMPLE GROUP
    end #TODO make this optional? or maybe just a really good example on how to use software
    
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
