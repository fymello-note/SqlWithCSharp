# Inserimento

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
    CommandText = "INSERT INTO dbo.[User] (FirstName, LastName, UserName, [Password]) VALUES (@FirstName, @LastName, @UserName, @Password);",

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

## 1° metodo
```C#
insert.Parameters.AddWithValue("<CAMPO_DA_INSERIRE>", <VARIABILE>);
```

esempio:

```C#
insertMario.Parameters.AddWithValue("FirstName", firstName);
```

## 2° metodo
```C#
insert.Parameters.Add(new SqlParameter() { ParameterName = "<CAMPO_DA_INSERIRE>", Value = <VARIABILE>, SqlDbType = SqlDbType.<TIPO>});
```

esempio:

```C#
insertMario.Parameters.Add(new SqlParameter() { ParameterName = "LastName", Value = lastName, SqlDbType = SqlDbType.VarChar});
```

## 3° metodo
```C#
insertMario.Parameters.Add("<CAMPO_DA_INSERIRE>", SqlDbType.<TIPO>).Value = <VARIABILE>;
```

esempio:

```C#
insertMario.Parameters.Add("UserName", SqlDbType.VarChar).Value = userName;
```

## 4° metodo
```C#
SqlParameter <NOME_PARAMETRO> = insertMario.Parameters.Add("<CAMPO_DA_INSERIRE>", SqlDbType.<TIPO>);
<NOME_PARAMETRO>.Value = <VARIABILE>;
```

esempio:

```C#
SqlParameter passwordParam = insertMario.Parameters.Add("Password", SqlDbType.VarChar);
passwordParam.Value = password;
```
