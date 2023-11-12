# README

## Ruby and Rails Versions
- Ruby: 3.2.2
- Rails: 7.0.8

## System Dependencies
- None specified

## Configuration

### Portable Installation

1. Ensure you have Ruby, PostgreSQL, and Redis installed.
2. Run gem install rails -v 7.0.8.
3. Clone the repository.
4. Run bundle install.
5. Configure the database in the config/database.yml file with the username/password of your DB.
6. Run rails db:create.
7. Run rails db:migrate.
8. Start the project by running rails s.

### Docker Compose Installation

1. Run docker build.
2. Run docker compose up.
3. In another terminal, run docker compose run web rails db:create, then docker compose run web rails db:migrate "for first time only".

## Services (Job Queues, Cache Servers, Search Engines, etc.)

- Job queues are used to delete blog posts after 24h using Sidekiq and Redis.

## API NOTES

### Auth Routes

- Signup: 127.0.0.1:3000/signup
- Login: 127.0.0.1:3000/login
- Logout: 127.0.0.1:3000/logout

Signup Request Body
```json
{
    "user": {
        "email": "user2@test.com",
        "name": "user2",
        "password": "123456"
    }
}
```
Login Request Body
```json

{
    "user": {
        "email": "user2@test.com",
        "password": "123456"
    }
}
```

**Note**: All subsequent routes require authentication. Insert the token obtained during login in the request headers.

- Logout: Send an empty body to the logout endpoint.
- Get current user data: Send an empty body to 127.0.0.1:3000/current_user.

### Posts Routes

- All methods are mapped to functions inside the resource controller.
- To create a post:
  - Method: POST
  - URL: 127.0.0.1:3000/api/v1/posts
  - Body:
```json

    {
        "title": "blah blah",
        "body" : "blah blah but in the body",
        "tags" : "blah blaah" 
    }
```
### Comments Routes

- All methods, except for the index, are mapped to functions inside the resource controller.
- To leave a comment on a post:
  - Method: POST
  - URL: 127.0.0.1:3000/api/v1/comments
  - Body:
```json
    {
        "post_id": 1,
        "body" : "blaah comment "
    }
```
