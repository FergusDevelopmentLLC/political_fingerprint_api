class CreateCongressionalDistricts < ActiveRecord::Migration[6.0]
  def change
    create_table :congressional_districts do |t|
      t.string :geoid
      t.string :name
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
