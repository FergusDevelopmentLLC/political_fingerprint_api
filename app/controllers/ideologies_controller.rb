class IdeologiesController < ApplicationController
  before_action :set_ideology, only: [:show, :update, :destroy]

  # GET /ideologies
  def index
    @ideologies = Ideology.all

    render json: @ideologies
  end

  # GET /ideologies/1
  def show
    render json: @ideology
  end

  # POST /ideologies
  def create
    @ideology = Ideology.new(ideology_params)

    if @ideology.save
      render json: @ideology, status: :created, location: @ideology
    else
      render json: @ideology.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /ideologies/1
  def update
    # if @ideology.update(ideology_params)
    #   render json: @ideology
    # else
    #   render json: @ideology.errors, status: :unprocessable_entity
    # end
  end

  # DELETE /ideologies/1
  def destroy
    # @ideology.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ideology
      @ideology = Ideology.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def ideology_params
      params.require(:ideology).permit(:name, :definition, :definition_source, :economic_effect, :diplomatic_effect, :government_effect, :societal_effect)
    end
end
