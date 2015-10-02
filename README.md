=======
# BucketList Api

This is a Rails API for a bucket list service.(http://kickmylist.herokuapp.com/api/v1)

*Note that all responses are in json format*

**Authentication**

Most BucketList endpoints require access token

To obtain an authentication token:
* First you need to sign up
<table>
  <th>
    <tr>
      <td>
       Verb
      </td>
      <td>
      Route
      </td>
      <td>
      Params
      </td>
   </tr>
  </th>

  <tbody>
    <tr>
      <td>
      POST
      </td>
      <td>
      http://kickmylist.herokuapp.com/api/v1/users
      </td>
      <td>
      { name: "John", email: "john@example.com", password: "123456"}
      </td>
    </tr>
  </tbody>
</table>

Response
```
{
    "message": "You have successfully signed up daisi"
}
```
* Then you log in 
<table>
   <th>
      <tr>
        <td>
         Verb
        </td>
        <td>
        Route
        </td>
        <td>
        Params
        </td>
      </tr>
   </th>

  <tbody>
    <tr>
      <td>
      POST
      </td>
      <td>
      http://kickmylist.herokuapp.com/api/v1/auth/login
      </td>
      <td>
      { email: "john@example.com", password: "123456"}
      </td>
    </tr>
  </tbody>
</table>

Response
```
{
    "token": "1bf7352a2e38b447e61444d7fdd5e365",
    "message": "You have successfully logged in"
}
```
**Unprotected routes**

Only two routes are unprotected, meaning no authentication token is required to visit them

They are the *Login 'POST /auth/login'* and *View all Bucket lists 'GET /bucketlists/'*

**Visiting protected routes**

To visit protected routes, include the authentication token returned after login in the header

Like this
```
  Header: Authorization 
  Value: Token token=1bf7352a2e38b447e61444d7fdd5e365
```

**BucketLists**

*To create a bucket list*
<table>
   <th>
      <tr>
        <td>
         Verb
        </td>
        <td>
        Route
        </td>
        <td>
        Params
        </td>
      </tr>
   </th>

  <tbody>
    <tr>
      <td>
      POST
      </td>
      <td>
      http://kickmylist.herokuapp.com/api/v1/bucketlists
      </td>
      <td>
      { name: "Tour of Europe" }
      </td>
    </tr>
  </tbody>
</table>

Response
```
{
    "bucketlist": {
        "id": 1,
        "name": "Tour of Europe",
        "items": [],
        "date_created": "2015-10-02 10:26:41 UTC",
        "date_modified": "2015-10-02 10:26:41 UTC",
        "created_by": "john"
    }
}
```

*To view bucket lists*
<table>
   <th>
      <tr>
        <td>
         Verb
        </td>
        <td>
        Route
        </td>
      </tr>
   </th>

  <tbody>
    <tr>
      <td>
      GET
      </td>
      <td>
      http://kickmylist.herokuapp.com/api/v1/bucketlists
      </td>
    </tr>
  </tbody>
</table>

Response
```
{
    "bucketlists": [
        {
            "id": 1,
            "name": "Tour of Europe"
        }
    ]
}
```

*Updating a bucket list*
<table>
   <th>
      <tr>
        <td>
         Verb
        </td>
        <td>
        Route
        </td>
        <td>
        Params
        </td>
      </tr>
   </th>

  <tbody>
    <tr>
      <td>
      PUT
      </td>
      <td>
      http://kickmylist.herokuapp.com/api/v1/bucketlists/:id
      </td>
      <td>
      { name: "Tour of Europe with Friends" }
      </td>
    </tr>
  </tbody>
</table>

Response
```
{
    "message": "bucketlist updated!",
    "bucketlist": {
        "id": 1,
        "name": "Tour of Europe with friends",
        "created_at": "2015-10-02T10:26:41.586Z",
        "updated_at": "2015-10-02T10:34:03.398Z",
        "user_id": 1
    }
}
```

*Deleting a bucket list*
<table>
   <th>
      <tr>
        <td>
         Verb
        </td>
        <td>
        Route
        </td>
      </tr>
   </th>

  <tbody>
    <tr>
      <td>
      DELETE
      </td>
      <td>
      http://kickmylist.herokuapp.com/api/v1/bucketlists/:id
      </td>
    </tr>
  </tbody>
</table>

Response
```
{
    "message": "bucketlist deleted"
}
```

**Bucket list Items**

*Add items to a bucket list*
<table>
   <th>
      <tr>
        <td>
         Verb
        </td>
        <td>
        Route
        </td>
        <td>
        Params
        </td>
      </tr>
   </th>

  <tbody>
    <tr>
      <td>
      POST
      </td>
      <td>
      http://kickmylist.herokuapp.com/api/v1/bucketlists/:bucketlist_id/items
      </td>
      <td>
      { name: "{ name: "Visit Paris" }
      </td>
    </tr>
  </tbody>
</table>

Response
```
{
    "message": "item added successfully",
    "item": {
        "id": 1,
        "name": "Visit Paris",
        "done": false,
        "created_at": "2015-10-02T10:44:59.431Z",
        "updated_at": "2015-10-02T10:44:59.431Z",
        "bucketlist_id": 1
    }
}
```
*View a bucket list items*
<table>
   <th>
      <tr>
        <td>
         Verb
        </td>
        <td>
        Route
        </td>
      </tr>
   </th>

  <tbody>
    <tr>
      <td>
      GET
      </td>
      <td>
      http://kickmylist.herokuapp.com/api/v1/bucketlists/:bucketlist_id/items
      </td>
    </tr>
  </tbody>
</table>

Response
```
{
    "items": [
        {
            "id": 1,
            "name": "Visit Paris",
            "done": false,
            "date_created": "2015-10-02 10:44:59 UTC",
            "date_modified": "2015-10-02 10:44:59 UTC"
        }
    ]
}
```

*Update a bucket list item*
<table>
   <th>
      <tr>
        <td>
         Verb
        </td>
        <td>
        Route
        </td>
        <td>
        Params
        </td>
      </tr>
   </th>

  <tbody>
    <tr>
      <td>
      PUT
      </td>
      <td>
      http://kickmylist.herokuapp.com/api/v1/bucketlists/:bucketlist_id/items
      </td>
      <td>
      { done: true }
      </td>
    </tr>
  </tbody>
</table>

Response
```
{
    "message": "updated successfully",
    "item": {
        "id": 1,
        "name": "Visit Paris",
        "done": true,
        "created_at": "2015-10-02T10:44:59.431Z",
        "updated_at": "2015-10-02T10:48:59.329Z",
        "bucketlist_id": 1
    }
}
```

*Delete a bucket list item*
<table>
   <th>
      <tr>
        <td>
         Verb
        </td>
        <td>
        Route
        </td>
      </tr>
   </th>

  <tbody>
    <tr>
      <td>
      DELETE
      </td>
      <td>
      http://kickmylist.herokuapp.com/api/v1/bucketlists/:bucketlist_id/items
      </td>
    </tr>
  </tbody>
</table>

Response
```
{
    "message": "item deleted successfully"
}
```

**Log out**

Every authentication token expires on log out, therefore after log out the old token will not be valid

*To Log out*
<table>
   <th>
      <tr>
        <td>
         Verb
        </td>
        <td>
         Route
        </td>
      </tr>
   </th>

  <tbody>
    <tr>
      <td>
       GET
      </td>
      <td>
       http://kickmylist.herokuapp.com/api/v1/auth/logout
      </td>
    </tr>
  </tbody>
</table>

Response
```
{
    "message": "You have logged out successfully"
}
```