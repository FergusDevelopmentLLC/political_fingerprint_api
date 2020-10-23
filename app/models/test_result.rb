class TestResult < ApplicationRecord
  belongs_to :county, optional: true
  
  def url
    "#{ENV['URL_PREFIX']}results.html?e=#{self["economic"]}&d=#{self["diplomatic"]}&g=#{self["civil"]}&s=#{self["societal"]}"
  end

  def self.populate_matches_for(test_result_hash) 

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

    if(test_result_hash["economic"])
      test_result_hash["economic_match"] = get_label(test_result_hash["economic"], econonmicArray)
    end

    if(test_result_hash["diplomatic"])
      test_result_hash["diplomatic_match"] = get_label(test_result_hash["diplomatic"], diplomaticArray)
    end

    if(test_result_hash["civil"])
      test_result_hash["civil_match"] = get_label(test_result_hash["civil"], civilArray)
    end
    
    if(test_result_hash["societal"])
      test_result_hash["societal_match"] = get_label(test_result_hash["societal"], societalArray)
    end

    test_result_hash["ideology_match_name"] = TestResult.get_ideology_for(test_result_hash)["name"]
    test_result_hash["ideology_match_definition"] = TestResult.get_ideology_for(test_result_hash)["definition"]
    test_result_hash["ideology_match_definition_source"] = TestResult.get_ideology_for(test_result_hash)["definition_source"]
    
    test_result_hash

  end

  def self.get_ideology_for(test_result_hash) 
      
    matched_ideology = {}

    ideodist = Float::INFINITY

    # ideologies = []
    # ideologies.push(Ideology.first)
    # ideologies.each do |ideology|

    Ideology.all.each do |ideology|
      
      equality = 50
      peace = 50
      liberty = 50
      progress = 50
      
      if(test_result_hash["economic"]) then equality = test_result_hash["economic"] end
      if(test_result_hash["diplomatic"]) then peace = test_result_hash["diplomatic"] end
      if(test_result_hash["civil"]) then liberty = test_result_hash["civil"] end
      if(test_result_hash["societal"]) then progress = test_result_hash["societal"] end
      
      wealth = ('%.1f' % (100 - equality))
      might = ('%.1f' % (100 - peace))
      authority = ('%.1f' % (100 - liberty))
      tradition = ('%.1f' % (100 - progress))

      dist = 0
      dist += ((ideology.economic_effect - equality).abs()) ** 2
      dist += ((ideology.diplomatic_effect - peace).abs()) ** 1.73856063 
      dist += ((ideology.government_effect - liberty).abs()) ** 2
      dist += ((ideology.societal_effect - progress).abs()) ** 1.73856063

      if dist < ideodist
        matched_ideology["name"] = ideology.name
        matched_ideology["definition"] = ideology.definition
        matched_ideology["definition_source"] = ideology.definition_source
        ideodist = dist
      end

    end

    matched_ideology

  end
end