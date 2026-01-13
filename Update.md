# Update
In questa parte si vede come si modificano i dati attraverso la Update.

```C#
SqlCommand connection = connection.CreateCommand();
connection.CommandText = "UPDATE <TABLE_NAME> SET <NOME_CAMPO> = @<VARIABILE_SQL> Where <IDENTIFICATORE> = @<I_VARIABILE_SQL>";
connection.CommandType = CommandType.Text;

connection.Parameters.AddWithValue("<VARIABILE_SQL>", <VARIABILE>);
connection.Parameters.AddWithValue("<I_VARIABILE_SQL>", <I_VARIABILE>);
```

esempio:

```C#
SqlCommand updateMario = connection.CreateCommand();
updateMario.CommandText = "UPDATE [User] SET FirstName = @FirstName Where UserId = @UserId";
updateMario.CommandType = CommandType.Text;

updateMario.Parameters.AddWithValue("FirstName", "Mario Mod.");
updateMario.Parameters.AddWithValue("UserId", 1);
```
