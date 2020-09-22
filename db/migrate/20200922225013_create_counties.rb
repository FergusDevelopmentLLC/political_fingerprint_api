class CreateCounties < ActiveRecord::Migration[6.0]
  def change
    create_table :counties do |t|
      t.string :geoid
      t.string :name
      t.string :statefp
      t.string :countyfp
      t.string :state_abbrev
      t.string :state_name
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
