class TestResult < ApplicationRecord
  belongs_to :county, optional: true
  
  def url
    "#{ENV['URL_PREFIX']}results.html?e=#{self["economic"]}&d=#{self["diplomatic"]}&g=#{self["civil"]}&s=#{self["societal"]}"
  end

  def self.populate_matches_for(test_result_hash) 

    def self.getLabel(val, ary) 
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

    test_result_hash["economic_match"] = getLabel(test_result_hash["economic"], econonmicArray)
    test_result_hash["diplomatic_match"] = getLabel(test_result_hash["diplomatic"], diplomaticArray)
    test_result_hash["civil_match"] = getLabel(test_result_hash["civil"], civilArray)
    test_result_hash["societal_match"] = getLabel(test_result_hash["societal"], societalArray)

    test_result_hash["ideology_match"] = TestResult.get_ideology_for(test_result_hash)
    
    test_result_hash

  end

  def self.get_ideology_for(test_result_hash) 
      
    matched_ideology = nil

    ideodist = Float::INFINITY

    # ideologies = []
    # ideologies.push(Ideology.first)
    # ideologies.each do |ideology|

    Ideology.all.each do |ideology|
      
      equality = test_result_hash["economic"]
      peace = test_result_hash["diplomatic"]
      liberty = test_result_hash["civil"]
      progress = test_result_hash["societal"]

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
        matched_ideology = ideology.name
        ideodist = dist
      end

    end

    matched_ideology

  end
end