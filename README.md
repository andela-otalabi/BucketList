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
Then you log in 
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