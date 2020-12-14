# Political Fingerprint API (Back end API)

This is the backend for Politipoint, a quiz to help you understand your political leanings.

## Installation

1. You must have a local [Postgres](https://www.postgresql.org/) development database server running.
2. Clone this repository.
3. Create a system user named political_fingerprint_api to act as the user to connect to the database for this app. Note password used for political_fingerprint_api user here.

```
$ sudo adduser political_fingerprint_api
```
4. Make the user be a root user.
```
$ sudo usermod -aG sudo political_fingerprint_api
```
5. Impersonate the postgres user on your system and create the political_fingerprint_api database and political_fingerprint_api database user. The database is also called political_fingerprint_api. 
```
$ su — postgres
$ createuser political_fingerprint_api
$ createdb political_fingerprint_api
```
6. Provide the privileges to political_fingerprint_api user in psql, for the political_fingerprint_api database.
```
postgres@computer:~$ psql
postgres=# alter user political_fingerprint_api with encrypted password '<password for political_fingerprint_api>';
postgres=# grant all privileges on database political_fingerprint_api to political_fingerprint_api;

```
7. Update config/database.yml with your database credentials, similar to this this:
```
development:
  adapter: postgresql
  encoding: unicode
  database: political_fingerprint_api
  pool: 2
  username: political_fingerprint_api
  password: <password for political_fingerprint_api>
  host: localhost
  port: 5432
```
8. Start the backend app.

```
$ cd political_fingerprint_api
$ bundle install
$ RAILS_ENV=development rails s
```

## Front end repository

This back end drives the following React/Redux based front end:  
https://github.com/FergusDevelopmentLLC/politipoint_fe

## Contributing Bugfixes or Features

* Fork the this repository
* Create a local development branch for the bugfix; I recommend naming the branch such that you'll recognize its purpose.
* Commit a change, and push your local branch to your github fork
* Send me pull request for your changes to be included

## License

Political Fingerprint API is licensed under the MIT license. (http://opensource.org/licenses/MIT)