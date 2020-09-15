class TestResultsController < ApplicationController
  before_action :set_test_result, only: [:show, :update, :destroy]

  # GET /test_results
  def index
    @test_results = TestResult.all

    render json: @test_results
  end

  # GET /test_results/1
  def show
    # render json: @test_result
    tr = {}
    tr["id"] = @test_result["id"]
    tr["economic"] = @test_result["economic"]
    tr["diplomatic"] = @test_result["diplomatic"]
    tr["civil"] = @test_result["civil"]
    tr["societal"] = @test_result["societal"]
    tr["url"] = @test_result.url
    render json: tr
  end

  # POST /test_results
  def create
    
    @test_result = TestResult.new(test_result_params)

    @test_result.client_ip = request.remote_ip.to_str

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
end