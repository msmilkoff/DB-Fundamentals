namespace _06.FindEmployeesInPeriod
{
    using System;
    using System.Globalization;
    using System.Linq;
    using System.Threading;
    using Data;

    public class Startup
    {
        public static void Main()
        {
            Thread.CurrentThread.CurrentCulture = CultureInfo.InvariantCulture;

            var db = new SoftuniContext();

            using (db)
            {
                var employees = db.Employees
                    .Where(e => e.Projects
                        .Count(p => p.StartDate.Year >= 2001 && p.StartDate.Year <= 2003) > 0)
                    .Take(30);

                foreach (var employee in employees)
                {
                    Console.WriteLine($"{employee.FirstName} {employee.LastName} {employee.Manager.FirstName}");
                    foreach (var project in employee.Projects)
                    {
                        Console.WriteLine($"--{project.Name} {project.StartDate} {project.EndDate}");
                    }
                }
            }
        }
    }
}
