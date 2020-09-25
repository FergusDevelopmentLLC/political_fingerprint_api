class RemoveLongitudeFromTestResults < ActiveRecord::Migration[6.0]
  def change
    remove_column :test_results, :longitude, :float
  end
end
