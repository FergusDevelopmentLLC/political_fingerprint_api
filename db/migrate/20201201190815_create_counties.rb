class CreateCounties < ActiveRecord::Migration[6.0]
  def change
    create_table :counties, id: false, primary_key: :geoid do |t|
    
      t.primary_key :geoid, :string
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


