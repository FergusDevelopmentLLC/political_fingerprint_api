class AddFkConstraintOnTestResultsCountyGeoid < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :test_results, :counties, column: 'county_geoid', primary_key: 'geoid'
  end
end
