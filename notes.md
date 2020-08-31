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
7. $ rails g scaffold Category name:string  
8. $ RAILS_ENV=development rake db:migrate  
9. $ RAILS_ENV=development rake db:seed  
10. At this point you should have your db working and populated with Category models.  

