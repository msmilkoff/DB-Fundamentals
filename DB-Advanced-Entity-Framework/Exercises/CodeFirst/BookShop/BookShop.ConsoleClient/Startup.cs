namespace BookShop.ConsoleClient
{
    using System;
    using System.Data.Entity;
    using System.Linq;
    using Data;
    using Data.Migrations;

    public class Startup
    {
        public static void Main()
        {
            Database.SetInitializer(new MigrateDatabaseToLatestVersion<BookShopContext, Configuration>());

            var db = new BookShopContext();

            using (db)
            {
                
            }
        }

        private static void PrintMostRecentBooksByCategory(BookShopContext db)
        {
            var categories = db.Categories
                .Include(c => c.Books)
                .Select(c => new
                {
                    Name = c.Name,
                    BookCount = c.Books.Count,
                    Books = c.Books
                        .Select(b => new
                        {
                            Title = b.Title,
                            ReleaseDate = b.ReleaseDate
                        })
                        .OrderByDescending(b => b.ReleaseDate)
                        .ThenBy(b => b.Title)
                })
                .OrderByDescending(c => c.BookCount);

            Console.WriteLine("--------------------------------------------------------------------");
            Console.WriteLine(" Top 3 Most recent books by category, ordered by total book count (descending)");
            Console.WriteLine("--------------------------------------------------------------------");

            foreach (var category in categories)
            {
                Console.WriteLine($"--{category.Name}: {category.BookCount} books");
                foreach (var books in category.Books)
                {
                    Console.WriteLine($"---> {books.Title} ({books.ReleaseDate})");
                }
            }

            Console.WriteLine();
        }

        private static void PrintBooksByGeorgePowell(BookShopContext db)
        {
            var books = db.Books
                .Where(b => b.Author.FirstName == "George"
                          && b.Author.LastName == "Powell")
                .OrderByDescending(b => b.ReleaseDate)
                .ThenBy(b => b.Title)
                .Select(b => new
                {
                    Title = b.Title,
                    ReleaseDate = b.ReleaseDate,
                    Copies = b.Copies
                });

            Console.WriteLine("--------------------------------------------------------------------");
            Console.WriteLine("Books by George Powell, ordered by release date (descending)");
            Console.WriteLine("--------------------------------------------------------------------");

            foreach (var book in books)
            {
                Console.WriteLine($"--{book.Title} ({book.ReleaseDate.Value.Year}) {book.Copies}");
            }
        }

        private static void PrintAuthorsByNumberOfBooks(BookShopContext db)
        {
            var authors = db.Authors
                .Include(a => a.Books)
                .OrderByDescending(a => a.Books.Count)
                .Select(a => new
                {
                    FirstName = a.FirstName,
                    LastName = a.LastName,
                    BookCount = a.Books.Count
                });

            Console.WriteLine("--------------------------------------------------------------------");
            Console.WriteLine("Authors, ordered by number of books (descending)");
            Console.WriteLine("--------------------------------------------------------------------");

            foreach (var author in authors)
            {
                Console.WriteLine($"--{author.FirstName} {author.LastName} {author.BookCount}");
            }

            Console.WriteLine();
        }

        private static void PrintAuthorsWhoReleasedBookBefore1990(BookShopContext db)
        {
            var authors = db.Authors
                .Include(a => a.Books)
                .Where(a => a.Books.Count > 0)
                .Select(a => new
                {
                    FirstName = a.FirstName,
                    LastName = a.LastName,
                    Books = a.Books.Where(b => b.ReleaseDate.Value.Year < 1990)
                });

            Console.WriteLine("--------------------------------------------------------------------");
            Console.WriteLine("Authors who released at least one book before 1990");
            Console.WriteLine("--------------------------------------------------------------------");

            foreach (var author in authors)
            {
                Console.WriteLine($"--{author.FirstName} {author.LastName}");
            }

            Console.WriteLine();
        }

        private static void PrintBooksAfter2000(BookShopContext db)
        {
            var bookTitles = db.Books
                .Where(b => b.ReleaseDate.Value.Year > 2000)
                .Select(b => b.Title);

            Console.WriteLine("--------------------------------------------------------------------");
            Console.WriteLine("Books released after the year 2000");
            Console.WriteLine("--------------------------------------------------------------------");

            foreach (var title in bookTitles)
            {
                Console.WriteLine($"--{title}");
            }

            Console.WriteLine();
        }
    }
}
