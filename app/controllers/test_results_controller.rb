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
    
    if details.respond_to?(:city) and details.respond_to?(:region)

      city = City.find_by(name: details.city, state_name: details.region)
      
      if city
        county = County.find_by(name: city.county_name, state_abbrev: city.state_abbrev)
        if county
          @test_result.county = county
        end
      end

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

  def fake
    
    trs = []
    County.all.each.with_index(1) {|county, index|
      tr = {}
      tr["id"] = index
      tr["question_version"] = rand(1..2)
      tr["economic"] = rand(1..99)
      tr["diplomatic"] = rand(1..99)

      if tr["question_version"] == 1
        tr["civil"] = rand(1..99)
        tr["societal"] = rand(1..99)
      else
        tr["civil"] = 50
        tr["societal"] = 50
      end

      tr["url"] = "#{ENV['URL_PREFIX']}results.html?e=#{tr["economic"]}&d=#{tr["diplomatic"]}&g=#{tr["civil"]}&s=#{tr["societal"]}"
      tr["name"] = "#{county.name} County"
      tr["state_abbrev"] = county.state_abbrev
      tr["state_name"] = county.state_name
      trs.push(tr)
    }
    render json: trs

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

      tr["id"] = test_result.id
      tr["url"] = test_result.url
      tr["question_version"] = test_result.question_version

      if(test_result.respond_to?(:county))
        tr["name"] = "#{test_result.county.name} County"
        tr["id"] = test_result.county.geoid
        tr["state_abbrev"] = test_result.county.state_abbrev
        tr["state_name"] = test_result.county.state_name
      end
      
      tr["economic"] = test_result["economic"]
      tr["diplomatic"] = test_result["diplomatic"]
      tr["civil"] = test_result["civil"]
      tr["societal"] = test_result["societal"]

      tr
    end

end