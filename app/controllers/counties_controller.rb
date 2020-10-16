class CountiesController < ApplicationController
  before_action :set_county, only: [:show, :update, :destroy]

  # GET /counties
  def index
    @counties = County.all
    render json: @counties
  end

  # GET /counties/1
  def show
    render json: @county
  end

  # POST /counties
  def create
    # @county = County.new(county_params)

    # if @county.save
    #   render json: @county, status: :created, location: @county
    # else
    #   render json: @county.errors, status: :unprocessable_entity
    # end
  end

  # PATCH/PUT /counties/1
  def update
    # if @county.update(county_params)
    #   render json: @county
    # else
    #   render json: @county.errors, status: :unprocessable_entity
    # end
  end

  # DELETE /counties/1
  def destroy
    # @county.destroy
  end

  def counties_by_state

    counties = County.all
    states = counties.group_by{ |county| [county.state_name, county.state_abbrev] }.sort_by{ |state| state }
    
    return_array = []
    
    states.each { |state|
      st = {}
      st['name'] = state[0][0]
      st['abbrev'] = state[0][1]
      st['counties'] = []
      counties.each { |county| 
        if(county.state_name == state[0][0])
          c = {}
          c['name'] = county.name
          c['geoid'] = county.geoid
          st['counties'].push(c)
        end
      }

      st['counties'] = st['counties'].sort_by { |county| county['name'] }
      
      return_array.push(st)
    }
    
    render json: return_array
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_county
      @county = County.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def county_params
      params.require(:county).permit(:geoid, :name, :statefp, :countyfp, :state_abbrev, :state_name, :latitude, :longitude)
    end
end
