class RemoveCountryNameFromTestResults < ActiveRecord::Migration[6.0]
  def change
    remove_column :test_results, :country_name, :string
  end
end
