namespace _01.InitialSetup
{
    using System.Data.SqlClient;

    public class Startup
    {
        static void Main(string[] args)
        {
            var connectionBulder = new SqlConnectionStringBuilder();
            connectionBulder["Data Source"] = "(local)";
            connectionBulder["Integrated Security"] = true;
            var connection = new SqlConnection(connectionBulder.ToString());

            using (connection)
            {
                var command = new SqlCommand("CREATE DATABASE MinionsDB");
                command.Connection = connection;
                connection.Open();
                command.ExecuteNonQuery();
            }

            connectionBulder["initial catalog"] = "MinionsDB";
            connection = new SqlConnection(connectionBulder.ToString());
            using (connection)
            {
                connection.Open();
                string createTownsQuery =
                    @"CREATE TABLE Towns 
                    (
                     Id INT PRIMARY KEY IDENTITY,
                     Name VARCHAR(50),
                     Country VARCHAR(50)
                     )";
                string createMinionsQuery = 
                    @"CREATE TABLE Minions 
                    (
                    Id INT PRIMARY KEY IDENTITY
                    , Name VARCHAR(50)
                    , Age INT,
                    TownId INT,
                    CONSTRAINT FK_Towns FOREIGN KEY (TownId)
                    REFERENCES Towns(Id)
                    )";
                string createVillainsQuery = 
                    @"CREATE TABLE Villains (
                    Id INT PRIMARY KEY IDENTITY,
                    Name VARCHAR(50),
                    EvilnessFactor VARCHAR(20)
                    )";
                string createMinionsVillainsQuery = 
                    @"CREATE TABLE MinionsVillains(
                    MinionId INT,
                    VillainId INT,
                    CONSTRAINT FK_Minions FOREIGN KEY (MinionId)
                    REFERENCES Minions(Id),
                    CONSTRAINT  FK_Villains FOREIGN KEY (VillainId) 
                    REFERENCES Villains(Id))";
                ExecuteCommand(createTownsQuery, connection);
                ExecuteCommand(createMinionsQuery, connection);
                ExecuteCommand(createVillainsQuery, connection);
                ExecuteCommand(createMinionsVillainsQuery, connection);

                string insertTownsSQL = 
                    @"INSERT INTO Towns (Name, Country) VALUES ('Sofia','Bulgaria'), ('Burgas','Bulgaria'), ('Varna', 'Bulgaria'), ('London','UK'),('Liverpool','UK'),('Ocean City','USA'),('Paris','France')";
                string insertMinionsSQL = 
                    @"INSERT INTO Minions (Name, Age, TownId) VALUES ('bob',10,1),('kevin',12,2),('steward',9,3), ('rob',22,3), ('michael',5,2),('pep',3,2)";
                string insertVillainsSQL = 
                    @"INSERT INTO Villains (Name, EvilnessFactor) VALUES ('Gru','super evil'),('Victor','evil'),('Simon Cat','good'),('Pusheen','super good'),('Mammal','evil')";
                string insertMinionsVillainsSQL = 
                    @"INSERT INTO MinionsVillains VALUES (1,2), (3,1),(1,3),(3,3),(4,1),(2,2),(1,1),(3,4), (1, 4), (1,5), (5, 1), (4,1), (3, 1)";

                ExecuteCommand(insertTownsSQL, connection);
                ExecuteCommand(insertMinionsSQL, connection);
                ExecuteCommand(insertVillainsSQL, connection);
                ExecuteCommand(insertMinionsVillainsSQL, connection);
            }
        }
            

        public static void ExecuteCommand(string commandText, SqlConnection connection)
        {
            SqlCommand cmd = new SqlCommand(commandText, connection);
            cmd.ExecuteNonQuery();
        }
    }
}