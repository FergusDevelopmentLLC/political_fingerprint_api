##Created by:  
1. $ rails new political_fingerprint_api --database=postgresql --api  
2. edit config/database.yml to add information credentials to your local db  
3. $ sudo adduser political_fingerprint_api -- Make a new local user called political_fingerprint_api
4. $ sudo usermod -aG sudo political_fingerprint_api -- Make user root
5. Set up the db user in pgAdmin:  
![image](https://user-images.githubusercontent.com/1529796/91760410-8fe21d80-eb90-11ea-8f89-ba1f15f8b7bc.png)  
6. Make sure to set user political_fingerprint_api password  
![image](https://user-images.githubusercontent.com/1529796/91763604-10098280-eb93-11ea-8068-1731258db262.png)
7. Edit config/database.yml to match the new user
```
test:
  adapter: postgresql
  encoding: unicode
  database: political_fingerprint_api
  pool: 5
  username: political_fingerprint_api
  password: sunflower13

development:
  adapter: postgresql
  encoding: unicode
  database: political_fingerprint_api
  pool: 5
  username: political_fingerprint_api
  password: sunflower13

production:
  adapter: postgresql
  encoding: unicode
  database: political_fingerprint_api
  host: localhost
  pool: 5
  username: political_fingerprint_api
  password: <%= ENV['DATABASE_PASSWORD'] %>
```  
7. $ RAILS_ENV=development rails g scaffold Category name:string  
8. $ RAILS_ENV=development rails g scaffold Question category_id:integer current_version:integer 
9. $ RAILS_ENV=development rails g scaffold QuestionIteration question_id:integer version:integer content:string  
10. $ RAILS_ENV=development rails g scaffold QuestionResponse question_iteration_id:integer score:integer delete_question:boolean explanation:string  
11. $ RAILS_ENV=development rake db:migrate  
12. $ RAILS_ENV=development rake db:seed
13. Add model relationships:
```
class Category < ApplicationRecord
  has_many :questions
end

class Question < ApplicationRecord
  belongs_to :category
  has_many :question_iterations
end

class QuestionIteration < ApplicationRecord
  belongs_to :question
  has_many :question_responses
end

class QuestionResponse < ApplicationRecord
  belongs_to :question_iteration
end
```
14. Update config/routes.rb
```
Rails.application.routes.draw do
  resources :categories do
    resources :questions do
      resources :question_iterations do
        resources :question_responses
      end
    end
  end
  resources :questions do
    resources :question_iterations do
      resources :question_responses
    end
  end
end
```
15. $ RAILS_ENV=development bundle exec rake environment make_questions