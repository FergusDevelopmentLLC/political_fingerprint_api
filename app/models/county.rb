class County < ApplicationRecord
  self.primary_key = 'geoid'
  has_many :test_results, primary_key: 'geoid', foreign_key: 'county_geoid'
end
