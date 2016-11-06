namespace UsersData.ConsoleApp
{
    using System;
    using Models;
    using Data;

    public class Startup
    {
        public static void Main()
        {
            var db = new UsersContext();
            using (db)
            {
                var user = new User
                {
                    Username = "firstUser",
                    Password = "Pass123",
                    Email = "firstUser@someprovider.com",
                    Age = 22
                };

                db.Users.Add(user);
                db.SaveChanges();
            }
        }
    }
}
