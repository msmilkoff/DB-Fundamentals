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
            context.Courses.AddOrUpdate(c => c.Name,
                new Course
                {
                    Name = "CSharp Basics",
                    Description = "Programming basics with C#",
                    Price = 50m,
                    StartDate = new DateTime(2016, 9, 15),
                    EndDate = new DateTime(2016, 11, 15)
                },
                new Course
                {
                    Name = "Java EE",
                    Description = "Java Enterprise development",
                    Price = 200m,
                    StartDate = new DateTime(2016, 11, 01),
                    EndDate = new DateTime(2017, 02, 01)
                });

            context.SaveChanges();

            context.Students.AddOrUpdate(
                s => s.Name,
                new Student
                {
                    Name = "Peter Ivanov",
                    RegistrationDate = DateTime.Now,
                    BirthDay = new DateTime(1995, 12, 12)
                },
                new Student
                {
                    Name = "Georgi Georgiev",
                    RegistrationDate = DateTime.Now,
                    BirthDay = new DateTime(1994, 2, 5)
                });

            context.SaveChanges();

            context.Homeworks.AddOrUpdate(h => h.Content,
                new Homework
                {
                    Content = "submission-001.zip",
                    ContentType = ContentType.Zip,
                    StudentId = 1,
                    CourseId = 1,
                    SubmissionDate = DateTime.Now
                },
                new Homework
                {
                    Content = "submission-002.pdf",
                    ContentType = ContentType.Pdf,
                    StudentId = 2,
                    CourseId = 2,
                    SubmissionDate = DateTime.Now
                });
            context.SaveChanges();

            context.Resources.AddOrUpdate(r => r.Name,
                new Resource
                {
                    Name = "exercise-001.docx",
                    ResourceType = ResourceType.Document,
                    Url = "www.studentsystem.io/resources/id=1",
                    CourseId = 1
                },
                new Resource
                {
                    Name = "youtube-video-001",
                    ResourceType = ResourceType.Video,
                    Url = "youtu.be/jxnhrhu",
                    CourseId = 2
                });

            context.SaveChanges();
        }
    }
}
