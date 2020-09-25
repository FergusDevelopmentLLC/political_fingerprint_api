class RemoveCityFromTestResults < ActiveRecord::Migration[6.0]
  def change
    remove_column :test_results, :city, :string
  end
end
