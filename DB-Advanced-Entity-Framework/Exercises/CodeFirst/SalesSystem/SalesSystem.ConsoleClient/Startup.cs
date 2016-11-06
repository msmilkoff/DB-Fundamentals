namespace SalesSystem.ConsoleClient
{
    using System;
    using System.Data.Entity;
    using Data;
    using Data.Migrations;
    using Models;

    public class Startup
    {
        public static void Main()
        {
            Database.SetInitializer(new MigrateDatabaseToLatestVersion<SalesContext, Configuration>());

            var db = new SalesContext();
            using (db)
            {
                db.Products.Add(new Product
                {
                    Name = "RandomProduct",
                    Price = 1000m,
                    Quantity = 2
                });

                Console.WriteLine(db.SaveChanges());
            }
        }
    }
}
