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
===========================================
27. $ RAILS_ENV=development rails g scaffold City name:string state_abbrev:string state_name:string county_name:string latitude:float longitude:float
26. $ RAILS_ENV=development rake db:migrate
===========================================
28. $ RAILS_ENV=development rails generate migration add_county_id_to_test_results county_id:integer
29. $ RAILS_ENV=development rake db:migrate
===========================================
30. $ RAILS_ENV=development rails generate migration RemoveCountryFromTestResults country:string
31. $ RAILS_ENV=development rails generate migration RemoveCountryNameFromTestResults country_name:string
32. $ RAILS_ENV=development rails generate migration RemoveRegionFromTestResults region:string
33. $ RAILS_ENV=development rails generate migration RemoveCityFromTestResults city:string
34. $ RAILS_ENV=development rails generate migration RemoveLatitudeFromTestResults latitude:float
35. $ RAILS_ENV=development rails generate migration RemoveLongitudeFromTestResults longitude:float
29. $ RAILS_ENV=development rake db:migrate
===========================================
30. $ RAILS_ENV=development rails generate migration add_county_override_to_test_results county_override:boolean
31. $ RAILS_ENV=development rails generate migration add_opt_in_to_test_results opt_in:boolean
===========================================
32. rails generate model Province geoid:string name:string countyfp:string state_abbrev:string state_name:string latitude:float longitude:float
<!-- edit slightly -->

RAILS_ENV=development rails generate migration add_province_geoid_to_test_results province_geoid:string

<!-- RAILS_ENV=development rails generate migration add_province_geoid_to_test_results province_geoid:string

class AddProvinceGeoidToTestResults < ActiveRecord::Migration[6.0]
  def change
    add_column :test_results, :province_geoid, :string
  end
end

class AddForeignKeyForProvinceOnTestResults < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :test_results, :provinces, column: 'province_geoid', primary_key: 'geoid'
  end
end -->

<!-- class CreateProvinces < ActiveRecord::Migration[6.0]
  def change
    create_table :provinces, id: false do |t|

      t.primary_key :geoid, :string, limit: 6
      
      t.string :name
      t.string :countyfp
      t.string :state_abbrev
      t.string :state_name
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end -->

SELECT id, , created_at, updated_at
  FROM public.counties
  order by geoid;

select * from provinces
order by geoid;

INSERT INTO provinces (geoid, name, countyfp, state_abbrev, state_name, latitude, longitude, created_at, updated_at)
SELECT geoid, name, countyfp, state_abbrev, state_name, latitude, longitude, now() as created_at, now() as updated_at
FROM counties;

select * from test_results;

delete from test_results where id > 10;

select * from counties where id = 2406;

select test_results.*, c.geoid
from test_results
join counties c on c.id = test_results.county_id;

UPDATE
    test_results
SET
    test_results.province_geoid = c.geoid
FROM 
    test_results
    INNER JOIN counties c on c.id = test_results.county_id;

UPDATE test_results
SET test_results.province_geoid = counties.geoid
FROM test_results
JOIN counties ON test_results.county_id = counties.id;


UPDATE test_results
SET province_geoid = counties.geoid
FROM test_results
JOIN counties ON test_results.county_id = counties.id;


UPDATE tr
SET    tr.province_geoid = c.geoid
FROM   test_results tr
       INNER JOIN counties c ON tr.county_id = c.id;



UPDATE test_results
SET province_geoid = b_alias.geoid
FROM      test_results AS a_alias
JOIN counties AS b_alias ON a_alias.county_id = b_alias.id;

select geoid from counties where id = 2406;
update test_results set province_geoid = '48439' where county_id = 2406;

select geoid from counties where id = 469;
update test_results set province_geoid = '08031' where county_id = 469;

select geoid from counties where id = 170;
update test_results set province_geoid = '36081' where county_id = 170;

select geoid from counties where id = 619;
update test_results set province_geoid = '53073' where county_id = 619;

select geoid from counties where id = 49;
update test_results set province_geoid = '06085' where county_id = 49;

select geoid from counties where id = 714;
update test_results set province_geoid = '42027' where county_id = 714;

select geoid from counties where id = 581;
update test_results set province_geoid = '48453' where county_id = 581;

def counties_by_state

    counties = County.all
    states = counties.group_by{ |county| [county.state_name, county.state_abbrev] }.sort_by{ |state| state }
    
    return_array = []
    
    states.each { |state|
      st = {}
      st['name'] = state[0][0]
      st['abbrev'] = state[0][1]
      st['counties'] = []
      counties.each { |county| 
        if(county.state_name == state[0][0])
          c = {}
          c['name'] = county.name
          c['geoid'] = county.geoid
          st['counties'].push(c)
        end
      }

      st['counties'] = st['counties'].sort_by { |county| county['name'] }
      
      return_array.push(st)
    }
    
    render json: return_array
  end