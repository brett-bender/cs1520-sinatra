# cs1520-sinatra
An example portfolio site in Sinatra for Pitt's CS1520 class.

## Getting Started

* Ruby Language
  * [Why's Poignant Guide to Ruby](http://poignant.guide/)
  * [Installing Ruby](https://www.ruby-lang.org/en/documentation/installation/)

* Ruby Ecosystem
  * [RubyGems](https://rubygems.org/)
  * [Sinatra](http://www.sinatrarb.com/)
  * [Bundler](http://bundler.io/) (optional)

## Starting a sinatra project

### Initial, one-time setup
1. Install Ruby
2. Install RubyGems
3. Install Bundler
4. Run `bundle init` in your project.
5. Add the line: `gem 'sinatra'` to your `Gemfile`
6. Run `bundle install`

Now you should have a working ruby installation with the tools necessary to build and work on the website.

You should be able to run `ruby portfolio.rb` to start the webserver locally and view the website at [localhost:4567](http://localhost:4567)

## Database setup

I've tried to outline the steps for setting this up,
but if you have any difficulty refer to the installation instructions
provided by the gem author for the
[sinatra-activerecord](https://github.com/janko-m/sinatra-activerecord) project.

1. Add the `sqlite3` and `sinatra-activerecord` gems to your Gemfile.
  * `gem 'sinatra-activerecord'`
  * `gem 'sqlite3'`
2. Run `bundle install`
3. Add a Rakefile to allow you to run rake tasks from the command line.
4. Make the Rake tasks defined by activerecord available by requiring the rake file in activerecord in your Rakefile.
  * `require 'sinatra/activerecord/rake'`
5. Test that you have access to the rake tasks by running `rake -T` in your project directory. You should get roughly the following output:

```ruby
rake db:create              # Creates the database from DATABASE_URL or config/databa...
rake db:create_migration    # Create a migration (parameters: NAME, VERSION)
rake db:drop                # Drops the database from DATABASE_URL or config/database...
rake db:environment:set     # Set the environment value for the database
rake db:fixtures:load       # Loads fixtures into the current environment's database
rake db:migrate             # Migrate the database (options: VERSION=x, VERBOSE=false...
rake db:migrate:status      # Display status of migrations
rake db:rollback            # Rolls the schema back to the previous version (specify ...
rake db:schema:cache:clear  # Clears a db/schema_cache.dump file
rake db:schema:cache:dump   # Creates a db/schema_cache.dump file
rake db:schema:dump         # Creates a db/schema.rb file that is portable against an...
rake db:schema:load         # Loads a schema.rb file into the database
rake db:seed                # Loads the seed data from db/seeds.rb
rake db:setup               # Creates the database, loads the schema, and initializes...
rake db:structure:dump      # Dumps the database structure to db/structure.sql
rake db:structure:load      # Recreates the databases from the structure.sql file
rake db:version             # Retrieves the current schema version number
```

6. Configure your application to use sqlite and specify a database location.
  * Add the following line to your `portfolio.rb`
  * `set :database, {adapter: "sqlite3", database: "portfolio.sqlite3"}`
7. Create your database `rake db:create`
8. Create a migration to create your database table.
  * `rake db:create_migration NAME=create_messages`
9. Add the columns you would like in the migration file (located in your newly-created `db/migrate` directory)
10. Run the migration (this will actually create the table that is specified in the migration file)
  * `rake db:migrate`

Congratulations! You now have a real database ready to hold your data. Now we create a Ruby object to hook the code up to it.

See the [Message model file](//github.com/brett-bender/cs1520-sinatra/tree/master/message.rb)
for implementation details, as well as the `post '/contact'` route in `portfolio.rb`
