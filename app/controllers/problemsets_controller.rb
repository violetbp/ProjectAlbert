class ProblemsetsController < ApplicationController

  before_action :set_problemset, only: [:show, :edit, :update, :destroy]
  before_filter :authorize, :except => [:index, :show ]

  def new
    @problemset =  Problemset.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def index
    unless admin?
      if current_user
        @problemsets= current_user.problemsets
      end
    else
    @problemsets = Problemset.all
    end
  end
  
  def show 
  end
  
  # GET /problemsets/1/edit
  def edit
    @problemset.problems.each do |problem|
       params[:"#{problem.id}"]        
    end
  end
  
  # POST /problemsets
  # POST /problemsets.json
  def create
    @problemset = Problemset.new(problemset_params)
    respond_to do |format|
      if @problemset.save
        format.html { redirect_to @problemset, notice: 'Problemset was successfully created.' }
        format.json { render :show, status: :created, location: @problemset }
    else
        format.html { render :new }
        format.json { render json: @problemset.errors, status: :unprocessable_entity }
    end
  end
  end
  
  # POST/PUT /problemsets/1
  # POST/PUT /problemsets/1.json
  def update
    respond_to do |format|
      if @problemset.update(problemset_params)
        format.html { redirect_to @problemset, notice: 'Problem was successfully updated.' }
        format.json { render :show, status: :ok, location: @problemset }
        @problemset.problems.clear
        Problem.all.each do |problem|
          if params[:"#{problem.id}"]
            @problemset.problems << problem
          end
        end
      else
        format.html { render :edit }
        format.json { render json: @problemset.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_problemset
    @problemset = Problemset.find(params[:id])
  end
  # Never trust parameters from the scary internet, only allow the white list through.
  def problemset_params
    params.require(:problemset).permit(:title, :explanation)
  end
  
end
