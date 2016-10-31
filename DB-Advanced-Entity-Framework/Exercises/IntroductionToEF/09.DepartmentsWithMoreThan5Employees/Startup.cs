namespace _09.DepartmentsWithMoreThan5Employees
{
    using System;
    using System.Collections.Generic;
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

            var departments = db.Departments
                .Where(d => d.Employees.Count > 5)
                .OrderBy(d => d.Employees.Count)
                .Select(d => new
                {
                    Name = d.Name,
                    Manager = d.Employee.FirstName,
                    DepEmployees = d.Employees
                });

            foreach (var department in departments)
            {
                Console.WriteLine($"{department.Name} {department.Manager}");

                var employees = department.DepEmployees;
                foreach (var employee in employees)
                {
                    Console.WriteLine($"{employee.FirstName} {employee.LastName} {employee.JobTitle}");
                }
            }
        }
    }
}
