class ProblemsController < ApplicationController
  before_action :set_problem, only: [:show, :edit, :update, :destroy]

  require 'fileutils'
  def upload
    @shPath = File.join("public", "data", "gradingtesting")
    @shPath = File.join("public", "data", "gradingtesting")
    @username = current_user.name.tr(' ','_') #without spaces so the sh will run
    
    save(params[:script], params[:problem_id], @username)
  	#will the next line work? from list of problems get the one pertaining to this specific problem
    @job = self.create_job(params[:problem_id], params[:script].original_filename)
    
    #runs file, puts output in res somehow
    res = IO.popen("bash albert.sh #{@job.file_path} grades/testing")
    @result = res.readlines.to_s

  	respond_to do |format|
  		format.js
  	end
  end
    
  def create_job(problem_id, file_in)
    job = Job.new(file_path: File.join(get_workspace_for_problem(problem_id), file_in), 
      problem_id: problem_id, user_id: current_user.id)
    job.save()
    job
  end
  
  def save(script, problem_id, name)
    directory = get_workspace_for_problem(problem_id)
    FileUtils::mkdir_p directory
    # create the file path
    path = File.join(directory, script.original_filename)
    # write the file
    File.open(path, "wb") { |f| f.write(script.read) }
  end
    
  def get_workspace_for_problem(problem_id)
    File.join("public", "data", current_user.name.tr(" ", "_"), problem_id) 
  end
  
  
  
  
  
  # GET /problems
  # GET /problems.json
  def index
    @problems = Problem.all
  end

  # GET /problems/1
  # GET /problems/1.json
  def show
  end

  # GET /problems/new
  def new
    @problem = Problem.new
  end

  # GET /problems/1/edit
  def edit
  end

  # POST /problems
  # POST /problems.json
  def create
    @problem = Problem.new(problem_params)

    respond_to do |format|
      if @problem.save
        format.html { redirect_to @problem, notice: 'Problem was successfully created.' }
        format.json { render :show, status: :created, location: @problem }
      else
        format.html { render :new }
        format.json { render json: @problem.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /problems/1
  # PATCH/PUT /problems/1.json
  def update
    respond_to do |format|
      if @problem.update(problem_params)
        format.html { redirect_to @problem, notice: 'Problem was successfully updated.' }
        format.json { render :show, status: :ok, location: @problem }
      else
        format.html { render :edit }
        format.json { render json: @problem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /problems/1
  # DELETE /problems/1.json
  def destroy
    @problem.destroy
    respond_to do |format|
      format.html { redirect_to problems_url, notice: 'Problem was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_problem
      @problem = Problem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def problem_params
      params.require(:problem).permit(:title, :explanation, :exIn, :exOut)
    end
end
