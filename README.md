# Lunch and Learn - API

### Overview and learing goals

    The purpose of this project is to explore back-end data consumption and manipulation from several external APIs. This project also implements CRUD, and authentication functionality while utilizing end to end testing to ensure high quality and functional code.A user of this application will be able to find recipes based on a provided query of a country, find useful information about a country with a similar country query, be able to securely log in with a password and be provided with an API key for subsequent request, as well as add and make requests for their user information. 
  

### System dependencies
Gems: 
- faraday
- bcrypt
- Jsonapi-serialiser

External API keys:
- [Edamam](https://developer.edamam.com/edamam-docs-recipe-api)
- [RESTcountries](https://restcountries.com/#endpoints-similar-projects)
- [Google-YoutubeAPI](https://developers.google.com/youtube/v3/getting-started)


### Set up this repo
Step: 

1. Fok and clone this repository to your local machine
2. Run bundle install in the root directory of this project on your command line
3. Run rails db:{create, migrate, seed}
4. Input the keys from your APIs in the links above in the credentials.rml file of the configure directory
  * Note: if you do not know how to do this, you can copy and paste the API keys into each service in the method #conn, and replace the ```Rails.application.credentials.key[:api_key]``` seen in all services with corresponding keys. If you don't know how to do this, I'm not sure why you're looking at this repo in the first place but feel free to contact me at my email that can be found on my github profile. 
5. Once credentials are entered, spin up your local server. 

### Endpoints

1. GET http://localhost:3000/api/v1/recipes  
  - Takes a parameter of country - any country in the world
  - Returns recipes based on the country provided

  Returns the following JSON:
```{
    "data": [
        {
            "id": null,
            "type": "recipe",
            "attributes": {
                "title": "Andy Ricker's Naam Cheuam Naam Taan Piip (Palm Sugar Simple Syrup)",
                "url": "https://www.seriouseats.com/recipes/2013/11/andy-rickers-naam-cheuam-naam-taan-piip-palm-sugar-simple-syrup.html",
                "country": "thailand",
                "image": "https://edamam-product-images.s3.amazonaws.com..."
            }
        },
        {
            "id": null,
            "type": "recipe",
            "attributes": {
                "title": "Sriracha",
                "url": "http://www.jamieoliver.com/recipes/vegetables-recipes/sriracha/",
                "country": "thailand",
                "image": "https://edamam-product-images.s3.amazonaws.com/."
            }
        },
        {...},
        {...},
        {...},
        {etc},
    ]
}
```

2. GET http://localhost:3000/api/v1/learning_resources
- takes a parameter of country - any country in the world
- returns learning resources based on the country provided 

Returns the following JSON:

```{
    "data": {
        "id": null,
        "type": "learning_resource",
        "attributes": {
            "country": "laos",
            "video": {
                "title": "A Super Quick History of Laos",
                "youtube_video_id": "uw8hjVqxMXw"
            },
            "images": [
                {
                    "alt_tag": "standing statue and temples landmark during daytime",
                    "url": "https://images.unsplash.com/photo-1528181304800-259b08848526?ixid=MnwzNzg2NzV8MHwxfHNlYXJjaHwxfHx0aGFpbGFuZHxlbnwwfHx8fDE2Njc4Njk1NTA&ixlib=rb-4.0.3"
                },
                {
                    "alt_tag": "five brown wooden boats",
                    "url": "https://images.unsplash.com/photo-1552465011-b4e21bf6e79a?ixid=MnwzNzg2NzV8MHwxfHNlYXJjaHwyfHx0aGFpbGFuZHxlbnwwfHx8fDE2Njc4Njk1NTA&ixlib=rb-4.0.3"
                },
                {
                    "alt_tag": "orange temples during daytime",
                    "url": "https://images.unsplash.com/photo-1563492065599-3520f775eeed?ixid=MnwzNzg2NzV8MHwxfHNlYXJjaHwzfHx0aGFpbGFuZHxlbnwwfHx8fDE2Njc4Njk1NTA&ixlib=rb-4.0.3"
                },
                {...},
                {...},
                {...},
                {etc},
              ]
        }
    }
}
```


3. POST http://localhost:3000/api/v1/users

- requires a user to send json request in the body of the request that looks like this: 
```
{
  "name": "person",
  "email": "person@email.com",
  "password": "password",
  "password_confirmation": "password"
}
```

JSON Response:
```
{
  "data": {
    "type": "user",
    "id": "1",
    "attributes": {
      "name": "person",
      "email": "person@email.com",
      "api_key": "API_KEY"
    }
  }
}
```

4. POST http://localhost:3000/api/v1/sessions
- requires a registered user
- requires a user to send json request in the body of the request that looks like this: 
```
{
  "email": "person@email.com.com",
  "password": "password"
}
```

JSON response for successful log in:
```
{
  "data": {
    "type": "user",
    "id": "1",
    "attributes": {
      "name": "person",
      "email": "person@email.com.com",
      "api_key": "API_KEY"
    }
  }
}
```

5. POST http://localhost:3000/api/v1/favorites

  - add a user favorite item to the user's favorites
  - requires a user to send json request in the body of the request that looks like this: 
  ```
  {
    "api_key": "jgn983hy48thw9begh98h4539h4",
    "country": "thailand",
    "recipe_link": "https://www.tastingtable.com/.....",
    "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
}
  ```

  successful JSON response:
  ```
  {
    "success": "Favorite added successfully"
}
```

6. GET http://localhost:3000/api/v1/favorites
- gets all of a user's saved favorites
- requires a parameter of the users API key

successful JSON response: 
```
{
    "data": [
        {
            "id": "1",
            "type": "favorite",
            "attributes": {
                "recipe_title": "Recipe: Egyptian Tomato Soup",
                "recipe_link": "http://www.thekitchn.com/recipe-egyptian-tomato-soup-weeknight....",
                "country": "egypt",
                "created_at": "2022-11-02T02:17:54.111Z"
            }
        },
        {
            "id": "2",
            "type": "favorite",
            "attributes": {
                "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)",
                "recipe_link": "https://www.tastingtable.com/.....",
                "country": "thailand",
                "created_at": "2022-11-07T03:44:08.917Z"
            }
        }
    ]
 }    
```
