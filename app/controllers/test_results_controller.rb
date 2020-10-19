class TestResultsController < ApplicationController
  before_action :set_test_result, only: [:show, :update, :destroy]

  # GET /test_results
  def index
    
    # @test_results = TestResult.all
    # render json: @test_results

    # @test_results = TestResult.all
    # trs = @test_results.map { |test_result| 
    #   tr = anonymize(test_result)
    # }.sort_by { |tr| tr["id"] }

    # render json: trs
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

    # save geolocation info for the test taker (uses ipinfo)
    handler = IPinfo::create(ENV["IPINFO_TOKEN"])
    details = handler.details(request.remote_ip.to_str)
    
    # logger.debug("===================================================")
    # logger.debug("request.remote_ip.to_str: #{request.remote_ip.to_str}")
    # logger.debug("details: #{details.to_s}")
    # logger.debug("city: #{details.respond_to?(:city)}")
    # logger.debug("region: #{details.respond_to?(:region)}")
    # logger.debug("===================================================")

    if details.respond_to?(:city) and details.respond_to?(:region)

      city = City.find_by(name: details.city, state_name: details.region)
      
      if city
        county = County.find_by(name: city.county_name, state_abbrev: city.state_abbrev)
        if county
          @test_result.county = county
        end
      end

    else
      # TODO: do this better, somehow. hack for localhost, because from there (dev), details doesn't get popuplated
      @test_result.county = County.find_by(name: "Eastern", state_abbrev: "AS")
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

  def add_pct_height_to (test_result_hash)

  end

  def averaged_by_county

    sql = %{
      select counties.geoid, avg(economic) as economic, avg(diplomatic) as diplomatic, avg(civil) as civil, avg(societal) as societal, CONCAT(counties.name, ' County') as name, counties.state_abbrev, counties.state_name, count(*) as tr_count
      from test_results
      join counties on counties.id = test_results.county_id
      group by counties.geoid, counties.name, counties.state_abbrev, counties.state_name
      order by counties.geoid;
    }
    averaged = ActiveRecord::Base.connection.execute(sql)
    
    trs = averaged.map {|tr| TestResult.populate_matches_for(tr) }

    # https://stackoverflow.com/questions/39542167/max-value-within-array-of-objects
    max = trs.map {|tr| tr["tr_count"]}.max.to_i
    # min = averaged.map {|tr| tr["tr_count"]}.min.to_i
    # total = trs.sum {|tr| tr["tr_count"]}.to_i

    trs_with_pct = trs.map {|tr|
      tr["pct_height"] = tr["tr_count"].to_f / max
      tr.delete("tr_count")
      tr
    }

    render json: trs_with_pct

  end

  def fake
    
    counties = County.limit(params[:limit].to_i).order("RANDOM()")

    trs = []
    counties.each.with_index(1) {|county, index|
      tr = {}
      tr["geoid"] = county.geoid
      tr["economic"] = rand(1..99)
      tr["diplomatic"] = rand(1..99)
      tr["civil"] = rand(1..99)
      tr["societal"] = rand(1..99)
      tr["name"] = "#{county.name} County"
      tr["state_abbrev"] = county.state_abbrev
      tr["state_name"] = county.state_name
      tr["tr_count"] = rand(1..10)

      TestResult.populate_matches_for(tr)

      trs.push(tr)
    }

    # https://stackoverflow.com/questions/39542167/max-value-within-array-of-objects
    max = trs.map {|tr| tr["tr_count"]}.max.to_i
    # min = averaged.map {|tr| tr["tr_count"]}.min.to_i
    # total = trs.sum {|tr| tr["tr_count"]}.to_i

    trs_with_pct = trs.map {|tr|
      tr["pct_height"] = tr["tr_count"].to_f / max
      tr.delete("tr_count")
      tr
    }

    render json: trs_with_pct

  end

  def get_ideology_matches
    
    tr = {}
    tr["economic"] = params[:economic].to_f
    tr["diplomatic"] = params[:diplomatic].to_f
    tr["civil"] = params[:civil].to_f
    tr["societal"] = params[:societal].to_f

    TestResult.populate_matches_for(tr)

    render json: tr

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

      tr["url"] = test_result.url
      tr["question_version"] = test_result.question_version

      if(test_result.respond_to?(:county))
        tr["geoid"] = test_result.county.geoid
        tr["name"] = "#{test_result.county.name} County"
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