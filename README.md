# README

## API Endpoints

### **Static pages**

1. **Render frontend root container here**

- GET / static_pages#root

### **Auth Routes**

1. **Log user in to a session**

- POST /api/session(.:format) api/sessions#create {:format=>:json}

*Request body:*

```json
{
  "user": {
      "username": "adinylol3",
      "password": "password"
  }
}
```

*Response body:*

```json
{
  "id":1,"username":"adinylol3"
}
```

2. **Delete user from a session**

- DELETE /api/session(.:format) api/sessions#destroy {:format=>:json}

### **Users Routes**

1. **View all users**

- GET /api/users(.:format) api/users#index {:format=>:json}

*respose body:*

```json
{
  "2":{"id":2,"username":"adinylol4"},
  "1":{"id":1,"username":"adinylol3"}
}
```

2. **Create new user**

- POST /api/users(.:format) api/users#create {:format=>:json}

*Request body:*

```json
{
  "user": {
      "username": "adinylol3",
      "password": "password"
  }
}
```

*Response body:*

```json
{"id":1,"username":"adinylol3"}
```

3. **Users search**

- GET /api/users/search/:query(.:format) api/users#search {:format=>:json}

- Ex. uri*/api/users/search/adinylol*

*Response body:*

```json
{
  "2": {"id":2,"username":"adinylol4"},
  "1": {"id":1,"username":"adinylol3}
}
```

### **Group Routes**

1. **Create group w/ group_name, user_ids, and buy_in**

- POST
- /api/groups(.:format) 
- api/groups#create {:format=>:json}

*Request body:*

```json
{
  "group": {
    "group_name": "alpha",
    "user_ids": [1, 2],
    "buy_in": 5
  }
}
```

*Response body:*

```json
{
  "id":1,
  "group_name":"alpha","buy_in":5
}
```

### **Challenge Routes**

1. **Create challenge w/ name, description, verified, expiration, user_id, group_id**

- POST
- /api/challenges(.:format)
- api/challenges#create {:format=>:json}

*Request body:*

```json
{
  "name": "speed jumproping",
  "description": "practice jumping roping 3 times a day for ~10 min every other day in the week",
  "verified": "false",
  "expiration": "2018-05-13T23:22:46-07:00",
  "user_id": "1",
  "group_id": "13"
}
```

*Response body:*

```json
{
  "id":3,
  "name":"speed jumproping",
  "description":"practice jumping roping 3 times a day for ~10 min every other day in the week",
  "verified":false,
  "expiration":"2018-05-14T06:22:46.000Z"
}
```
