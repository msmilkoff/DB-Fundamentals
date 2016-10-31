namespace _11.FindLatestProjects
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
                var projects = db.Projects
                    .OrderByDescending(p => p.StartDate)
                    .Take(10)
                    .OrderBy(p => p.Name);

                foreach (var project in projects)
                {
                    var startDate = project.StartDate.ToString("M/d/yyy h:mm:ss tt");
                    Console.WriteLine($"{project.Name} {project.Description} {startDate.Replace('-', '/')} {project.EndDate}");
                }
            }
        }
    }
}
