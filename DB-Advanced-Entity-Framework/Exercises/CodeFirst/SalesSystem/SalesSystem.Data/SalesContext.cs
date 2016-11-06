namespace SalesSystem.Data
{
    using System.Data.Entity;
    using Models;

    public class SalesContext : DbContext
    {
        public SalesContext()
            :base("SalesSystem")
        {
        }

        public IDbSet<Customer> Customers { get; set; }

        public IDbSet<Product> Products { get; set; }

        public IDbSet<StoreLocation> StoreLocations { get; set; }

        public IDbSet<Sale> Sales { get; set; }
    }
}