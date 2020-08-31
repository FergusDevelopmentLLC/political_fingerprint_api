class Question < ApplicationRecord
  belongs_to :category
  has_many :question_iterations
end
