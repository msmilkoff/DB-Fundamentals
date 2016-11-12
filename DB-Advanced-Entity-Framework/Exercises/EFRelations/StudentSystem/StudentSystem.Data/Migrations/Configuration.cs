namespace StudentSystem.Data.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    using Models;

    public sealed class Configuration : DbMigrationsConfiguration<StudentSystemContext>
    {
        public Configuration()
        {
            this.AutomaticMigrationsEnabled = true;
            this.AutomaticMigrationDataLossAllowed = false;
        }

        protected override void Seed(StudentSystemContext context)
        {
        //    context.Students.AddOrUpdate(s => s.Name, new Student
        //    {
        //        Name = "Peter Ivanov",
        //        RegistrationDate = DateTime.Now,
        //        BirthDay = new DateTime(1995, 12, 12)
        //    });

        //    context.Homeworks.AddOrUpdate(h => h.StudentId, new Homework
        //    {
        //        Content = "submission-001.zip",
        //        ContentType = ContentType.Zip,
        //        StudentId = 1,
        //        CourseId = 1,
        //        SubmissionDate = DateTime.Now
        //    });
        }
    }
}
