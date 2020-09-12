class CreateQuestionFeedbacks < ActiveRecord::Migration[6.0]
  def change
    create_table :question_feedbacks do |t|
      t.integer :question_iteration_id
      t.integer :score
      t.string :explanation

      t.timestamps
    end
  end
end
