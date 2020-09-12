class CreateQuestionIterations < ActiveRecord::Migration[6.0]
  def change
    create_table :question_iterations do |t|
      t.integer :question_id
      t.integer :version
      t.string :content
      t.integer :economic_effect
      t.integer :diplomatic_effect
      t.integer :government_effect
      t.integer :societal_effect

      t.timestamps
    end
  end
end
