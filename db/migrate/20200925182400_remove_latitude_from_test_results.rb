class RemoveLatitudeFromTestResults < ActiveRecord::Migration[6.0]
  def change
    remove_column :test_results, :latitude, :float
  end
end
