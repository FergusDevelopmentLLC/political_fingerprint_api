class CreateCities < ActiveRecord::Migration[6.0]
  def change
    create_table :cities do |t|
      t.string :name
      t.string :state_abbrev
      t.string :state_name
      t.string :county_name
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
