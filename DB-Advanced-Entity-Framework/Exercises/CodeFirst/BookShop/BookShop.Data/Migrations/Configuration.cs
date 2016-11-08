namespace BookShop.Data.Migrations
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Migrations;
    using System.Globalization;
    using System.IO;
    using System.Linq;
    using Models;

    public sealed class Configuration : DbMigrationsConfiguration<BookShopContext>
    {
        public Configuration()
        {
            this.AutomaticMigrationsEnabled = true;
            this.ContextKey = "BookShop.Data.BookShopContext";
            this.AutomaticMigrationDataLossAllowed = false;
        }

        protected override void Seed(BookShopContext context)
        {
            string categoriesPath = @"../../../TextFiles/categories.txt";
            string authorsPath = @"../../../TextFiles/authors.txt";
            string booksPath = @"../../../TextFiles/books.txt";

            if (!context.Categories.Any())
            {
                AddCategories(context, categoriesPath);
            }

            if (!context.Authors.Any())
            {
                AddAuthors(context, authorsPath);
            }

            if (!context.Books.Any())
            {
                AddBooks(context, booksPath);

                var categories = context.Categories.ToList();
                var books = context.Books.Include(b => b.Categories);
                foreach (var book in books)
                {
                    var categoryIndex = new Random().Next(0, categories.Count);
                    var category = categories[categoryIndex];
                    book.Categories.Add(category);
                }
            }
        }

        private void AddBooks(BookShopContext context, string booksPath)
        {
            const int maxTokens = 6;

            using (var reader = new StreamReader(booksPath))
            {
                var line = reader.ReadLine();
                while (!string.IsNullOrEmpty(line))
                {
                    var tokens = line.Split(new[] { ' ' }, maxTokens);
                    var edition = (EditionType)int.Parse(tokens[0]);
                    var releaseDate = DateTime.ParseExact(tokens[1], "d/M/yyyy", CultureInfo.InvariantCulture);
                    var copies = int.Parse(tokens[2]);
                    var price = decimal.Parse(tokens[3]);
                    var ageRestriction = int.Parse(tokens[4]);
                    var title = tokens[5];

                    var random = new Random();

                    var authors = context.Authors.ToList();
                    var authorIndex = random.Next(0, authors.Count);
                    var author = authors[authorIndex];

                    context.Books.Add(new Book
                    {
                        Edition = edition,
                        ReleaseDate = releaseDate,
                        Copies = copies,
                        Price = price,
                        AgeRestriction = ageRestriction,
                        Title = title,
                        Author = author
                    });

                    line = reader.ReadLine();
                }
            }
        }

        private void AddAuthors(BookShopContext context, string authorsPath)
        {
            using (var reader = new StreamReader(authorsPath))
            {
                var line = reader.ReadLine();
                while (!string.IsNullOrEmpty(line))
                {
                    var authorInfo = line.Split(new[] { ' ' });
                    context.Authors.Add(new Author
                    {
                        FirstName = authorInfo[0],
                        LastName = authorInfo[1]
                    });

                    line = reader.ReadLine();
                }
            }
        }

        private void AddCategories(BookShopContext context, string path)
        {
            using (var reader = new StreamReader(path))
            {
                var categoryName = reader.ReadLine();
                while (!string.IsNullOrEmpty(categoryName))
                {
                    context.Categories.Add(new Category
                    {
                        Name = categoryName
                    });

                    categoryName = reader.ReadLine();
                }
            }
        }
    }
}
