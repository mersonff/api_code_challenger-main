# Api Code Challenge

API for storing DNS records (IP addresses) belonging to hostnames done using Ruby on Rails 6 and PostgreSql.

### Requirements

You can run this project using docker-compose if you don't want to mess up with
your own machine. The guide below will be for using docker-compose.

### Installation

Follow the steps below

```sh
$ Clone the repo

$ cd api_code_challenge

$ docker-compose build

$ docker-compose run web bundle exec rails db:create

$ docker-compose run web bundle exec rails db:migrate

$ docker-compose up
```

Now visit: http://localhost:3000/api/v1/dns_records to go directly to the api index endpoint.

### Running Tests

Use the following commands to run the automated tests.

```sh
$ docker-compose run web bundle exec rspec
```

### API Endpoint #1 - [POST] /api/v1/dns_records or /dns_records

Below are the curl snippets to populate the database for testing.

```sh
curl --request POST \
  --url http://localhost:3000/api/v1/dns_records \
  --header 'content-type: application/json' \
  --data '{
	"dns_records": {
		"ip": "1.1.1.1",
		"hostnames_attributes": [
			{
				"hostname": "lorem.com"
			},
			{
				"hostname": "ipsum.com"
			},
			{
				"hostname": "dolor.com"
			},
			{
				"hostname": "amet.com"
			}
		]
	}
}'

curl --request POST \
  --url http://localhost:3000/api/v1/dns_records \
  --header 'content-type: application/json' \
  --data '{
	"dns_records": {
		"ip": "2.2.2.2",
		"hostnames_attributes": [
			{
				"hostname": "ipsum.com"
			}
		]
	}
}'

curl --request POST \
  --url http://localhost:3000/api/v1/dns_records \
  --header 'content-type: application/json' \
  --data '{
	"dns_records": {
		"ip": "3.3.3.3",
		"hostnames_attributes": [
			{
				"hostname": "ipsum.com"
			},
			{
				"hostname": "dolor.com"
			},
			{
				"hostname": "amet.com"
			}
		]
	}
}'

curl --request POST \
  --url http://localhost:3000/api/v1/dns_records \
  --header 'content-type: application/json' \
  --data '{
	"dns_records": {
		"ip": "4.4.4.4",
		"hostnames_attributes": [
			{
				"hostname": "sit.com"
			},
			{
				"hostname": "ipsum.com"
			},
			{
				"hostname": "dolor.com"
			},
			{
				"hostname": "amet.com"
			}
		]
	}
}'

curl --request POST \
  --url http://localhost:3000/api/v1/dns_records \
  --header 'content-type: application/json' \
  --data '{
	"dns_records": {
		"ip": "5.5.5.5",
		"hostnames_attributes": [
			{
				"hostname": "dolor.com"
			},
			{
				"hostname": "sit.com"
			}
		]
	}
}'
```

### API Endpoint #2 - [GET] /api/v1/dns_records or /dns_records

Querying the dns_records:

```sh
curl --request GET \
  --url 'http://localhost:3000/dns_records?included=ipsum.com,dolor.com&excluded=sit.com' \
  --header 'content-type: application/json'
```
