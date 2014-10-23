class ProblemsController < ApplicationController
  before_action :set_problem, only: [:show, :edit, :update, :destroy]

  def upload

    ProcessFile.save(params[:script], params[:problem_id], current_user.name)
  	 #will the next line work? from list of problems get the one pertaining to this specific problem
    #@job = current_user.problem_completions.get(problem_id).create(
        @job = Job.create(file_path: File.join(Rails.root, "public", "data" , current_user.name, Problem.find_by_id(params[:problem_id]).title, params[:script].original_filename),
  	    problem_id: params[:problem_id])
  	@job.save
  	@result = ""
  	File.open(@job.file_path, 'r') do |f|
  		while line = f.gets 
  			res = IO.popen(line)
  			@result += res.readlines.to_s
  			res.readlines
  		end
  	end

  	respond_to do |format|
  		format.js
  	end
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
