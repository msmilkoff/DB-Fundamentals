namespace Gringotts.ConsoleClient
{
    using System;
    using System.Data.Entity.Infrastructure;
    using Data;
    using Models;

    public class Startup
    {
        public static void Main()
        {
            var db = new GringottsContext();
            using (db)
            {
                var deposit = new WizardDeposit
                {
                    FirstName = "Albus",
                    LastName = "Dumbledore",
                    Age = 150,
                    MagicWandCreator = "Antioch Paverell",
                    MagicWandSize = 15,
                    DepositStartDate = new DateTime(2016, 10, 20),
                    DepositExpirationDate = new DateTime(2020, 10, 20),
                    DepositAmount = 20000.24m,
                    DepositCharge = 0.2m,
                    IsDepositExpired = false
                };

                db.WizardDeposits.Add(deposit);
                db.SaveChanges();
            }
        }
    }
}
