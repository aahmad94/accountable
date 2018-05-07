# Accountable

Stay healthy, make bets with your friends, for money and for glory. 

Rails back-end provides endpoints to:

1. Creating an account
2. Log in/out session
3. Create a group
4. Invite people to a group with a set buy-in value
5. Create a weekly challenge
6. Verify group members' challenge
7. Make payments via demo credit card for each user via Softheon payments API

## Database associations

```ruby
# ---------- User ----------
has_many :group_subscriptions,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: :GroupSubscription

has_many :groups,
  through: :group_subscriptions

has_many :challenges,
  through: :group_subscriptions

# ---------- Group ----------
has_many :group_subscriptions,
  primary_key: :id,
  foreign_key: :group_id,
  class_name: :GroupSubscription

has_many :users,
  through: :group_subscriptions

has_many :challenges,
  through: :group_subscriptions

# ---------- GroupSubscription ----------
belongs_to :user,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: :User

belongs_to :group,
  primary_key: :id,
  foreign_key: :group_id,
  class_name: :Group

has_many :challenges,
  primary_key: :id,
  foreign_key: :group_subscription_id,
  class_name: :Challenge

# ---------- Challenge ----------
belongs_to :group_subscription,
  primary_key: :id,
  foreign_key: :group_subscription_id,
  class_name: :GroupSubscription 

has_one :user,
  through: :group_subscription

has_one :group,
  through: :group_subscription
```

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

4. **User's groups**

- GET
- /api/users/:id/groups/
- api/users#groups

- Ex. localhost:3000/api/users/groups/1*

*Response body:*

```json
[
  {
      "id": 1,
      "group_name": "alpha",
      "created_at": "2018-05-06T04:59:59.740Z",
      "updated_at": "2018-05-06T04:59:59.740Z",
      "buy_in": 5
  },
  {
      "id": 3,
      "group_name": "beta",
      "created_at": "2018-05-06T06:16:04.733Z",
      "updated_at": "2018-05-06T06:16:04.733Z",
      "buy_in": 5
  }
]
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

2. **Get all challenges in group w/ corresponding user information**

- GET
- /api/group/:id/challenges
- api/groups#challenges

Ex. request: localhost:3000/api/groups/13/challenges

*Response body:*

```json
[
  {
    "user":
      {
        "id": 1,
        "username":"adinylol1"
      },
    "challenge":
      {
        "id": 3,
        "group_subscription_id": 15,
        "description": "practice jumping roping 3 times a day for ~10 min every other day in the week",
        "verified": false,
        "created_at": "2018-05-06T07:37:11.971Z",
        "updated_at": "2018-05-06T07:37:11.971Z",
        "name":"speed jumproping",
        "expiration":"2018-05-14T06:22:46.000Z"
      }
  },
  {
    "user":
      {
        "id": 2,
        "username":"adinylol2"
      },
    "challenge":
      {
        "id":4,"group_subscription_id":16,"description":"shoot 50 baskets everyday this week",
        "verified":false,
        "created_at":"2018-05-06T16:07:36.691Z",
        "updated_at":"2018-05-06T16:07:36.691Z",
        "name":"play basketball",
        "expiration":"2018-05-14T06:22:46.000Z"
      }
  }
]
```

3. **Make group members pay if unverified challenge**

- GET
- /api/:id/pay (.:format) 
- api/groups#create {:format=>:json}

Ex. request: localhost:3000/api/groups/1/pay

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

2. **Verify a challenge**

- PATCH
- /api/challenges/:id
- api/challenges#update 

Ex. request: localhost:3000/api/challenges/4

*Response body:*

```json
{
  "id": 4,
  "name": "play basketball",
  "description": "shoot 50 baskets everyday this week",
  "verified": false,
  "expiration": "2018-05-14T06:22:46.000Z"
}
```
