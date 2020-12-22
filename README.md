# How to Host to Heroku

## Step 1 - setting up your environment
- Make an account at [heroku.com](https://www.heroku.com/)
- Download & install [Postgresql](https://www.postgresql.org/)

## Step 2 - create a Heroku app
- Log into your Heroku account
- Click 'New'  --> 'Create new app'
- Name your application

## Step 3 - Choose how you want to deploy your application
- Choose Heroku git or Github

## Step 4 - Change your Sinatra production database to Postgresql
- Group your Gemfile into development and production
- Move sqlite3 into the development group (along with other gems that are just used for development)

```
group :development do
  gem 'sqlite3', '~> 1.3.6'
  gem 'tux'
  gem 'pry'
  gem 'shotgun'
end
```

- Add postgresql to the production group

```
group :production do
  gem 'pg', '~> 0.20'
end
```

- delete the gemfile.lock and run `bundle install`

## Configure the Database
Create a `config/database.yml` file:

```
# config/database.yml
development:
  adapter: sqlite3
  encoding: unicode
  database: db/development.sqlite3
  pool: 5
production:
  adapter: postgresql
  encoding: unicode
  pool: 5
```

and we'll need to update our `config/environment.rb` file to use this file to establish a connection to our DB. To do that, replace these lines
```
# config/environment.rb
# ...

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
)
```
with
```
set :database_file, "./database.yml"
```

## Create a Procfile
- Add the `gem 'foreman'` to your gemfile
- Create a Procfile with the following code:
```
web: bundle exec thin start -p $PORT
release: bundle exec rake db:migrate
```
- This tells Heroku how to start the server and to run migrations before releasing a build

## Add Config Vars
- Go to your app settings on Heroku and set the following variables:
    - SINATRA_ENV = production
    - SESSION_SECRET = 335673ae2a1c5cccec147456
- Ensure your local .env variables only load in development so they don't override the Heroku variables:
    - In your config/environment.rb:
    ```
    Dotenv.load if ENV['SINATRA_ENV'] == "development"
    ```
## Commit all changes and push code to github
- `git add . `
- `git commit -m "configure app for heroku"`
- `git push origin master`
- Go to heroku and deploy your master branch


### Troubleshooting
When I updated my ruby version I also installed bundler v2. Heroku wants an older version of bundler (1.15.2) when I do the deployment, so I had to install it as well and then figure out how to use it to generate the Gemfile.lock.

```
gem install bundler -v 1.15.2
bundle _1.15.2_ install
```

### Resources
- [Heroku Hosting Example Video](https://www.youtube.com/watch?v=wzUumUGNEPQ&feature=youtu.be)
- [Additional Guidelines](https://github.com/DakotaLMartinez/sinatra-heroku-demo/blob/master/README.md)
