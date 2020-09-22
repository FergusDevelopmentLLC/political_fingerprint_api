class TestResult < ApplicationRecord

  def url
    "#{ENV['URL_PREFIX']}results.html?e=#{self["economic"]}&d=#{self["diplomatic"]}&g=#{self["civil"]}&s=#{self["societal"]}"
  end

  def location
    abbrev = get_abbreviation_for(self.region)
    if abbrev
      "#{self["city"]}, #{abbrev}"
    else
      "#{self["city"]}, #{self["region"]}"
    end
  end

  # TODO: do this better
  # https://github.com/carmen-ruby/carmen
  def get_abbreviation_for(state) 
    return "AK" if state == "Alaska"
    return "AL" if state == "Alabama"
    return "AR" if state == "Arkansas"
    return "AS" if state == "American Samoa"
    return "AZ" if state == "Arizona"
    return "CA" if state == "California"
    return "CO" if state == "Colorado"
    return "CT" if state == "Connecticut"
    return "DC" if state == "District of Columbia"
    return "DE" if state == "Delaware"
    return "FL" if state == "Florida"
    return "GA" if state == "Georgia"
    return "GU" if state == "Guam"
    return "HI" if state == "Hawaii"
    return "IA" if state == "Iowa"
    return "ID" if state == "Idaho"
    return "IL" if state == "Illinois"
    return "IN" if state == "Indiana"
    return "KS" if state == "Kansas"
    return "KY" if state == "Kentucky"
    return "LA" if state == "Louisiana"
    return "MA" if state == "Massachusetts"
    return "MD" if state == "Maryland"
    return "ME" if state == "Maine"
    return "MI" if state == "Michigan"
    return "MN" if state == "Minnesota"
    return "MO" if state == "Missouri"
    return "MS" if state == "Mississippi"
    return "MT" if state == "Montana"
    return "NC" if state == "North Carolina"
    return "ND" if state == "North Dakota"
    return "NE" if state == "Nebraska"
    return "NH" if state == "New Hampshire"
    return "NJ" if state == "New Jersey"
    return "NM" if state == "New Mexico"
    return "NV" if state == "Nevada"
    return "NY" if state == "New York"
    return "OH" if state == "Ohio"
    return "OK" if state == "Oklahoma"
    return "OR" if state == "Oregon"
    return "PA" if state == "Pennsylvania"
    return "PR" if state == "Puerto Rico"
    return "RI" if state == "Rhode Island"
    return "SC" if state == "South Carolina"
    return "SD" if state == "South Dakota"
    return "TN" if state == "Tennessee"
    return "TX" if state == "Texas"
    return "UT" if state == "Utah"
    return "VA" if state == "Virginia"
    return "VI" if state == "Virgin Islands"
    return "VT" if state == "Vermont"
    return "WA" if state == "Washington"
    return "WI" if state == "Wisconsin"
    return "WV" if state == "West Virginia"
    return "WY" if state == "Wyoming"
    nil
  end

  def closest_county

    # cds = CongressionalDistrict.all

    # shortest_distance = distance_between([self.latitude, self.longitude], [cds.first.latitude, cds.first.longitude])

    # return_congressional_district = nil

    # binding.pry
    
    # cds.each { |cd| 
    #   binding.pry
    #   this_distance = distance_between([self.latitude, self.longitude], [cds[cd].latitude, cds[cd].longitude])
    #   if this_distance < shortest_distance
    #     shortest_distance = this_distance
    #     return_congressional_district = cd
    #   end
    # }

    # return_congressional_district

  end

  def distance_between(loc1, loc2)
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
