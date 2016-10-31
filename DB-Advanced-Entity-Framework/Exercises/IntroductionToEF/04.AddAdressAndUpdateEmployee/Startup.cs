namespace _04.AddAdressAndUpdateEmployee
{
    using System;
    using System.Linq;
    using Data;
    using Data.Models;

    public class Startup
    {
        public static void Main()
        {
            var db = new SoftuniContext();

            var adress = new Address
            {
                AddressText = "Vitoshka 15",
                TownID = 4
            };

            Employee employee = null;
            using (db)
            {
                employee = db.Employees
                    .Where(e => e.LastName == "Nakov")
                    .FirstOrDefault();
                
                if (employee != null)
                {
                    employee.Address = adress;
                }

                db.SaveChanges();

                db.Employees
                    .OrderByDescending(e => e.AddressID)
                    .Take(10)
                    .Select(e => e.Address.AddressText)
                    .ToList()
                    .ForEach(Console.WriteLine);
            }
        }
    }
}
