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

Stabilita la nostra connessione possiamo fare diverse operazioni all'interno, esempio [inserimento di dati](Insert.md), aggiornamento dei dati, eliminazione e visualizzazione di essi.


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







