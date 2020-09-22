## Links

https://github.com/ipinfo/rails  
https://ipinfo.io/  
https://github.com/rahulkanholkar/url_shortner_app/blob/4b9963574c25c93185b5486eaf2d897c09e78c80/config/environment.rb  

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
9. $ RAILS_ENV=development rails g scaffold QuestionIteration question_id:integer version:integer content:string economic_effect:integer diplomatic_effect:integer government_effect:integer societal_effect:integer
10. $ RAILS_ENV=development rails g scaffold QuestionFeedback question_iteration_id:integer score:integer explanation:string  
11. $ RAILS_ENV=development rails g scaffold Ideology name:string definition:string definition_source:string economic_effect:integer diplomatic_effect:integer government_effect:integer societal_effect:integer  
12. $ RAILS_ENV=development rake db:migrate  
13. $ RAILS_ENV=development rake db:seed
14. Add model relationships:
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

class QuestionFeedback < ApplicationRecord
  belongs_to :question_iteration
end
```
15. Update config/routes.rb
```
Rails.application.routes.draw do
  resources :ideologies
  resources :question_feedbacks

  resources :categories do
    resources :questions do
      resources :question_iterations do
        resources :question_feedbacks
      end
    end
  end
  resources :questions do
    resources :question_iterations do
      resources :question_feedbacks
    end
  end

  get 'questions/by_version/:version', to: 'questions#by_version'
end
```
16. $ RAILS_ENV=development bundle exec rake environment make_questions  
17. $ RAILS_ENV=development bundle exec rake environment populate_ideologies  
18. $ RAILS_ENV=development bundle exec rake environment truncate_question_feedbacks  
19. $ RAILS_ENV=development bundle exec rake environment truncate_question_feedbacks  
20. $ RAILS_ENV=development rails g scaffold TestResult client_ip:string question_version:integer economic:float diplomatic:float civil:float societal:float
21. $ RAILS_ENV=development rake db:migrate  
===========================================
22. $ RAILS_ENV=development rails generate migration add_country_countryname_region_city_latitude_longitude_to_test_results country:string country_name:string region:string city:string latitude:float longitude:float
21. $ RAILS_ENV=development rake db:migrate  
===========================================
22. $ RAILS_ENV=development rake db:migrate
===========================================
23. $ RAILS_ENV=development rails g scaffold CongressionalDistrict geoid:string name:string latitude:float longitude:float  
24. $ RAILS_ENV=development rake db:migrate
===========================================
25. $ RAILS_ENV=development rails g scaffold County geoid:string name:string state:string latitude:float longitude:float
26. $ RAILS_ENV=development rake db:migrate