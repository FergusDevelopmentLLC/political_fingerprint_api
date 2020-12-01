class TestResultsController < ApplicationController
  before_action :set_test_result, only: [:show, :update, :destroy]

  # GET /test_results
  def index
    # @test_results = TestResult.all
    # render json: @test_results
  end

  # GET /test_results/1
  def show
    # render json: @test_result
    # tr = anonymize(@test_result)
    # render json: tr
  end

  # POST /test_results
  def create
    
    @test_result = TestResult.new(test_result_params)

    @test_result.set_matches

    @test_result.set_ideology

    # save geolocation info for the test taker (uses ipinfo)
    handler = IPinfo::create(ENV["IPINFO_TOKEN"])
    details = handler.details(request.remote_ip.to_str)

    # logger.debug("===================================================")
    # logger.debug("request.remote_ip.to_str: #{request.remote_ip.to_str}")
    # logger.debug("details: #{details.to_s}")
    # logger.debug("city: #{details.respond_to?(:city)}")
    # logger.debug("region: #{details.respond_to?(:region)}")
    # logger.debug("===================================================")
    
    if (request.remote_ip.to_str == "127.0.0.1") then
      city = "Denver"
      region = "Colorado"
    elsif details.city && details.region
      city = details.city
      region = details.region
    end

    if city and region
      city = City.find_by(name: city, state_name: region)
      if city
        county = County.find_by(name: city.county_name, state_abbrev: city.state_abbrev)
        if county
          @test_result.county = county
        end
      end

    end

    # changes to these only happens on update
    @test_result.county_override = false
    @test_result.opt_in = true
    
    if @test_result.save
      render json: @test_result.to_json(include: { county: { except: [:countyfp, :id, :latitude, :longitude, :statefp, :created_at, :updated_at] } }, :except => [:county_id, :created_at, :updated_at])
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
    # @test_result.destroy
  end

  # PATCH/PUT /test_results_check/
  # def test_results_check

  #   test_result = TestResult.find(params["test_result"]["id"].to_i)
    
  #   if(params["test_result"]["countyGeoId"]) then 
  #     test_result.county_id = County.find_by(geoid: params["test_result"]["countyGeoId"].to_s).id
  #   else 
  #     test_result.county_id = nil
  #   end

  #   test_result.opt_in = !!params["test_result"]["optIn"]
  #   test_result.county_override = !!params["test_result"]["countyOverride"]
    
  #   if test_result.save
  #     render json: test_result, include: :county
  #   else
  #     render json: test_result.errors, status: :unprocessable_entity
  #   end

  # end

  def averaged_by_county

    sql = %{
      select counties.geoid, avg(economic) as economic, avg(diplomatic) as diplomatic, avg(civil) as civil, avg(societal) as societal, CONCAT(counties.name, ' County') as name, counties.state_abbrev, counties.state_name, count(*) as tr_count
      from test_results
      join counties on counties.geoid = test_results.county_geoid
      where test_results.opt_in = true
      group by counties.geoid, counties.name, counties.state_abbrev, counties.state_name
      order by counties.geoid;
    }
    
    averaged = ActiveRecord::Base.connection.execute(sql)
    
    trs = averaged.map {|atr| 
      
      tr = {}
      tr["economic"] = atr["economic"]
      tr["diplomatic"] = atr["diplomatic"]
      tr["civil"] = atr["civil"]
      tr["societal"] = atr["societal"]

      tr["name"] = atr["name"]
      tr["state_abbrev"] = atr["state_abbrev"]
      tr["state_name"] = atr["state_name"]
      tr["county_geoid"] = atr["geoid"]
      tr["tr_count"] = atr["tr_count"]
      tr
    }

    max_county_tr_count = trs.map {|tr| tr["tr_count"]}.max.to_i
    
    trs_with_pct = trs.map {|tr|
      tr["pct_height"] = tr["tr_count"].to_f / max_county_tr_count
      tr
    }

    render json: trs_with_pct

  end

  def fake
    
    counties = County.limit(params[:limit].to_i).order("RANDOM()")

    trs = counties.map {|county|
      
      testResult = {}
      
      testResult["economic"] = rand(1..99)
      testResult["diplomatic"] = rand(1..99)
      testResult["civil"] = rand(1..99)
      testResult["societal"] = rand(1..99)
      testResult["tr_count"] = rand(1..10)

      testResult["name"] = "#{county.name} County"
      testResult["state_abbrev"] = county.state_abbrev
      testResult["state_name"] = county.state_name
      testResult["county_geoid"] = county.geoid
      
      testResult
    }

    max_county_tr_count = trs.map {|tr| tr["tr_count"]}.max.to_i
    
    trs_with_pct = trs.map {|tr|
      tr["pct_height"] = tr["tr_count"].to_f / max_county_tr_count
      tr
    }

    render json: trs_with_pct

  end

  def get_ideology_matches
    
    tr = TestResult.new

    tr["economic"] = params[:economic].to_f
    tr["diplomatic"] = params[:diplomatic].to_f
    tr["civil"] = params[:civil].to_f
    tr["societal"] = params[:societal].to_f
    
    tr.set_matches
    tr.set_ideology

    testResult = tr.attributes
    
    testResult["economic_match"] = tr.economic_match
    testResult["diplomatic_match"] = tr.diplomatic_match
    testResult["civil_match"] = tr.civil_match
    testResult["societal_match"] = tr.societal_match
      
    testResult["ideology_match_name"] = tr.ideology_match_name
    testResult["ideology_match_definition"] = tr.ideology_match_definition
    testResult["ideology_match_definition_source"] = tr.ideology_match_definition_source

    render json: testResult

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_test_result
      @test_result = TestResult.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def test_result_params
      params.require(:test_result).permit(:id, :question_version, :economic, :diplomatic, :civil, :societal, :county_override, :county_geoid, :opt_in)
    end

  end