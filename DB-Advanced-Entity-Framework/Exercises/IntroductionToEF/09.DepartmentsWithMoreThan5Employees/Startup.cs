namespace _09.DepartmentsWithMoreThan5Employees
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
                var departments = db.Departments
                    .Where(d => d.Employees.Count > 5)
                    .OrderBy(d => d.Employees.Count);

                foreach (var department in departments)
                {
                    Console.WriteLine($"{department.Name} {department.Employee.FirstName}");

                    var employees = department.Employees;
                    foreach (var employee in employees)
                    {
                        Console.WriteLine($"{employee.FirstName} {employee.LastName} {employee.JobTitle}");
                    }
                }
            }
        }
    }
}
