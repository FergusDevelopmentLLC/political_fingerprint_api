class CongressionalDistrictsController < ApplicationController
  before_action :set_congressional_district, only: [:show, :update, :destroy]

  # GET /congressional_districts
  def index
    @congressional_districts = CongressionalDistrict.all

    render json: @congressional_districts
  end

  # GET /congressional_districts/1
  def show
    render json: @congressional_district
  end

  # POST /congressional_districts
  def create
    @congressional_district = CongressionalDistrict.new(congressional_district_params)

    if @congressional_district.save
      render json: @congressional_district, status: :created, location: @congressional_district
    else
      render json: @congressional_district.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /congressional_districts/1
  def update
    if @congressional_district.update(congressional_district_params)
      render json: @congressional_district
    else
      render json: @congressional_district.errors, status: :unprocessable_entity
    end
  end

  # DELETE /congressional_districts/1
  def destroy
    @congressional_district.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_congressional_district
      @congressional_district = CongressionalDistrict.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def congressional_district_params
      params.require(:congressional_district).permit(:geoid, :name, :latitude, :longitude)
    end
end
