namespace SalesSystem.Data.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    using System.Linq;
    using Models;

    public sealed class Configuration : DbMigrationsConfiguration<SalesContext>
    {
        public Configuration()
        {
            this.AutomaticMigrationsEnabled = true;
            this.AutomaticMigrationDataLossAllowed = false;
        }

        protected override void Seed(SalesContext context)
        {
            if (!context.Customers.Any())
            {
                context.Customers.AddOrUpdate(new Customer
                {
                    Id = 1,
                    Name = "John Doe",
                    Email = "doe@mymail.com",
                    CreditCardNumber = "132-456-789"
                }); 
            }

            if (!context.Products.Any())
            {
                context.Products.AddOrUpdate(new Product
                {
                    Id = 1,
                    Name = "PC",
                    Price = 999.99m,
                    Quantity = 1
                }); 
            }

            if (!context.StoreLocations.Any())
            {
                context.StoreLocations.AddOrUpdate(new StoreLocation
                {
                    Id = 1,
                    LocationName = "Sofia"
                }); 
            }

            if (!context.Sales.Any())
            {
                context.Sales.AddOrUpdate(new Sale
                {
                    CustomerId = 1,
                    ProductId = 1,
                    StoreLocationId = 1,
                    Date = new DateTime(2016, 10, 10)
                }); 
            }

            base.Seed(context);

            context.SaveChanges();
        }
    }
}
