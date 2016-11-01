namespace _14.EmployeesByFirstName
{
    using System;
    using System.Linq;
    using Data;

    public class Startup
    {
        public static void Main()
        {
            var db = new SoftuniContext();

            using (db)
            {
                var employees = db.Employees
                    .Where(e => e.FirstName.ToLower().StartsWith("sa"))
                    .Select(e => new
                    {
                        FirstName = e.FirstName,
                        LastName = e.LastName,
                        JobTitle = e.JobTitle,
                        Salary = e.Salary
                    });

                foreach (var employee in employees)
                {
                    Console.WriteLine($"{employee.FirstName} {employee.LastName} – {employee.JobTitle} - (${employee.Salary})");
                }
            }
        }
    }
}
