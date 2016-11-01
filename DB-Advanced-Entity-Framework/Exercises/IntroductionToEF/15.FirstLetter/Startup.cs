namespace _15.FirstLetter
{
    using System;
    using System.Linq;
    using GringottsData;

    public class Startup
    {
        public static void Main()
        {
            var db = new GringottsContext();

            using (db)
            {
                var wizardNames = db.WizzardDeposits
                    .Where(w => w.DepositGroup == "Troll Chest")
                    .OrderBy(w => w.FirstName)
                    .Select(w => w.FirstName.Substring(0, 1))
                    .Distinct();

                foreach (var name in wizardNames)
                {
                    Console.WriteLine(name);
                }
            }
        }
    }
}
