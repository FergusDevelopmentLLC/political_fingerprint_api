class TestResultsController < ApplicationController
  before_action :set_test_result, only: [:show, :update, :destroy]

  # GET /test_results
  def index
    
    # @test_results = TestResult.all
    # render json: @test_results

    @test_results = TestResult.all
    
    trs = @test_results.map { |test_result| 
      tr = anonymize(test_result)
    }.sort_by { |tr| tr["id"] }

    render json: trs
  end

  # GET /test_results/1
  def show
    # render json: @test_result
    tr = anonymize(@test_result)
    render json: tr
  end

  # POST /test_results
  def create
    
    @test_result = TestResult.new(test_result_params)

    # save geolocation info for the test taker (uses ipinfo)
    handler = IPinfo::create(ENV["IPINFO_TOKEN"])
    details = handler.details(request.remote_ip.to_str)
    
    if details.respond_to?(:country)
      @test_result.country = details.country
    end

    if details.respond_to?(:country_name)
      @test_result.country_name = details.country_name
    end

    if details.respond_to?(:region)
      @test_result.region = details.region
    end

    if details.respond_to?(:city)
      @test_result.city = details.city
    end

    if details.respond_to?(:latitude)
      @test_result.latitude = details.latitude
    end

    if details.respond_to?(:longitude)
      @test_result.longitude = details.longitude
    end

    if @test_result.save
      render json: @test_result, status: :created, location: @test_result
    else
      render json: @test_result.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /test_results/1
  def update
    # if @test_result.update(test_result_params)
    #   render json: @test_result
    # else
    #   render json: @test_result.errors, status: :unprocessable_entity
    # end
  end

  # DELETE /test_results/1
  def destroy
    # @test_result.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_test_result
      @test_result = TestResult.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def test_result_params
      params.require(:test_result).permit(:client_ip, :question_version, :economic, :diplomatic, :civil, :societal)
    end

    def anonymize(test_result)
      tr = {}
      tr["id"] = test_result["id"]

      tr["url"] = test_result.url
      tr["location"] = test_result.location
      
      tr["country"] = test_result["country"]
      tr["country_name"] = test_result["country_name"]
      tr["latitude"] = test_result["latitude"]
      tr["longitude"] = test_result["longitude"]
      
      tr["economic"] = test_result["economic"]
      tr["diplomatic"] = test_result["diplomatic"]
      tr["civil"] = test_result["civil"]
      tr["societal"] = test_result["societal"]

      tr
    end

    def get_district


    end

    def distance(loc1, loc2)
      rad_per_deg = Math::PI/180  # PI / 180
      rkm = 6371                  # Earth radius in kilometers
      rm = rkm * 1000             # Radius in meters
    
      dlat_rad = (loc2[0]-loc1[0]) * rad_per_deg  # Delta, converted to rad
      dlon_rad = (loc2[1]-loc1[1]) * rad_per_deg
    
      lat1_rad, lon1_rad = loc1.map {|i| i * rad_per_deg }
      lat2_rad, lon2_rad = loc2.map {|i| i * rad_per_deg }
    
      a = Math.sin(dlat_rad/2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon_rad/2)**2
      c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))
    
      rm * c # Delta in meters
    end
    
end
