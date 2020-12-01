class AddCountyGeoidToTestResults < ActiveRecord::Migration[6.0]
  def change
    add_column :test_results, :county_geoid, :string
  end
end
