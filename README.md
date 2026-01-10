# Sql in C#

> ATTENZIONE!
> Andare a sostituire il contenuto all'interno delle parentesi angolari (<>) con le variabili desiderate.
> Quelli inseriti sono solo placeholder.

## Istruzioni pre-uso
Installare il pacchetto **Microsoft.Data.SqlClient** all'interno di visual studio.

## C# 

### Stringa di connessione

Creare una variabile (per una connessione sul posto, in progetti grandi bisogna metterla in un punto globale)
che ci permetta di sapere in quale database bisogna connettersi;
```C#
const string connectionString = "Data Source=<POSIZIONE_DEL_SERVER_SQL>;Initial Catalog=<NOME_DEL_DATABASE>;";
```
In questo case, visto che utilizziamo il server locale del computer:

`POSIZIONE_DEL_SERVER_SQL = (localdb)\\mssqllocaldb`

E per il nome del database:

`NOME_DEL_DATABASE = testDatabase`

### Connessione al database

Creata la nostra stringa di connessione possiamo stabilire la connessione con il database:

> La nomenclatura `using`  viene usata per stabilire per quanto tempo la connessione, o il comando o qualsiasi 
> altra Sql-Interaction viene mantenuta attiva. Nel momento in cui si arriva alla fine dell'using (alla 
> parentesi graffa di chiusura) o si dovesse ritornare (tipo se si è all'interno di una funzione) la 
> connessione verrebbe chiusa automaticamente.

```C#
using (SqlConnection connection = new SqlConnection(connectionString)){

}
```

Con questa operazione viene stabilita la connessione, ma non viene ancora aperta. Per aprirla basta

```C#
connection.Open();
```

subito sotto lo using.

### Operazioni

Stabilita la nostra connessione possiamo fare diverse operazioni all'interno, esempio [inserimento di dati](###inserimento), aggiornamento dei dati, eliminazione e visualizzazione di essi.

#### Inserimento

Ci sono diversi modi per inserire dei dati all'interno di un database, in ogni case è consigliato un inserimento con variabili Sql (@<NOME_VARIABILE>) per evitare atticchi hacker.

> ESEMPIO DI COSA NON FARE
>
> ```C#
> SqlCommand insert = new SqlCommand(){
>     CommandText = $"INSERT INTO <DATABASE_NAME> (<CAMPO_DA_INSERIRE>) VALUES ({<VARIABILE>});",  
> 
>     CommandType = CommandType.Text,
>     Connection = connection
> }
> insert.ExecuteNonQuery();
> ```

Come creare la stringa di inserimento:
```C#
SqlCommand insert = new SqlCommand(){
    CommandText = "INSERT INTO <DATABASE_NAME> (<NOME_CAMPO>) VALUES (@<CAMPO_DA_INSERIRE>);",  

    CommandType = CommandType.Text,
    Connection = connection
}
```

Esempio:
```C#
SqlCommand insertMario = new SqlCommand()
{
    CommandText = $"INSERT INTO dbo.[User] (FirstName, LastName, UserName, [Password]) VALUES (@FirstName, @LastName, @UserName, @Password);",

    CommandType = CommandType.Text,
    Connection = connection
};
```

VARIABILI USATE NEGLI ESEMPI
```C#
string firstName = "Mario";
string lastName = "Rossi";
string userName = "mario.rossi";
string password = "mariorossibest";
```

##### 1° metodo
```C#
insert.Parameters.AddWithValue("<CAMPO_DA_INSERIRE>", <VARIABILE>);
```

esempio:

```C#
insertMario.Parameters.AddWithValue("FirstName", firstName);
```

##### 2° metodo
```C#
insert.Parameters.Add(new SqlParameter() { ParameterName = "<CAMPO_DA_INSERIRE>", Value = <VARIABILE>, SqlDbType = SqlDbType.<TIPO>});
```

esempio:

```C#
insertMario.Parameters.Add(new SqlParameter() { ParameterName = "LastName", Value = lastName, SqlDbType = SqlDbType.VarChar});
```

##### 3° metodo
```C#
insertMario.Parameters.Add("<CAMPO_DA_INSERIRE>", SqlDbType.<TIPO>).Value = <VARIABILE>;
```

esempio:

```C#
insertMario.Parameters.Add("UserName", SqlDbType.VarChar).Value = userName;
```

##### 4° metodo
```C#
SqlParameter <NOME_PARAMETRO> = insertMario.Parameters.Add("<CAMPO_DA_INSERIRE>", SqlDbType.<TIPO>);
<NOME_PARAMETRO>.Value = <VARIABILE>;
```

esempio:

```C#
SqlParameter passwordParam = insertMario.Parameters.Add("Password", SqlDbType.VarChar);
passwordParam.Value = password;
```



Creato il comando e dopo averci aggiunto le variabili desiderate basterà eseguire un comando:

```C#
insert.ExecuteNonQuery();
```

Questo comando esegue la query e ritorna un intero con le righe toccatte dalla query.

esempio:

```C#
int affectedRows = insertMario.ExecuteNonQuery();

Console.WriteLine(affectedRows);
```



