namespace _07.AdressesByTownName
{
    using System;
    using System.Linq;
    using Data;

    public class Startup
    {
        public static void Main()
        {
            var db = new SoftuniContext();

            using (db)
            {
                var adresses = db.Addresses
                    .OrderByDescending(a => a.Employees.Count())
                    .ThenBy(a => a.Town.Name)
                    .Take(10);

                foreach (var adress in adresses)
                {
                    int numberOfEmployees = adress.Employees.Count();
                    Console.WriteLine($"{adress.AddressText}, {adress.Town.Name} - {numberOfEmployees} employees");
                }
            }
        }
    }
}
