namespace _01.EmployeesFullInfo
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
                    .Select(e => e.FirstName + " " + e.LastName + " " + e.MiddleName + " " + e.JobTitle + " " + e.Salary+ "00")
                    .ToList()
                    .ForEach(Console.WriteLine);
            }
        }
    }
}
