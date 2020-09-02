class QuestionIterationsController < ApplicationController
  before_action :set_question_iteration, only: [:show, :update, :destroy]

  # GET /question_iterations
  def index
    @question_iterations = QuestionIteration.all

    render json: @question_iterations
  end

  # GET /question_iterations/1
  def show
    render json: @question_iteration
  end

  # POST /question_iterations
  def create
    @question_iteration = QuestionIteration.new(question_iteration_params)

    if @question_iteration.save
      render json: @question_iteration, status: :created, location: @question_iteration
    else
      render json: @question_iteration.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /question_iterations/1
  def update
    if @question_iteration.update(question_iteration_params)
      render json: @question_iteration
    else
      render json: @question_iteration.errors, status: :unprocessable_entity
    end
  end

  # DELETE /question_iterations/1
  def destroy
    @question_iteration.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question_iteration
      @question_iteration = QuestionIteration.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def question_iteration_params
      params.require(:question_iteration).permit(:question_id, :version, :content, :economic_effect, :diplomatic_effect, :government_effect, :societal_effect)
    end
end
