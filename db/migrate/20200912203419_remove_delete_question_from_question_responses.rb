class RemoveDeleteQuestionFromQuestionResponses < ActiveRecord::Migration[6.0]
  def change
    remove_column :question_responses, :delete_question, :boolean
  end
end
