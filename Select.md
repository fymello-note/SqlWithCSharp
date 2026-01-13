# Select

Ci sono delle considerazioni da fare nella select:
1. I dati possono essere letti una sola volta per comando, li puoi scorrere in avanti ma non indietro e non si può
   resettare la posizione all'inizio.

2. Si possono usare il while e il do-while per scorrere la tabella ritornata, bisogna decidere quale usare in base al 
   singolo caso.

3. Personalmente non consiglio l'uso del "*" per prendersi tutti i campi, sarebbe meglio specificare i campi desiderati
   (In questo caso lo userò a scopo dimostrativo)


Per creare il comando:
```C#
using (SqlCommand command = connection.CreateCommand())
{
    command.CommandText = "SELECT * FROM <TABLE_NAME>";
    command.CommandType = CommandType.Text;
    
    using (SqlDataReader reader = command.ExecuteReader()) {
    /*
        QUA DENTRO:
        all'interno di queste parentesi graffe andrà messo il nostro ciclo 
    */
    }
}
```

esempio:

```C#
using (SqlCommand command = connection.CreateCommand())
{
    command.CommandText = "SELECT * FROM dbo.[user]";
    command.CommandType = CommandType.Text;

    using (SqlDataReader reader = command.ExecuteReader()) {
    // anche qui!
    }
}
```

per ciclare sul risultato reader si usa la funzione `reader.Read();` e per prendere i valori ci sono due modi:

1. > ```C#
   > var <VARIABILE> = reader.Get<TIPO>(<POSIZIONE_NUMERICA_COLONNA_ALL_INTERNO_SELECT>);
   > ```

2. > ```C#
   > var <VARIABILE> = reader.Get<TIPO>(reader.GetOrdinal("<NOME_COLONNA>"));
   > ```

E' consigliato usare solo la seconda. (usate solo la seconda)


## While
```C#
while (reader.Read())
{
    var <VARIABILE> = reader.Get<TIPO>(reader.GetOrdinal("<NOME_COLONNA>"));
}
```

esempio:

```C#
while (reader.Read())
{
    //int userId = reader.GetInt32(0);
    int userId = reader.GetInt32(reader.GetOrdinal("UserId"));
    string firstName = reader.GetString(reader.GetOrdinal("FirstName"));
    string lastName = reader.GetString(reader.GetOrdinal("LastName"));
    string userName = reader.GetString(reader.GetOrdinal("UserName"));
    string password = reader.GetString(reader.GetOrdinal("Password"));
    DateTime creationDate = reader.GetDateTime(reader.GetOrdinal("CreationDate"));

    Console.WriteLine("Nome: {0} {1}, UserName: {2}, Password: {3}, Creation Date: {4:dd/MM/yyyy HH:mm:ss}", 
        firstName, lastName, password, userName, creationDate); // Si può aggiungere .fff per i millisecondi
}
```

## Do-While
```C#
if (reader.Read())
{
    int <POSIZIONE_COLONNA> = reader.GetOrdinal(<NOME_COLONNA>);

    do
    {
        var <VARIABILE> = reader.Get<TIPO>(<POSIZIONE_COLONNA>);

    }while (reader.Read());
}
```

Esempio:

```C#
if (reader.Read())
{
    int userIdPos = reader.GetOrdinal("UserId");
    int firstNamePos = reader.GetOrdinal("FirstName");
    int lastNamePos = reader.GetOrdinal("LastName");
    int userNamePos = reader.GetOrdinal("UserName");
    int passwordPos = reader.GetOrdinal("Password");
    int creationDatePos = reader.GetOrdinal("CreationDate");
    int lastModPos = reader.GetOrdinal("LastModificationDate");

    do
    {
        int userId = reader.GetInt32(userIdPos);
        string firstName = reader.GetString(firstNamePos);
        string lastName = reader.GetString(lastNamePos);
        string userName = reader.GetString(userNamePos);
        string password = reader.GetString(passwordPos);
        DateTime creationDate = reader.GetDateTime(creationDatePos);
        DateTime? lastModDate = !reader.IsDBNull(lastModPos) ? reader.GetDateTime(lastModPos) : null;

        // Sostituito dall'operazione ternaria
        // if (!reader.IsDBNull(lastModPos))
        // {
        //     lastModDate = reader.GetDateTime(lastModPos);
        // }


        Console.WriteLine("Nome: {0} {1}, UserName: {2}, Password: {3}, Creation Date: {4:dd/MM/yyyy HH:mm:ss}, LastModDate: {5:dd/MM/yyyy HH:mm:ss}",
            firstName, lastName, userName, password, creationDate, lastModDate);

    }while (reader.Read());
}
```
