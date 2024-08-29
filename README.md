# README

# Project Name - IterableEvent Application

In this project we had done mocking of the itrable.com api's. we have mocked the event creation
api and the email send api.

## Table of Contents

- [Technology Stack](#technology-stack)
- [Setup](#setup)

## Technology Stack

### RUBY
  Installed ruby version
- **Ruby 3.2.3**: Programming language used in Rails development.
  ### with RVM
  - \curl -sSL https://get.rvm.io -o rvm.sh
  - rvm install ruby-3.2.3
  ### with rbenv
  - curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash
  - rbenv install rbenv-3.2.3

### RAILS
  Installed rails version
- **Rails 7.1**: Backend framework for web development.

### MYSQL
  Installed mysql version
- **MySQL**: Database management system.


## Setup
  ### Prerequisites
    Needed to run the appplication on the machine:
    - yarn 1.22.19
    - ruby-3.2.3
    - Node v20.8.0

  1. Clone the repository:

  git clone https://github.com/jyotizi/iterable-event-app.git

  2. `cd iterable-event-app`

  3. Run `bundle install`

  4. Run `yarn install`

  5. Run `rails db:setup` if it's not working then try to follow this step

    - Run rails db:create
    - Run rails db:migrate

  6. Run `rails s`

