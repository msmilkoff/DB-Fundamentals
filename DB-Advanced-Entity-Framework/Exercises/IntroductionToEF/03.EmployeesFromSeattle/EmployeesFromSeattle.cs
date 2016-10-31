namespace _03.EmployeesFromSeattle
{
    using System;
    using System.Linq;
    using Data;

    public class EmployeesFromSeattle
    {
        public static void Main()
        {
            var db = new SoftuniContext();
            using (db)
            {
                var employees = db.Employees
                    .Where(e => e.Department.Name == "Research and Development")
                    .OrderBy(e => e.Salary)
                    .ThenByDescending(e => e.FirstName);

                foreach (var emp in employees)
                {
                    Console.WriteLine($"{emp.FirstName} {emp.LastName} from {emp.Department.Name} - ${emp.Salary:F2}");
                }
            }
        }
    }
}
