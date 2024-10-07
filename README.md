Taylor'd Eunique Memories
At Taylor’d Eunique Memories, we believe that every event is a special moment waiting to be celebrated. Our photo booth services are designed to create unforgettable experiences, allowing you and your guests to capture memories that will last a lifetime. We pride ourselves on being a part of your most cherished moments, from weddings and birthdays to corporate events. Each click of the camera is a step towards preserving those Eunique memories that you can look back on with joy.

Getting Started
These instructions will get a copy of the project up and running on your local machine for development and testing purposes.

Prerequisites

Ruby version: 3.3.3
Rails version: 7.2.1
MYSQL version: 8.3
Node: 21.6.2
You can install Ruby and Rails via a version manager such as ASDF, RVM or rbenv.

Installation

Clone the repository:

git@github.com:vmcilwain/Taylord-eunique-memories.git
Install dependencies:

bundle install
Set up the database:

rails db:create db:migrate db:seed
Start the Rails server:

bin/dev
Now visit http://localhost:3000 in your browser to see the app in action.

Credentials

Development and test credentials need to be generated and the following keys/values are needed for the app to run properly. (master will most likely work as well since production has its own credentials)

Development: bin/rails credentials:edit -e development

Test: bin/rails credentials:edit -e test

# your local db cedentials

db:
user:
password:

# site domain name

domain:

# contact page email address

email:

# live mailserver credentials for testing

mailserver:
username:
password:

# the comopany phone number

phone:
Environment Variables

To run this project, you will need to set up the following environment variables:

LIVEMAIL (Live mail testing in development)
Set the env variable prior to starting the rails sever

LIVEMAIL=true bin/dev
to turn off sending live mail empty the value

LIVEMAIL=""
Running Tests
Run the all but the system tests:

rails test
Run the system tests

rails test:system
For individual test files, specify the file path:

rails test test/models/user_test.rb
Factories

This project uses FactoryBot for generating test data. To add a new factory, modify the /test/factories directory.

Deployment
This app is deployed using Capistrano.

SSH forwarding is also necessary for the deployment. It is recommended that you do not use your personal key to authenticate to production server but you generate a key specifically for it.

The setup:

Generate the key

ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
Copy it to the remote server

ssh-copy-id username@hostname_or_ip
Setup ~/.ssh/config

Host myserver
HostName hostname_or_ip
User username
IdentityFile ~/.ssh/id_rsa
Test the authentication

ssh hostname_or_ip
Start ssh forwarding agent

eval "$(ssh-agent -s)"
add your key(s)

ssh-add ~/.ssh/id_rsa
ssh-add ~.ssh/next_rsa
To deploy:

Push your changes to the main branch:

git push origin main
Tag the branch:

git tag <tag-name> -m "tag notes"
Push the tag:

git push origin <tag-name>
git push --tags # if more than one
Deploy the app

bundle exec capistrano production
Built With
Ruby on Rails - The web framework used
MYSQL - Database
Redis - Caching system
Bootstrap - Frontend framework
License
© 2024 Taylor'd Eunique Memories. All rights reserved.

This code is the intellectual property of Taylor'd Eunique Memories. No permissions are granted to use, modify, copy, or distribute this code without explicit written permission.
