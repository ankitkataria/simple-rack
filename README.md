# Simple Rack

> A [rack](https://github.com/rack/rack) application to convert numerical values to words

A simple rack-application built with the help of [hanami/controller](https://github.com/hanami/controller) and [hanami/router](https://github.com/hanami/router). The application is modelled around MVC approach with a directory stucture inspired from Rails.

## Set Up

Before proceeding clone repo:

```bash
$ git clone git@github.com:ankitkataria/simple-rack.git
$ cd ./simple-rack
```

### With Docker

```bash
$ docker build -t simple-rack .
$ docker run -p 3001:3001 -it simple-rack
```

### Without Docker

- Requirements
    - `ruby 2.6.5`
    - `bundler 2.1.4`

```bash
$ bundle install
$ bundle exec rackup --port 3001 config.ru
```

## Sample cURL

```bash
$ curl http://localhost:3001/identity -X GET

# {"server_name":"Ankit Kataria"}

$ curl http://localhost:3001/convert -X POST \
    -H 'content-type: application/json' \
    -d '{"value": 1729}'

# {"value":1729,"value_in_words":"one thousand seven hundred twenty nine"
```

## Development

Run linter and appropriate specs before opening a pull request.

### Running linter and tests

```bash
# Run rubocop
$ bundle exec rubocop

# Run rspec
$ bundle exec rspec --format documentation
```

## Licence

This project is licensed under the [MIT License](https://opensource.org/licenses/MIT).


