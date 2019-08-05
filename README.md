# Transferbase

Transferbase is a web based application for transferring money between user accounts easily and by using different currencies.

## System Dependencies

You will need the following things properly installed on your computer.

* [Git](https://git-scm.com/)
* [Docker CE](https://www.docker.com/community-edition#/download)
* [Docker Compose](https://docs.docker.com/compose/install/)

## Getting Started

Clone the repository:

```bash
git clone git@github.com:kenan-memis/transferbase.git
cd transferbase
```

## Development

```bash
docker-compose up -d
docker-compose ps # Check for any errors
docker-compose run --rm app bin/rails db:create
docker-compose run --rm app bin/rails db:migrate
docker-compose run --rm app bin/rails db:seed # For possibly available seed data
```

## Application Up and Running

Access the application web page by typing `http://localhost:3000` to a web browser.

## Confirmation Emails

Application uses (only on development environment) `letter_opener_gem` in order to see a the confirmation emails.
To use it, after sign up, go to `http://localhost:3000/leter_opener` page to confirm your registration.


## Running Tests
As the test suit, the application uses [RSpec](https://rspec.info/). You can run the tests with the following command:

```
$ docker-compose run --rm app bundle exec rspec
``` 

## Code Coverage

Code coverage is available via [SimpleCov](https://github.com/colszowka/simplecov).
When the test suit is running, code coverage report is automatically generated under `coverage/index.html` file.
Then open the generated `coverage/index.html` in your browser.


## Linting

[Rubocop](https://github.com/bbatsov/rubocop) is used to lint the code.

```bash
$ docker-compose run --rm app bundle exec rubocop
```

## Exchange Rate API

Application uses a [Foreign exchange rates API](https://exchangeratesapi.io/) which is a free service for current and historical foreign exchange rates 
published by the [European Central Bank](https://www.ecb.europa.eu/stats/policy_and_exchange_rates/euro_reference_exchange_rates/html/index.en.html)
