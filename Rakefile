# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

desc 'Generate Entity Relationship Diagram'
task :generate_erd do
  system "EAGER_LOAD=1 bundle RAILS_ENV=development exec erd --inheritance --filetype=dot --direct --attributes=foreign_keys,content"
  system "dot -Tpng erd.dot > ./db/erd/generated/erd_#{DateTime.now.strftime('%Q')}.png"
  # RAILS_ENV=development bundle exec rake environment generate_erd
end

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
      economic_effect: question["effect"]["econ"],
      diplomatic_effect: question["effect"]["dipl"],
      government_effect: question["effect"]["govt"],
      societal_effect: question["effect"]["scty"],
      content: question["questionV001"]
    )

    QuestionIteration.create!(
      question_id: q.id,
      version: 2,
      economic_effect: question["effect"]["econ"],
      diplomatic_effect: question["effect"]["dipl"],
      government_effect: question["effect"]["govt"],
      societal_effect: question["effect"]["scty"],
      content: question["questionV002"]
    )

  end
  # RAILS_ENV=development bundle exec rake environment make_questions

end

desc 'Populate ideologies'
task :populate_ideologies do
    
  ideologies = ActiveSupport::JSON.decode(File.read("db/ideologies.json"))
  
  ideologies.each.with_index(1) do |ideology, index|
  
    Ideology.create!(
      name: ideology["name"],
      definition: ideology["definition"],
      definition_source: ideology["definitionSource"],
      economic_effect: ideology["stats"]["econ"],
      diplomatic_effect: ideology["stats"]["dipl"],
      government_effect: ideology["stats"]["govt"],
      societal_effect: ideology["stats"]["scty"]
    )

  end
  # RAILS_ENV=development bundle exec rake environment populate_ideologies
end

desc 'Truncate QuestionFeedbacks'
task :truncate_question_feedbacks do
  QuestionFeedback.destroy_all
  ActiveRecord::Base.connection.execute("TRUNCATE question_feedbacks RESTART IDENTITY")
  # RAILS_ENV=development bundle exec rake environment truncate_question_feedbacks
end

desc 'Truncate TestResults'
task :truncate_test_results do
  TestResult.destroy_all
  ActiveRecord::Base.connection.execute("TRUNCATE test_results RESTART IDENTITY")
  # RAILS_ENV=development bundle exec rake environment truncate_test_results
end

task :make_question_feedbacks_test_results do
  
  seedfile = File.open("db/seeds_#{Time.now.getutc}.rb", 'a')
  
  question_feedbacks = QuestionFeedback.all.order(:id)
  question_feedbacks.each do |qf|
    seedfile.write "QuestionFeedback.create(#{qf.attributes})\n"
  end

  test_results = TestResult.all.order(:id)
  test_results.each do |tr|
    seedfile.write "TestResult.create(#{tr.attributes})\n"
  end

  seedfile.close
  #RAILS_ENV=development bundle exec rake environment make_question_feedbacks
end