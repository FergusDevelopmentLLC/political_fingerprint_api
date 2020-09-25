class RemoveCountryFromTestResults < ActiveRecord::Migration[6.0]
  def change
    remove_column :test_results, :country, :string
  end
end
