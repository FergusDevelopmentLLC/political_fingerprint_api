class QuestionIteration < ApplicationRecord
  belongs_to :question
  has_many :question_responses
end
