namespace SalesSystem.Models
{
    using System.Collections.Generic;
    public class Customer
    {
        private ICollection<Sale> sales;

        public Customer()
        {
            this.sales = new HashSet<Sale>();
        }

        public int Id { get; set; }

        public string Name { get; set; }

        public string Email { get; set; }

        public string CreditCardNumber { get; set; }

        public virtual ICollection<Sale> SalesForCustomer
        {
            get { return this.sales; }
            set { this.sales = value; }
        }
    }
}