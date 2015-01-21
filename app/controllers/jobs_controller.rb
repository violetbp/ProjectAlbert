class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy, :set_submitted, :set_not_submitted, :set_graded, :grade]

  # GET /jobs/grade/1
  def grade
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def show
    
    unless current_user.jobs.exists?(@job)
      redirect_to :back
      flash[:notice] = 'Insufficent Permsission'
      #render_401
    end
  end
  
  def update
    
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to @job, notice: 'Job was successfully updated.' }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def set_submitted
    if current_user.jobs.where({ id: "#{@job.id.to_i}", submitted: "true" })
      @job.submitted = true
      @job.save
      puts "\n-------------\nset #{@job.id}as submitted for problem #{@job.problem_id}\n-------------\n"
    else
      puts  "\n-------------\n#{@job.id} was not set as submitted for problem #{@job.problem_id}\nsince a submitted problem was dectected\n-------------\n"
    end
    redirect_to(:back)
  end
  
  def set_not_submitted
    unless @job.graded
    @job.submitted = false
    @job.save
    puts "\n-------------\nset #{@job.id}as NOT submitted for problem #{@job.problem_id}\n-------------\n"
    else
    end
    redirect_to(:back)
  end
  
  def set_graded(gradedbool)
    unless current_user.jobs.where({ id: "#{@job.id.to_i}", graded: "true" })
      @job.graded = gradedbool
      @job.save
      puts "\n-------------\nset #{@job.id}as submitted for problem #{@job.problem_id}\n-------------\n"
    else
      puts  "\n-------------\n#{@job.id} was not set as graded for problem #{@job.problem_id}\nsince a graded problem was dectected\n-------------\n"
    end
    #redirect_to(:back)
  end
 
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def job_params
      params.require(:job).permit(:style, :function, :solution, :submitted, :graded)
    end
end
