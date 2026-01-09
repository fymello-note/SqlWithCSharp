using Microsoft.Data.SqlClient;
using System.Data;

const string connectionString = "Data Source=(localdb)\\mssqllocaldb;Initial Catalog=testDatabase;";

// Non apre la conessione al db
using (SqlConnection connection = new SqlConnection(connectionString)) {
    // Questo apre la connessione
    connection.Open();

    /* Variable
    string firstName = "mario";
    string lastName = "Rossi";
    string userName = "mario.rossi4";
    string password = "mariorossibest";
    */

    /* // Insert 
    // Qua sotto ci sono tutti i modi in cui si può inserire all'interno di un database
    SqlCommand insertMario = new SqlCommand()
    {
        // Le query scritte così sono periocolose
        //CommandText = $"INSERT INTO dbo.[User] (FirstName, LastName, UserName, [Password]) " +
        //$"VALUES ('{firstName}', '{lastName}', '{userName}', '{password}');",
        CommandText = $"INSERT INTO dbo.[User] (FirstName, LastName, UserName, [Password]) VALUES (@FirstName, @LastName, @UserName, @Password);",

        CommandType = CommandType.Text,
        Connection = connection
    };

    insertMario.Parameters.AddWithValue("FirstName", firstName);

    insertMario.Parameters.Add(new SqlParameter() { ParameterName = "LastName", Value = lastName, SqlDbType = SqlDbType.VarChar});

    insertMario.Parameters.Add("UserName", SqlDbType.VarChar).Value = userName;

    SqlParameter passwordParam = insertMario.Parameters.Add("Password", SqlDbType.VarChar);
    passwordParam.Value = password;

    Console.WriteLine(insertMario.CommandText);

    int affectedRows = insertMario.ExecuteNonQuery();

    Console.WriteLine(affectedRows);
    */

    /* // Update command
    SqlCommand updateMario = connection.CreateCommand();
    updateMario.CommandText = "UPDATE [User] SET FirstName = @FirstName Where UserId = @UserId";
    updateMario.CommandType = CommandType.Text;

    updateMario.Parameters.AddWithValue("FirstName", "Mario Mod.");
    updateMario.Parameters.AddWithValue("UserId", 1);

    int rowsAffected = updateMario.ExecuteNonQuery();
    Console.WriteLine($"Rows affected: {rowsAffected}");
    */

    /* // Delete command
    SqlCommand deleteMario = connection.CreateCommand();
    deleteMario.CommandText = "DELETE FROM [User] Where UserId = @UserId";
    deleteMario.CommandType = CommandType.Text;

    deleteMario.Parameters.AddWithValue("UserId", 4);
    int rowsAffected = deleteMario.ExecuteNonQuery();
    Console.WriteLine($"Rows affected: {rowsAffected}");
    */


    /* // Insert with stored Procedure
     SqlCommand command = connection.CreateCommand();
     command.CommandText = "dbo.InsertUser";
     command.CommandType = CommandType.StoredProcedure;

     command.Parameters.AddWithValue("FirstName", firstName);
     command.Parameters.AddWithValue("LastName", lastName);
     command.Parameters.AddWithValue("UserName", "mario.rossi7");
     command.Parameters.AddWithValue("Password", password);

     int rowsInserted = command.ExecuteNonQuery();
     Console.WriteLine($"Rows inserted: {rowsInserted}");
    */

    // Select command
    using (SqlCommand command = connection.CreateCommand())
    {
        command.CommandText = "SELECT * FROM dbo.[user]";
        command.CommandType = CommandType.Text;

        using (SqlDataReader reader = command.ExecuteReader())
        {

            int rows = 0;

            // Leggere con il do while (non molto usato)
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

                    rows++;
                }
                while (reader.Read());
            }


            // Leggere con un while (Preferibile)
            // while (reader.Read())
            // {
            //     //int userId = reader.GetInt32(0);
            //     int userId = reader.GetInt32(reader.GetOrdinal("UserId"));
            //     string firstName = reader.GetString(reader.GetOrdinal("FirstName"));
            //     string lastName = reader.GetString(reader.GetOrdinal("LastName"));
            //     string userName = reader.GetString(reader.GetOrdinal("UserName"));
            //     string password = reader.GetString(reader.GetOrdinal("Password"));
            //     DateTime creationDate = reader.GetDateTime(reader.GetOrdinal("CreationDate"));

            //     Console.WriteLine("Nome: {0} {1}, UserName: {2}, Password: {3}, Creation Date: {4:dd/MM/yyyy HH:mm:ss}", 
            //         firstName, lastName, password, userName, creationDate); // Si può aggiungere .fff per i millisecondi

            //     rows++;
            // }

            Console.WriteLine("N. RIGHE: {0}", rows);
        }
    }

}


