class ProblemsController < ApplicationController 
  #makes var @problem at bottom for those pages
  before_action :set_problem, only: [:show, :edit, :update, :destroy]
  #auth for admins
  before_filter :authorize, :except => [:index, :show ]
  #import
  require 'fileutils'

  def upload
    if !(current_user.points)
      current_user.update(points: 0)
      current_user.save
    end
    @shPath = File.join("public", "data", "gradingtesting")
    @shPath = File.join("public", "data", "gradingtesting")
    @username = current_user.name.tr(' ','_') #without spaces so the sh will run

    save(params[:script], params[:problem_id], @username)
    #will the next line work? from list of problems get the one pertaining to this specific problem
    @job = self.create_job(params[:problem_id], params[:script].original_filename)

   


    #runs file, puts output in res somehow
    res = IO.popen("bash scripts/albert.sh #{@job.file_path} grades/#{params[:problem_id]}")
    @result = res.readlines.to_s
    @job.points = 0


    if @result[0..8].include?("Correct")
      #current_user.points += Problem.find(params[:problem_id]).points
      @job.points = Problem.find(params[:problem_id]).points
    end
    #@jobthing = Job.where("user_id = #{current_user.id}")


    @job.previous_output = @result
    @job.attempt = ((Job.where("user_id = #{current_user.id} AND problem_id = #{params[:problem_id]}").count.to_i)||1)
    @job.previous_output = @result
    @job.save
    current_user.save
    puts "OUTPUT:"
    puts @job.previous_output
    respond_to do |format|
      format.js
    end
  end


  def get_workspace_for_problem(problem_id)
    File.join("public", "data", current_user.name.tr(" ", "_"), problem_id) 
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




  def _form 
    #do i need this
  end


  # GET /problems
  # GET /problems.json
  def index
    @problems = Problem.all
    @users = User.order("points desc").limit(12).all
    @problemsets = Problemset.all

  end

  # GET /problems/1
  # GET /problems/1.json
  def show
  end

  # GET /problems/new
  def new
    @problem = Problem.new
    nextId = Problem.last.id.to_i+1
    puts @problem.id
    populate(nextId)
    get_input_output_names(nextId)
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /problems/1/edit
  def edit
    get_input_output_names(params[:id])
  end

  def get_input_output_names(idArg)
    @nameOfFolder = idArg
    @numTests= (Dir.glob("grades/#{@nameOfFolder}/*").select {|f| File.directory? f}).count.to_i
    puts "#{@numTests} tests taken from folder id #{@nameOfFolder}"
    puts Dir.glob("grades/#{@nameOfFolder}/*").select {|f| File.directory? f}
    @inarr = Array.new(@numTests)
    @outarr = Array.new(@numTests)
    for folder in 1..@numTests 
      
      if !(File::directory?( "grades/#{@nameOfFolder}/#{folder}" ))
        break #probably should just skip if avery does sh
      end
      @inarr[folder-1] = "grades/#{@nameOfFolder}/#{folder}/in"
      @outarr[folder-1] = "grades/#{@nameOfFolder}/#{folder}/out"

    end
  end


  # POST /problems
  # POST /problems.json
  def create
    @problem = Problem.new(problem_params)
    FileUtils::mkdir_p "grades/#{@problem.id}"
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

def populate(prob)
    puts "making and populting directory  grades/#{prob}"
    for folder in 1..3
      FileUtils::mkdir_p "grades/#{prob}/#{folder}"
      inFile = File.new("grades/#{prob}/#{folder}/in", "w") 
      outFile = File.new("grades/#{prob}/#{folder}/out", "w") 
      inFile.close
      outFile.close
    end
  end

  def update_test_data
    @folderId = params[:idnum]
    @numTests= (Dir.glob("grades/#{@folderId}/*").select {|f| File.directory? f}).count.to_i
    if params[:commit] == "Add Data"
      puts "making directory  grades/#{@folderId}/#{@numTests +1}"
      puts params[:idnum]
      FileUtils::mkdir_p "grades/#{@folderId}/#{@numTests +1}"
      inFile = File.new("grades/#{@folderId}/#{@numTests +1}/in", "w") 
      outFile = File.new("grades/#{@folderId}/#{@numTests +1}/out", "w") 
      inFile.close
      outFile.close
    end
    if params[:commit] == "Generate data from script"
      
    end
    #####################################################################################
    for folder in 1..@numTests 

      if !(File::directory?( "grades/#{@folderId}/#{folder}" ))
        break #probably should just skip if avery does sh
      end
      ins = "grades/#{@folderId}/#{folder}/in"
      outs = "grades/#{@folderId}/#{folder}/out"

      inFile = File.new(ins, "w") 
      outFile = File.new(outs, "w") 
      if inFile
        inFile.syswrite(params[:"in#{folder.to_i}"])
        puts "in#{folder}"
        puts params[:"in#{folder.to_i}"]
      else 
        puts "Unable to write to file!" 
      end 
      if outFile
        outFile.syswrite(params[:"out#{folder.to_i}"])
        puts "out#{folder}"
        puts params[:"out#{folder.to_i}"]

      else 
        puts "Unable to write to file!" 
      end 
      inFile.close
      outFile.close
    end

    redirect_to edit_problem_path(@folderId)
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
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_problem
    @problem = Problem.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def problem_params
    params.require(:problem).permit(:title, :explanation, :exIn, :exOut, :points)
  end
end
