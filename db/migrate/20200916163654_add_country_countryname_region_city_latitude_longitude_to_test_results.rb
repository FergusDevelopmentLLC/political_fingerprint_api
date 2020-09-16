class AddCountryCountrynameRegionCityLatitudeLongitudeToTestResults < ActiveRecord::Migration[6.0]
  def change
    add_column :test_results, :country, :string
    add_column :test_results, :country_name, :string
    add_column :test_results, :region, :string
    add_column :test_results, :city, :string
    add_column :test_results, :latitude, :float
    add_column :test_results, :longitude, :float
  end
end
