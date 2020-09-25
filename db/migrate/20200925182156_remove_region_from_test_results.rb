class RemoveRegionFromTestResults < ActiveRecord::Migration[6.0]
  def change
    remove_column :test_results, :region, :string
  end
end
