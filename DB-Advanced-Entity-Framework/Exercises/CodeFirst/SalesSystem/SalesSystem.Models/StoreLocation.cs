namespace SalesSystem.Models
{
    using System.Collections.Generic;

    public class StoreLocation
    {
        private ICollection<Sale> sales;

        public StoreLocation()
        {
            this.sales = new HashSet<Sale>();
        }

        public int Id { get; set; }

        public string LocationName { get; set; }

        public virtual ICollection<Sale> SalesInStore
        {
            get { return this.sales; }
            set { this.sales = value; }
        }
    }
}