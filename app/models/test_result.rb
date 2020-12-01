class TestResult < ApplicationRecord
  belongs_to :county, foreign_key: 'county_geoid', optional: true

  attr_accessor :economic_match, :diplomatic_match, :civil_match, :societal_match, :ideology_match_name, :ideology_match_definition, :ideology_match_definition_source
  
  def url
    "#{ENV['URL_PREFIX']}results.html?e=#{self["economic"]}&d=#{self["diplomatic"]}&g=#{self["civil"]}&s=#{self["societal"]}"
  end

  def set_matches
    
    def self.get_label(val, ary) 
      if val > 100 
        return null
      elsif val > 90
        return ary[0] 
      elsif val > 75 
        return ary[1] 
      elsif val > 60
        return ary[2] 
      elsif val >= 40
        return ary[3] 
      elsif val >= 25
        return ary[4] 
      elsif val >= 10
        return ary[5] 
      elsif val >= 0
        return ary[6] 
      else
        return null
      end
    end

    econonmicArray  = ["Communist", "Socialist", "Social", "Centrist", "Market", "Capitalist", "Laissez-Faire"]
    diplomaticArray = ["Cosmopolitan", "Internationalist", "Peaceful", "Balanced", "Patriotic", "Nationalist", "Chauvinist"]
    civilArray      = ["Anarchist", "Libertarian", "Liberal", "Moderate", "Statist", "Authoritarian", "Totalitarian"]
    societalArray   = ["Revolutionary", "Very Progressive", "Progressive", "Neutral", "Traditional", "Very Traditional", "Reactionary"]

    if(self.economic)
      self.economic_match = get_label(self.economic, econonmicArray)
    end

    if(self.diplomatic)
      self.diplomatic_match = get_label(self.diplomatic, diplomaticArray)
    end

    if(self.civil)
      self.civil_match = get_label(self.civil, civilArray)
    end
    
    if(self.societal)
      self.societal_match = get_label(self.societal, societalArray)
    end

  end

  def set_ideology

    matched_ideology = {}

    ideodist = Float::INFINITY

    Ideology.all.each do |ideology|
      
      equality = 50
      peace = 50
      liberty = 50
      progress = 50
      
      if(self.economic) then equality = self.economic end
      if(self.diplomatic) then peace = self.diplomatic end
      if(self.civil) then liberty = self.civil end
      if(self.societal) then progress = self.societal end
      
      wealth = ('%.1f' % (100 - equality))
      might = ('%.1f' % (100 - peace))
      authority = ('%.1f' % (100 - liberty))
      tradition = ('%.1f' % (100 - progress))

      dist = 0
      if(self.economic) then dist += ((ideology.economic_effect - equality).abs()) ** 2 end
      if(self.diplomatic) then dist += ((ideology.diplomatic_effect - peace).abs()) ** 1.73856063 end
      if(self.civil) then dist += ((ideology.government_effect - liberty).abs()) ** 2 end
      if(self.societal) then dist += ((ideology.societal_effect - progress).abs()) ** 1.73856063 end

      if dist < ideodist
        matched_ideology["name"] = ideology.name
        matched_ideology["definition"] = ideology.definition
        matched_ideology["definition_source"] = ideology.definition_source
        ideodist = dist
      end

    end

    self.ideology_match_name = matched_ideology["name"]
    self.ideology_match_definition = matched_ideology["definition"]
    self.ideology_match_definition_source = matched_ideology["definition_source"]

  end

end