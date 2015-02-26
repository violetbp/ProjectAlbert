class ProblemsController < GradingController 
  #makes var @problem at bottom for those pages
  before_action :set_problem, only: [:show, :edit, :update, :destroy]
  #auth for admins
  before_filter :authorize, :except => [:show, :upload ] #can only access show and upload
  before_filter :authorizeprob, :only => [:show ] #cant access if not added

  #import
  require 'fileutils'

  def upload
    @prob_id = params[:problem_id]
    @filename = params[:script].original_filename
    if(legal_language?(@filename))  
      get_language(@filename)
      puts @lang
      save(params[:script], @prob_id)
      #will the next line work? from list of problems get the one pertaining to this specific problem
      @job = self.create_job(@prob_id, @filename)

      #runs file, puts output in res somehow
      puts "\n----------------------\nRAN:\nbash scripts/userSubmit.sh #{current_user.id} #{@prob_id} #{@job.id} @lang #{@filename}\n-------\n"
      res = IO.popen("bash scripts/userSubmit.sh #{current_user.id} #{@prob_id} #{@job.id} #{@lang} #{@filename}")# bash userSubmit userID problemID submissionID language sourceFile1 sourceFile2...
      @resultarr = res.readlines
      @result = @resultarr.to_s

      @job.autopoints = 0

      if @result[0..8].include?("Correct")
        @job.autopoints = Problem.find(@prob_id).points
      end

      @job.previous_output = @result
      @job.attempt = ((Job.where("user_id = #{current_user.id} AND problem_id = #{@prob_id}").count.to_i)||1)
      @job.previous_output = @result
      @job.save
      current_user.save

      #puts "OUTPUT:"
      @outp = Array.new
      @resultarr.each do |t|
        #puts t
        @outp << t
        @outp << "<br>"
      end
      @result = @outp.to_s
      puts @result
    else
      @result = "\"File type #{get_language(@filename)} is not accepted. Must be java source code in .java file.\""
    end
    respond_to do |format|
      format.js
    end
  end


  def get_workspace_for_problem(problem_id)
    File.join("scripts", "Users", current_user.id.to_s, problem_id.to_s, "#{Job.count.to_i+1 || 1}") #use job id
  end

  def get_language(filename)
    @lang = filename.to_s.split(".").last
    @lang
  end

  def legal_language?(filename)
    varr = ["java"].include? filename.to_s.split(".").last
    varr
  end

  def create_job(problem_id, file_in)
    job = Job.new(file_path: File.join(get_workspace_for_problem(problem_id), file_in), 
      problem_id: problem_id, user_id: current_user.id)
    job.save()
    job
  end

  #save submitted program to correct place
  def save(prog, problem_id)
    FileUtils::mkdir_p get_workspace_for_problem(problem_id) # make the directory
    path = File.join(get_workspace_for_problem(problem_id), prog.original_filename) # create the file path
    File.open(path, "wb") { |f| f.write(prog.read) }         # write the file
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
    puts "tests taken from folder id #{idArg}"

    @inarr = Array.new
    @outarr = Array.new
    
    Dir.glob("scripts/Problems/#{idArg}/*.in" ).each do |f|
      @inarr << f
    end
   
    Dir.glob("scripts/Problems/#{idArg}/*.out").each do |f|
      @outarr << f
    end
  end


  # POST /problems
  # POST /problems.json
  def create
    @problem = Problem.new(problem_params)
    #FileUtils::mkdir_p "grades/#{@problem.id}"
 
   # puts "grades/#{Problem.last.id.to_s}\n\n"

    respond_to do |format|
      if @problem.save
        populate(@problem.id.to_s)
        format.html { redirect_to @problem, notice: 'Problem was successfully created.' }
        format.json { render :show, status: :created, location: @problem }
      else
        format.html { render :new }
        format.json { render json: @problem.errors, status: :unprocessable_entity }
      end
    end
  end



  def update_test_data

    @folderId = params[:idnum]
    
    puts params[:commit]
    lastTest= (Dir.glob("scripts/Problems/#{@folderId}/*.in").last.split('/').last.split('.').first.to_i)
    @numTests = lastTest
    if params[:commit] == "Add Data"
      nextfolder = (Dir.glob("scripts/Problems/#{@folderId}/*.in").last.split('/').last.split('.').first.to_i + 1)
      puts "making scripts/Problems/#{@folderId}/#{nextfolder}.in and .out"
      inFile = File.new("scripts/Problems/#{@folderId}/#{nextfolder}.in", "w") 
      outFile = File.new("scripts/Problems/#{@folderId}/#{nextfolder}.out", "w") 
      inFile.close
      outFile.close
    end
    if params[:commit] == ""
      
    end
    #####################################################################################
    puts "\nStarting to update test data"
    puts @numTests
    activeprobs = ""
    for folder in 1..@numTests 
      puts folder
      activeprobs << "#{folder} "
      ins = "scripts/Problems/#{@folderId}/#{folder}.in"
      outs = "scripts/Problems/#{@folderId}/#{folder}.out"

      inFile = File.new(ins, "w") 
      outFile = File.new(outs, "w") 
      if inFile
        inFile.syswrite(params[:"in#{folder.to_i}"])
        print "in#{folder}:  "
        puts params[:"in#{folder.to_i}"]
      else 
        puts "Unable to write to file!" 
      end 
      if outFile
        outFile.syswrite(params[:"out#{folder.to_i}"])
        print "out#{folder}:  "
        puts params[:"out#{folder.to_i}"]

      else 
        puts "Unable to write to file!" 
      end 
      inFile.close
      outFile.close
    end
    if params[:problem][:grading_type] == "static" #&& params[:problem][:active_probs] && false)

      @problem.active_probs = activeprobs
      @problem.save
      puts "\n\n"
      puts @problem.active_probs
    end

    #respond_to do |format|
    # #format.json
    #end
   # redirect_to edit_problem_path(@folderId) and return
   # redirect_to edit_problem_path(@folderId)
  end



  # PATCH/PUT /problems/1
  # PATCH/PUT /problems/1.json
  def update
   # puts params.require(:problem)[:active_probs].join('')
    
    respond_to do |format|
      if @problem.update(problem_params)
        update_test_data
        
        if params[:problem][:script] #params[:problem][:grading_type] == "inter"
          @problem.active_probs = params[:problem][:script].original_filename.split('.').first
          @problem.save
          uploaded_io = params[:problem][:script]
          File.open(Rails.root.join('scripts', 'Problems', params[:id], uploaded_io.original_filename), 'wb') do |file|
            file.write(uploaded_io.read)
          end
          puts "\n\nThe location of the script is"
          puts @problem.active_probs
        end
        if params[:commit] == "Add Data"
          format.html { redirect_to :back, notice: 'Problem updated and data area added.' }
        end
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
    if admin?#no matter how hard you try you can't change a problem :P
      params.require(:problem).permit(:title, :explanation, :exIn, :exOut, :points, :grading_type, :extra_probs)
    end
  end
  def authorizeprob
    unless admin?
      current_user.problemsets.each do |set| 
        if set.problems.exists?(@problem) #admins can view everything
          return true
        end
      end
      puts "prevented #{current_user.name} from accessing problem"
      render_401
    end
  end
end





