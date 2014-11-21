class GroupsController < ApplicationController
  before_action :set_group,  only: [:show, :edit, :update, :destroy]
  before_filter :authorize, :except => [:index, :show ]

  def new
    @group =  Group.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def index
    @groups = Group.all
  end
  
  # GET /groups/1/edit
  def edit
    @group.problemsets.each do |problemset|
      params[:"#{problemset.id}"]
    end
    @group.users.each do |user|
      params[:"#{user.id}"]
    end
  end
  
  def show
    @group = Group.find(params[:id])
    
    
    
    #@jobs = Job.where("user_id = #{@group.users.each.id}").order("problem_id")
    
    #@best = Array.new(Problem.last.id)#max id for problems! CHANGE TO HASHMAP LATER RATHER INNEFICIENT
    
    
    #Problem.all.each do |p|
    #  @best[p.id] = @jobs.where("problem_id = #{p.id}").order("points").last
    #end
    

  end
  
  
  #############Create and update#############
  #can i make this more efficenet
   
  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)
    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
    else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
    end
  end
  end
  
  # POST/PUT /groups/1
  # POST/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
        @group.users.clear
        User.all.each do |user|
          if params[:"u#{user.id}"]
            @group.users << user
          end
        end
        @group.problemsets.clear
        Problemset.all.each do |problemset|
          if params[:"p#{problemset.id}"]
            @group.problemsets << problemset
          end
        end
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end
  
  
  #############Private behind the scenes stuff#############
  private
  # Use callbacks to share common setup or constraints between actions.
  # this is VERY usefull, its basicly the most importaint part
  def set_group
    @group = Group.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def group_params
    params.require(:group).permit(:title, :explanation, :teacher)
  end
  
end
