class CreateQuestionResponses < ActiveRecord::Migration[6.0]
  def change
    create_table :question_responses do |t|
      t.integer :question_iteration_id
      t.integer :score
      t.boolean :delete_question
      t.string :explanation

      t.timestamps
    end
  end
end
