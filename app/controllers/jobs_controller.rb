class JobsController < ApplicationController
  before_action :set_job

  # GET /jobs/grade/1
  def grade
    respond_to do |format|
      format.html
      format.js
    end
  end
  def show
    
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
    @job.submitted = true
    @job.save
    puts "\n-------------\nset #{@job.id}as submitted for problem #{@job.problem_id}\n-------------\n"
    redirect_to(:back)
  end
  def set_not_submitted
    @job.submitted = false
    @job.save
    puts "\n-------------\nset #{@job.id}as NOT submitted for problem #{@job.problem_id}\n-------------\n"
    redirect_to(:back)
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def job_params
      params.require(:job).permit(:style, :function, :solution, :submitted)
    end
end
