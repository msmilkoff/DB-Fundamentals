namespace _04.AddMinion
{
    using System;
    using System.Data.SqlClient;

    public class Startup
    {
        public static void Main()
        {
            string connectionString = "Server=(local);Database=MinionsDB;Integrated Security=true;";
            var connection = new SqlConnection(connectionString);

            string[] minionInfo = Console.ReadLine().Trim().Split(new[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);
            string minionName = minionInfo[1];
            int minionAge = int.Parse(minionInfo[2]);
            string townName = minionInfo[3];

            string[] villainInfo = Console.ReadLine().Trim().Split(new[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);
            string villainName = villainInfo[1];
            using (connection)
            {
                connection.Open();

                if (!TownExists(townName, connection))
                {
                    InsertTown(townName, connection);
                    Console.WriteLine($"Town {townName} was added to the database.");
                }

                if (!VillainExists(villainName, connection))
                {
                    InsertVillain(villainName, connection);
                    Console.WriteLine($"Villain {villainName} was added to the database.");
                }

                InsertMinion(minionName, minionAge, townName, connection);
                Console.WriteLine($"Successfully added {minionName} to be minion of {villainName}."); 
            }
        }

        private static bool VillainExists(string villainName, SqlConnection connection)
        {
            var checkVillainCmd = new SqlCommand($@"SELECT COUNT(*) FROM Villains WHERE [Name] = '{villainName}'", connection);
            int villainCount = (int)checkVillainCmd.ExecuteScalar();

            return villainCount > 0;
        }

        private static void InsertVillain(string name, SqlConnection connection)
        {
            const string DefaultEvilnessFactor = "evil";

            string addVillainQuery = $@"INSERT INTO Villains ([Name], EvilnessFactor) VALUES ('{name}', '{DefaultEvilnessFactor}')";
            var insertCommand = new SqlCommand(addVillainQuery, connection);

            insertCommand.ExecuteNonQuery();

        }

        private static void InsertMinion(string minionName, int minionAge, string townName, SqlConnection connection)
        {
            string getTownIdText = $@"SELECT Id FROM Towns WHERE [Name] = '{townName}'";
            var cmd = new SqlCommand(getTownIdText, connection);
            var reader = cmd.ExecuteReader();
            int townId = 0;
            if (reader.Read())
            {
                townId = reader.GetInt32(0);
                reader.Close();
            }

            string insertMinionText =
                $@"INSERT INTO Minions ([Name], Age, TownId)
                   VALUES ('{minionName}', {minionAge}, '{townId}')";

            var insertMinonCmd = new SqlCommand(insertMinionText, connection);
            insertMinonCmd.ExecuteNonQuery();
        }

        private static bool TownExists(string name, SqlConnection connection)
        {

            var checkTownCmd = new SqlCommand($@"SELECT COUNT(*) FROM Towns WHERE [Name] = '{name}'", connection);
            int townCount = (int)checkTownCmd.ExecuteScalar();

            return townCount > 0;
        }

        private static void InsertTown(string name, SqlConnection connection)
        {
            string addTownQuery = $@"INSERT INTO Towns ([Name])
                                     VALUES ('{name}')";
            var insertCommand = new SqlCommand(addTownQuery, connection);

            insertCommand.ExecuteNonQuery();

        }
    }
}
