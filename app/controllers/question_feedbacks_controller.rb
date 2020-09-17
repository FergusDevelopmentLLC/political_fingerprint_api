class QuestionFeedbacksController < ApplicationController
  before_action :set_question_feedback, only: [:show, :update, :destroy]

  # GET /question_feedbacks
  def index
    @question_feedbacks = QuestionFeedback.all

    render json: @question_feedbacks
  end

  # GET /question_feedbacks/1
  def show
    render json: @question_feedback
  end

  # POST /question_feedbacks
  def create
    @question_feedback = QuestionFeedback.new(question_feedback_params)

    if @question_feedback.save
      render json: @question_feedback, status: :created, location: @question_feedback
    else
      render json: @question_feedback.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /question_feedbacks/1
  def update
    # if @question_feedback.update(question_feedback_params)
    #   render json: @question_feedback
    # else
    #   render json: @question_feedback.errors, status: :unprocessable_entity
    # end
  end

  # DELETE /question_feedbacks/1
  def destroy
    # @question_feedback.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question_feedback
      @question_feedback = QuestionFeedback.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def question_feedback_params
      params.require(:question_feedback).permit(:question_iteration_id, :score, :explanation)
    end
end
