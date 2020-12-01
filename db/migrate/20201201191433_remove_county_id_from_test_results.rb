class RemoveCountyIdFromTestResults < ActiveRecord::Migration[6.0]
  def change
    remove_column :test_results, :county_id, :integer
  end
end
