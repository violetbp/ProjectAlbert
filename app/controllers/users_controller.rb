class UsersController < ApplicationController
  
  def new
  end

  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
    @jobs = @user.jobs.order("problem_id")
    #Job.where("user_id = #{@user.id}").order("problem_id")
    
    @best = Array.new(Problem.last.id)#max id for problems! CHANGE TO HASHMAP LATER RATHER INNEFICIENT
    
    Problem.all.each do |p|
      @best[p.id] = @jobs.where("problem_id = #{p.id}").order("points").last
    end

  end
  
end
