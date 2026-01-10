# Delete
In questa parte si vede come si eliminano dei dati attraverso la delete.

```C#
SqlCommand command = connection.CreateCommand();
command.CommandText = "DELETE FROM <TABLE_NAME> Where <IDENTIFICATORE> = @<I_VARIABILE_SQL>";
command.CommandType = CommandType.Text;

command.Parameters.AddWithValue("<I_VARIABILE_SQL>", <I_VARIABILE>);
```

esempio:

```C#
SqlCommand deleteMario = connection.CreateCommand();
deleteMario.CommandText = "DELETE FROM [User] Where UserId = @UserId";
deleteMario.CommandType = CommandType.Text;

deleteMario.Parameters.AddWithValue("UserId", 4);
```
