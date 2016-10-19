namespace _03.GetMinionNames
{
    using System;
    using System.Data.SqlClient;

    public class Startup
    {
        public static void Main()
        { 
            var connectionBulder = new SqlConnectionStringBuilder();
            connectionBulder["Data Source"] = "(local)";
            connectionBulder["initial catalog"] = "MinionsDB";
            connectionBulder["Integrated Security"] = true;
            var connection = new SqlConnection(connectionBulder.ToString());

            int villainId = int.Parse(Console.ReadLine());

            string getMinionsQuery =
                $@"SELECT DISTINCT v.Name, m.Name, m.Age
                   FROM Villains AS v
                   JOIN MinionsVillains AS mv
                     ON v.Id = mv.VillainId
                   JOIN Minions AS m
                     ON mv.MinionId = m.Id
                  WHERE v.Id = {villainId}";

            var cmd = new SqlCommand(getMinionsQuery, connection);
            using (connection)
            {
                try
                {
                    connection.Open();
                    var reader = cmd.ExecuteReader();
                    string villainName = "";
                    if (string.IsNullOrWhiteSpace(villainName))
                    {
                        Console.WriteLine($"No villain with ID {villainId} exists in the database.");
                        return;
                    }

                    if (reader.Read())
                    {
                        villainName = reader.GetString(0);
                        Console.WriteLine($"Villain: {villainName}");
                    }

                    int minionsCount = 1;
                    while (reader.Read())
                    {
                        string minionName = reader.GetString(1);
                        int minionAge = reader.GetInt32(2);
                        Console.WriteLine($"{minionsCount}. {minionName} {minionAge}");

                        minionsCount++;
                    }
                }
                catch (Exception)
                {
                    Console.WriteLine($"No villain with ID {villainId} exists in the database.");
                }
                finally
                {
                    connection.Close();
                }
            }
        }
    }
}
