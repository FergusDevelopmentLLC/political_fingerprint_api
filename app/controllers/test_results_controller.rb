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
    @test_result.client_ip    = request.remote_ip.to_str
    @test_result.country      = nil unless request.env['ipinfo'].respond_to?(:country)
    @test_result.country_name = nil unless request.env['ipinfo'].respond_to?(:country_name)
    @test_result.region       = nil unless request.env['ipinfo'].respond_to?(:region)
    @test_result.city         = nil unless request.env['ipinfo'].respond_to?(:city)
    @test_result.latitude     = nil unless request.env['ipinfo'].respond_to?(:latitude)
    @test_result.longitude    = nil unless request.env['ipinfo'].respond_to?(:longitude)

    if @test_result.save
      render json: @test_result, status: :created, location: @test_result
    else
      render json: @test_result.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /test_results/1
  def update
    if @test_result.update(test_result_params)
      render json: @test_result
    else
      render json: @test_result.errors, status: :unprocessable_entity
    end
  end

  # DELETE /test_results/1
  def destroy
    @test_result.destroy
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
      tr["economic"] = test_result["economic"]
      tr["diplomatic"] = test_result["diplomatic"]
      tr["civil"] = test_result["civil"]
      tr["societal"] = test_result["societal"]
      tr["url"] = test_result.url
      tr
    end
    
end
