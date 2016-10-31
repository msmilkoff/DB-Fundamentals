namespace _08.Employee147
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
                var employee = db.Employees.Find(147);
                var projects = employee.Projects
                    .OrderBy(p => p.Name);

                Console.WriteLine($"{employee.FirstName} {employee.LastName} {employee.JobTitle}");
                foreach (var project in projects)
                {
                    Console.WriteLine($"{project.Name}");
                }
            }
        }
    }
}
