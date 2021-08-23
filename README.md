## Installation

To initialized the project, run this commands :

```bash
bundle install 
rails db:create
rails db:migrate
```

Run seed to create 2 users : user role user and user role admin.
```bash
rails db:seed
```

Import pokemons list from a csv (csv present in public directory).
```bash
rails pokemon:import
```

```bash
rails s
```

## Gems Uses
- devise : authentication solution for Rails
- dotenv-rails : for define var ENV in .env file
- will_paginate : use to paginate collection
- jwt : use to generate OAuth JSON Web Token (JWT) standard
- pundit : use to define users authorization
- rspec-rails : testing framework
- ffaker : generates dummy data
- factory_bot_rails : generate entities for testing

## REST API
API can be test with postman, configuration
file is present in at the root of the project.

## Login 

### Request

`POST localhost:3000/api/v1/login`

```bash
{
    "user": {
        "login": "admin",
        "password": "zrgk8et4#rF"
    }
}
```
Accounts present in /db/seeds.rb.

### Response
```bash
{
    "status": "OK",
    "message": "login success",
    "token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozLCJleHAiOjE2MjI5Nzg4MzV9.yGrSk5eOrqmLAOfpubLc5tlvX49UygxAl2ASWhxBXgg"
}
```

Response return a "token", it's required for other requests. The token validity set to 2 minutes (10 seconds in TEST ENV).


## Get Pokemons Collection 

### Request

`GET localhost:3000/api/v1/pokemon`


### Response
```bash
{
    "results": [
        {
            "id": 1601,
            "name": "Bulbasaur",
            "type_1": "Grass",
            "type_2": "Poison",
            "total": 318,
            "hp": 45,
            "attack": 49,
            "defense": 49,
            "sp_atk": 65,
            "sp_def": 65,
            "speed": 45,
            "generation": 1,
            "legendary": true,
            "created_at": "2021-06-02T21:17:10.803Z",
            "updated_at": "2021-06-02T21:17:10.803Z"
        },
        {
            "id": 1602,
            "name": "Ivysaur",
            "type_1": "Grass",
            "type_2": "Poison",
            "total": 405,
            "hp": 60,
            "attack": 62,
            "defense": 63,
            "sp_atk": 80,
            "sp_def": 80,
            "speed": 60,
            "generation": 1,
            "legendary": true,
            "created_at": "2021-06-02T21:17:10.803Z",
            "updated_at": "2021-06-02T21:17:10.803Z"
        }...
    ]
}
```
Return array of pokemons.

Collection can be filter by attribute "generation" and paginate with attributes "page" and "limit", for example : 

`localhost:3000/api/v1/pokemon?limit=2&page=1&generation=1`

## Show Pokemon 

### Request

`GET localhost:3000/api/v1/pokemon/{{pokemon_id}}`

Param pokemon_id is required. 

### Response
```bash
{
    "results": {
        "id": 1704,
        "name": "lapin",
        "type_1": "Rock",
        "type_2": "Ground",
        "total": 385,
        "hp": 35,
        "attack": 45,
        "defense": 160,
        "sp_atk": 30,
        "sp_def": 45,
        "speed": 70,
        "generation": 1,
        "legendary": true,
        "created_at": "2021-06-02T21:17:10.809Z",
        "updated_at": "2021-06-05T22:27:19.251Z"
    }
}
```
## Create Pokemon 

### Request

You should be login with admin account.

`POST localhost:3000/api/v1/pokemon/`

body :

```bash
{
    "name": "pokemon_name",
    "type_1": null,
    "type_2": null,
    "total": null,
    "hp": null,
    "attack": null,
    "defense": null,
    "sp_atk": null,
    "sp_def": null,
    "speed": null,
    "generation": null,
    "legendary": null
}

```

### Response
```bash
{
    "results": {
        "id": 2436,
        "name": "pokemon_name",
        "type_1": null,
        "type_2": null,
        "total": null,
        "hp": null,
        "attack": null,
        "defense": null,
        "sp_atk": null,
        "sp_def": null,
        "speed": null,
        "generation": null,
        "legendary": null,
        "created_at": "2021-06-06T12:47:51.842Z",
        "updated_at": "2021-06-06T12:47:51.842Z"
    }
}
```
## Update Pokemon 

### Request

You should be login with admin account.

`PUT localhost:3000/api/v1/pokemon/{{pokemon_id}}`

Param pokemon_id is required.

### Response
```bash
{
    "results": "pokemon updated"
}
```

## Destroy Pokemon
 
### Request

You should be login with admin account.

`DELETE localhost:3000/api/v1/pokemon/{{pokemon_id}}`

Param pokemon_id is required.

### Response
```bash
{
    "results": "pokemon deleted"
}
```

## Testing

To testing this app, run this command :
```bash
rspec
```

## Author 
Jérémy Pestelard

