# Taylor'd Eunique Memories

At Taylor’d Eunique Memories, we believe that every event is a special moment waiting to be celebrated. Our photo booth services are designed to create unforgettable experiences, allowing you and your guests to capture memories that will last a lifetime. We pride ourselves on being a part of your most cherished moments, from weddings and birthdays to corporate events. Each click of the camera is a step towards preserving those Eunique memories that you can look back on with joy.

## Getting Started

These instructions will get a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

- Ruby version: `3.3.3`
- Rails version: `7.2.1`
- Puma `6.4.3`
- MYSQL version: `8.3`
- Node: `21.6.2`

Development:

- [MailDev](https://github.com/maildev/maildev)

You can install Ruby and Rails via a version manager such as [ASDF](https://asdf-vm.com), [RVM](https://rvm.io/) or [rbenv](https://github.com/rbenv/rbenv).

### Installation

1. Clone the repository:

   ```bash
   git@github.com:vmcilwain/Taylord-eunique-memories.git
   ```

2. Install dependencies:

   ```
   bundle install
   ```

3. Set up the database:

   ```
   rails db:create db:migrate db:seed
   ```

4. Start the Rails server:

   ```bash
   bin/dev
   ```

Now visit [http://localhost:3000](http://localhost:3000) in your browser to see the app in action.

### Credentials

Development and test credentials need to be generated and the following keys/values are needed for the app to run properly. (master will most likely work as well since production has its own credentials)

Development: `bin/rails credentials:edit -e development`

Test: `bin/rails credentials:edit -e test`

```yaml
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

# the company phone number
phone:
```

### Environment Variables

To run this project, you will need to set up the following environment variables:

- `LIVEMAIL` (Live mail testing in development)

Set the env variable prior to starting the rails sever

```bash
LIVEMAIL=true bin/dev
```

to turn off sending live mail empty the value

```bash
LIVEMAIL=""
```

## Running Tests

Run the all but the system tests:

```bash
rails test
```

Run the system tests

```bash
rails test:system
```

For individual test files, specify the file path:

```bash
rails test test/models/user_test.rb
```

### Factories

This project uses `FactoryBot` for generating test data. To add a new factory, modify the `/test/factories` directory.

## Deployment

This app is deployed using [Capistrano](https://capistranorb.com).

SSH forwarding is also necessary for the deployment. It is recommended that you do not use your personal key to authenticate to production server but you generate a key specifically for it.

The setup:

Generate the key

```bash
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

Copy it to the remote server

```bash
ssh-copy-id username@hostname_or_ip
```

Setup `~/.ssh/config`

```bash
Host myserver
    HostName hostname_or_ip
    User username
    IdentityFile ~/.ssh/id_rsa
```

Test the authentication

```bash
ssh hostname_or_ip
```

Start ssh forwarding agent

```bash
eval "$(ssh-agent -s)"
```

add your key(s)

```
ssh-add ~/.ssh/id_rsa
ssh-add ~.ssh/next_rsa
```

To deploy:

Push your changes to the main branch:

```bash
git push origin main
```

Tag the branch:

```bash
git tag <tag-name> -m "tag notes"
```

Push the tag:

```bash
git push origin <tag-name>
git push --tags # if more than one
```

Deploy the app

```bash
bundle exec capistrano production
```

## Built With

- [Ruby on Rails](https://rubyonrails.org/) - The web framework used
- [MYSQL](https://www.mysql.com/) - Database
- [Redis](https://redis.io/) - Caching system
- [Bootstrap](https://getbootstrap.com/) - Frontend framework

## License

© 2024 Taylor'd Eunique Memories. All rights reserved.

This code is the intellectual property of Taylor'd Eunique Memories. No permissions are granted to use, modify, copy, or distribute this code without explicit written permission.
