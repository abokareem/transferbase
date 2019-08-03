# Transferbase

Transferbse is a web based application for transferring money between user accounts easily and by using different currencies.

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
docker-compose run --rm app rails db:create
docker-compose run --rm app rails db:migrate
docker-compose run --rm app rails db:seed # For possibly available seed data
```

## Application Up and Running

Access the application web page by typing `http://localhost:3000` to a web browser.