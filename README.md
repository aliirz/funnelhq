# Funnel

Funnel is an open source business management tool for freelancers. With Funnel you can manage your entire business from one centralised location. Track your expenses, invoice clients, manage projects, store important documents and more.

This is an open source version of the app running at funnelhq.com aimed at those who want to host this app on their own servers. 

Funnel is built on Ruby on Rails, Clojure and MongoDB.

![](https://github.com/owainlewis/funnelhq/raw/master/public/preview.png)

A live version is running at http://funnelhq.herokuapp.com. Please don't use the live site for anything other than demo purposes as it's likely that the database will be reset prior to launch.

You can login with the following email and password: 

+ email: admin@test.com 
+ password: testing

## Technology

+ MongoDB (Storage)
+ Rails 3
+ Clojure (Analysis and Analytics)
+ Amazon S3 for file storage

## Install

+ Install MongoDB
+ Set up your database config in config/mongoid.yml
+ Install dependencies (bundle install)
+ Set environment variables
+ Run rake db:seed

## Setting environment variables

Due to the open source nature of this app, environment variables are used to set private information such as mail config settings etc. If you're running OSX, you can set an environment var like this.
 
    export MAIL_USER=awesomeuser@gmail.com

The following environment variables are required. This is likely to trip you up the first time you're setting up the app.

+ MAIL_USER
+ MAIL_PASS 
+ RECURLY_API_KEY
+ RECURLY_JS_PRIVATE_KEY

## Creating a test user

Run the following rake command to generate a test user to login

    rake db:seed

## Rake tasks

There are two important Rake tasks included with the app. The first task makes a backup of your MongoDB database

    rake db:dump

This creates a mongodump of your database in the db directory.

The second task is for deploying your app to Heroku easily. Assuming your app is already set up with Heroku you can run

    rake heroku:deploy

This command does 3 things

+ Precompiles your assets (required for Heroku)
+ Checks your app into git
+ Pushes the app up to Heroku

## API

Funnel comes with a restful API for extracting user information.

Example API call to get all projects

    GET api_v1/:user_api_key/projects.xml

## License 

This software is provided free for users hosting it on their on system.

A hosted version will be available at funnelhq.com.