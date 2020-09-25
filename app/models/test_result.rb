class TestResult < ApplicationRecord
  belongs_to :county
  
  def url
    "#{ENV['URL_PREFIX']}results.html?e=#{self["economic"]}&d=#{self["diplomatic"]}&g=#{self["civil"]}&s=#{self["societal"]}"
  end

end