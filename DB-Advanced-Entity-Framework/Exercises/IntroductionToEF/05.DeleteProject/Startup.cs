namespace _05.DeleteProject
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
                var project = db.Projects.Find(2);
                var employees = project.Employees;
                foreach (var emp in employees)
                {
                    emp.Projects.Remove(project);
                }

                db.SaveChanges();

                db.Projects.Remove(project);
                db.SaveChanges();

                db.Projects
                    .Take(10)
                    .Select(p => p.Name)
                    .ToList()
                    .ForEach(Console.WriteLine);
            }
        }
    }
}
