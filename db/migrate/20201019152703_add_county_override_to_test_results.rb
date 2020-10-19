class AddCountyOverrideToTestResults < ActiveRecord::Migration[6.0]
  def change
    add_column :test_results, :county_override, :boolean
  end
end
