namespace UsersData.Data
{
    using System.Data.Entity;
    using Models;

    public class UsersContext : DbContext
    {
        public UsersContext()
            :base("UsersDb")
        {

        }

        public IDbSet<User> Users { get; set; }
    }
}
