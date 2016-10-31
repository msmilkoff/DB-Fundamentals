namespace _02.EmployeesBySalary
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
                db.Employees
                    .Where(e => e.Salary > 50000)
                    .Select(e => e.FirstName)
                    .ToList()
                    .ForEach(Console.WriteLine);
            }
        }
    }
}
