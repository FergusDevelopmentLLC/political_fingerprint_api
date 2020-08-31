class CreateQuestionIterations < ActiveRecord::Migration[6.0]
  def change
    create_table :question_iterations do |t|
      t.integer :question_id
      t.string :content

      t.timestamps
    end
  end
end
