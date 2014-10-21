class ProblemCompletionsController < ApplicationController
  before_action :set_problem_completion, only: [:show, :edit, :update, :destroy]

  # GET /problem_completions
  # GET /problem_completions.json
  def index
    @problem_completions = ProblemCompletion.all
  end

  # GET /problem_completions/1
  # GET /problem_completions/1.json
  def show
  end

  # GET /problem_completions/new
  def new
    @problem_completion = ProblemCompletion.new
  end

  # GET /problem_completions/1/edit
  def edit
  end

  # POST /problem_completions
  # POST /problem_completions.json
  def create
    @problem_completion = ProblemCompletion.new(problem_completion_params)

    respond_to do |format|
      if @problem_completion.save
        format.html { redirect_to @problem_completion, notice: 'Problem completion was successfully created.' }
        format.json { render :show, status: :created, location: @problem_completion }
      else
        format.html { render :new }
        format.json { render json: @problem_completion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /problem_completions/1
  # PATCH/PUT /problem_completions/1.json
  def update
    respond_to do |format|
      if @problem_completion.update(problem_completion_params)
        format.html { redirect_to @problem_completion, notice: 'Problem completion was successfully updated.' }
        format.json { render :show, status: :ok, location: @problem_completion }
      else
        format.html { render :edit }
        format.json { render json: @problem_completion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /problem_completions/1
  # DELETE /problem_completions/1.json
  def destroy
    @problem_completion.destroy
    respond_to do |format|
      format.html { redirect_to problem_completions_url, notice: 'Problem completion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_problem_completion
      @problem_completion = ProblemCompletion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def problem_completion_params
      params.require(:problem_completion).permit(:username, :problemname, :score, :previousOutput, :attempt)
    end
end
