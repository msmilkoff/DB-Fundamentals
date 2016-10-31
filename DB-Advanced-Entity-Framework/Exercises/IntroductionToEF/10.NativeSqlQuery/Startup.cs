namespace _10.NativeSqlQuery
{
    using System;
    using System.Diagnostics;
    using System.Linq;
    using Data;

    public class Startup
    {
        public static void Main()
        {
            var db = new SoftuniContext();

            var timer = new Stopwatch();
            timer.Start();
            PrintNamesWithNativeQuery(db);
            timer.Stop();
            Console.WriteLine($"Native: {timer.Elapsed}\n");

            timer.Restart();
            PrintNamesWithLinq(db);
            timer.Stop();
            Console.WriteLine($"Linq: {timer.Elapsed}");

            db.Dispose();
        }

        private static void PrintNamesWithLinq(SoftuniContext db)
        {
            using (db)
            {
                var employeeNames = db.Employees
                    .Where(e => e.Projects
                        .All(p => p.StartDate.Year == 2002))
                    .Select(e => e.FirstName);

                foreach (var employeeName in employeeNames)
                {
                    Console.WriteLine(employeeName);
                }
            }
        }

        private static void PrintNamesWithNativeQuery(SoftuniContext db)
        {
            var employeeNames = db.Database.SqlQuery<string>("SELECT [FirstName] FROM [Employees]");

            foreach (var employeeName in employeeNames)
            {
                Console.WriteLine(employeeName);
            }
        }
    }
}
