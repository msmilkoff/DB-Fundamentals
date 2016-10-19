namespace _02.GetVillainsNames
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

            string getVillainsQuery =
                @"SELECT v.Name, COUNT(mv.MinionId)
                   FROM Villains AS v
                   JOIN MinionsVillains AS mv
                     ON mv.VillainId = v.Id
                  GROUP BY v.Name, v.Id
                 HAVING COUNT(mv.MinionId) > 3
                  ORDER BY COUNT(mv.MinionId) DESC";

            var cmd = new SqlCommand(getVillainsQuery, connection);
            using (connection)
            {
                connection.Open();

                var reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    Console.WriteLine(reader.GetString(0) + " " + reader.GetInt32(1));
                }
            }
        }
    }
}
