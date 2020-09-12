class CreateIdeologies < ActiveRecord::Migration[6.0]
  def change
    create_table :ideologies do |t|
      t.string :name
      t.string :definition
      t.string :definition_source
      t.integer :economic_effect
      t.integer :diplomatic_effect
      t.integer :government_effect
      t.integer :societal_effect

      t.timestamps
    end
  end
end
