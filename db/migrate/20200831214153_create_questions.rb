class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.integer :current_question_iteration_id

      t.timestamps
    end
  end
end
