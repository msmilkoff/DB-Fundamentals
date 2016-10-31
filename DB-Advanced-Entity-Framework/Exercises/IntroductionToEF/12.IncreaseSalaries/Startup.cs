namespace _12.IncreaseSalaries
{
    using System;
    using System.Linq;
    using Data;

    public class Startup
    {
        public static void Main()
        {
            var db = new SoftuniContext();

            var deps = new[] { "Engineering", "Tool Design", "Marketing", "Information Services" };

            using (db)
            {
                var employees = db.Employees
                    .Where(e => deps.Contains(e.Department.Name));

                foreach (var employee in employees)
                {
                    employee.Salary *= 1.12m;
                }

                db.SaveChanges();

                foreach (var employee in employees)
                {
                    Console.WriteLine($"{employee.FirstName} {employee.LastName} (${employee.Salary:F6})");
                }
            }
        }
    }
}
