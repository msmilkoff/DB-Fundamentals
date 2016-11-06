namespace SalesSystem.Models
{
    using System.Collections.Generic;

    public class Product
    {
        private ICollection<Sale> sales;

        public Product()
        {
            this.sales = new HashSet<Sale>();
        }

        public int Id { get; set; }

        public string Name { get; set; }

        public double? Quantity { get; set; }

        public decimal? Price { get; set; }

        public virtual ICollection<Sale> SalesOfProduct
        {
            get { return this.sales; }
            set { this.sales = value; }
        }
    }
}