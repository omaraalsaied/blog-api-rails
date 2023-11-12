# README

* Ruby version
    ruby 3.2.2
    rails 7.0.8
* System dependencies
    -
* Configuration
    for the portable installation first make sure you've ruby, postgresql & redis installed then: 
        . run gem install rails -v 7.0.8
        . clone the repo
        . run bundle install
        . configure the db in config/database.yml file with the username/password of your DB
        . run rails db:create
        . run rails db:migrate
        . start the project by running rails s
        

    for the docker compose you need to 
        . run docker build
        . run "docker compose up" 
        . in another terminal run "docker compose run web rails db:create" then  "docker compose run web rails db:migrate"

* Services (job queues, cache servers, search engines, etc.)
    only job queues are to delete the posts of the blog after 24h using sidekiq & redis


API NOTES: 
    . auth routes: 
        127.0.0.1:3000/signup
        127.0.0.1:3000/login
        127.0.0.1:3000/logout

        . for signup, the body of the request should look like this: 
        {
            "user": {
                "email": "user2@test.com",
                "name": "user2",
                "password": "123456"
            }
        }

        . for login, the body of the request should look like this: 
        {
            "user": {
                "email": "user2@test.com",
                "password": "123456"
            }
        }
       


    ** ALL OF THE BELOW ROUTES DEMAND AUTHENTICATION, SO MAKE SURE YOU INSERT THE TOKEN YOU GET ON LOGIN ON THE REQUEST HEADERS **

     . for logout , just send an empty body to the logout endpoint

    . to get the current user data 
        just send an empty body to the endpoint below: "don't forget the token :) "
            127.0.0.1:3000/current_user


    . posts routes:
        127.0.0.1:3000/api/v1/posts
            each request method is mapped to a function inside the resource controller 
            for example to create a post: 
                POST @ 127.0.0.1:3000/api/v1/posts 
                body: 
                    {
                        "title": "blah blah",
                        "body" : "blah blah but in the body",
                        "tags" : "blah blaah" 
                    }

    
    . comments routes: 
        127.0.0.1:3000/api/v1/posts
            each request method is mapped to a function inside the resource controller except for the index
             for example to leave a comment on a post: 
                POST @ 127.0.0.1:3000/api/v1/comments 
                body: 
                    {
                        "post_id": 1,
                        "body" : "blaah comment ",
                    }