namespace Gringotts.Data
{
    using System.Data.Entity;
    using Models;

    public class GringottsContext : DbContext
    {
        public GringottsContext()
            :base("Gringotts")
        {
            
        }

        public IDbSet<WizardDeposit> WizardDeposits { get; set; }
    }
}