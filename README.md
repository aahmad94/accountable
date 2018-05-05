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
