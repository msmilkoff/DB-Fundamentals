namespace _13.RemoveTowns
{
    using System;
    using System.Data.Entity;
    using System.Linq;
    using Data;

    public class Startup
    {
        public static void Main()
        {
            var db = new SoftuniContext();

            using (db)
            {
                string townName = Console.ReadLine();
                var townToDelete = db.Towns
                    .Include(t => t.Addresses)
                    .FirstOrDefault(t => t.Name == townName);

                var adressesToDelete = townToDelete.Addresses;
                foreach (var adress in adressesToDelete)
                {
                    foreach (var employee in adress.Employees)
                    {
                        employee.AddressID = null;
                    }
                }

                db.Addresses.RemoveRange(adressesToDelete);
                db.Towns.Remove(townToDelete);
                db.SaveChanges();

                Console.WriteLine($"{adressesToDelete.Count} address in {townName} were deleted");
            }
        }
    }
}
