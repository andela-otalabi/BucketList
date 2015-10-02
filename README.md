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