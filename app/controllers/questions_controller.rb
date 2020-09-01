class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :update, :destroy]

  # GET /questions
  def index
    @questions = Question.all

    render json: @questions
  end

  # GET /questions/1
  def show
    render json: @question
  end

  # POST /questions
  def create
    @question = Question.new(question_params)

    if @question.save
      render json: @question, status: :created, location: @question
    else
      render json: @question.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /questions/1
  def update
    if @question.update(question_params)
      render json: @question
    else
      render json: @question.errors, status: :unprocessable_entity
    end
  end

  # DELETE /questions/1
  def destroy
    @question.destroy
  end

  # GET /questions/by_version/1
  def by_version
    
    currentQuestions = []

    Question.all.each { |question| 
      # TODO, harden this version param
      iteration = QuestionIteration.where(["question_id = ? and version = ?", question.id, params[:version]]).first
      if(iteration) 
        q = {}
        q[:question_id] = iteration[:question_id]
        q[:version] = iteration[:version]
        q[:content] = iteration[:content]
        currentQuestions.push(q)
      end
    }

    render json: currentQuestions
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def question_params
      params.require(:question).permit(:category_id, :current_version)
    end
end
