namespace StudentSystem.ConsoleClient
{
    using Data;

    public class Startup
    {
        public static void Main()
        {
            var db = new StudentSystemContext();
            db.Database.Initialize(true);
        }
    }
}
