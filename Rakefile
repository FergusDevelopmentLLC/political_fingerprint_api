# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

desc 'Make Questions'
task :make_questions do
  
  questions = ActiveSupport::JSON.decode(File.read("db/questions.json"))
  questions.each.with_index(1) do |question, index|
  
  q = Question.create!(
    category_id: Category.find_by(name: question["category"]).id,
    current_version: 1
  )

  QuestionIteration.create!(
    question_id: q.id,
    version: 1,
    content: question["questionV001"]
  )

  QuestionIteration.create!(
    question_id: q.id,
    version: 2,
    content: question["questionV002"]
  )

end

  # RAILS_ENV=development bundle exec rake environment make_questions
end