//
//  BooksMockData.swift
//  DigitalLibrary
//
//  Created by Desislava D. Dimitrova on 25.01.24.
//

import Foundation

struct BooksMockData {
    static let books: [Book] = [
        Book(title: "Harry Potter and the Philosopher's Stone",
             description: "Introduces readers to the young wizard Harry Potter and his adventures at Hogwarts School of Witchcraft and Wizardry",
             author: "J.K. Rowling",
             publisher: "Bloomsbury",
             year: 1997,
             genre: "Fantasy",
             returningDeadline: Calendar.current.date(byAdding: .day, value: 0, to: Date())),
        Book(title: "Harry Potter and the Chamber of Secrets",
             description: "Follows Harry's second year at Hogwarts and the discovery of the Chamber of Secrets",
             author: "J.K. Rowling",
             publisher: "Bloomsbury",
             year: 1998,
             genre: "Fantasy",
             returningDeadline: Calendar.current.date(byAdding: .day, value: 5, to: Date())),
        Book(title: "Harry Potter and the Prisoner of Azkaban",
             description: "Harry learns more about his past and encounters the dangerous prisoner Sirius Black",
             author: "J.K. Rowling",
             publisher: "Bloomsbury",
             year: 1999,
             genre: "Fantasy",
             returningDeadline: Calendar.current.date(byAdding: .day, value: 2, to: Date())),
        Book(title: "Harry Potter and the Goblet of Fire",
             description: "Harry competes in the Triwizard Tournament, facing unexpected challenges and dangers",
             author: "J.K. Rowling",
             publisher: "Bloomsbury",
             year: 2000,
             genre: "Fantasy",
             returningDeadline: Calendar.current.date(byAdding: .day, value: 14, to: Date())),
        Book(title: "Harry Potter and the Order of the Phoenix",
             description: "Harry faces challenges and uncovers dark secrets as he prepares for the looming threat of Lord Voldemort",
             author: "J.K. Rowling",
             publisher: "Bloomsbury",
             year: 2003,
             genre: "Fantasy",
             returningDeadline: Calendar.current.date(byAdding: .day, value: 2, to: Date())),
        Book(title: "Harry Potter and the Half-Blood Prince",
             description: "Reveals the backstory of Lord Voldemort and Harry's final years at Hogwarts",
             author: "J.K. Rowling",
             publisher: "Bloomsbury",
             year: 2005,
             genre: "Fantasy",
             returningDeadline: Calendar.current.date(byAdding: .day, value: 18, to: Date())),
        Book(title: "Harry Potter and the Deathly Hallows",
             description: "Follows Harry, Ron, and Hermione as they hunt for Horcruxes and face the final showdown against Lord Voldemort",
             author: "J.K. Rowling",
             publisher: "Bloomsbury",
             year: 2007,
             genre: "Fantasy",
             returningDeadline: Calendar.current.date(byAdding: .day, value: 12, to: Date())),
        Book(title: "The Hobbit",
             description: "Follows the adventure of Bilbo Baggins as he accompanies a group of dwarves on a quest to reclaim their homeland from the dragon Smaug",
             author: "J.R.R. Tolkien",
             publisher: "George Allen & Unwin",
             year: 1937,
             genre: "Fantasy",
             returningDeadline: Calendar.current.date(byAdding: .day, value: 6, to: Date())),
        Book(title: "To Kill a Mockingbird",
             description: "Explores racial injustice in the American South through the eyes of a young girl named Scout Finch",
             author: "Harper Lee",
             publisher: "J.B. Lippincott & Co.",
             year: 1960,
             genre: "Historical Fiction, Southern Gothic",
             returningDeadline: Calendar.current.date(byAdding: .day, value: 0, to: Date())),
        Book(title: "1984",
             description: "A dystopian novel depicting a totalitarian regime and the struggles of its protagonist against oppressive government control",
             author: "George Orwell",
             publisher: "Secker & Warburg",
             year: 1949,
             genre: "Dystopian Fiction",
             returningDeadline: Calendar.current.date(byAdding: .day, value: 10, to: Date())),
        Book(title: "The Great Gatsby",
             description: "Set in the Roaring Twenties, the novel explores themes of wealth, love, and the American Dream",
             author: "F. Scott Fitzgerald",
             publisher: "Charles Scribner's Sons",
             year: 1925,
             genre: "Classic, Jazz Age, Tragedy",
             returningDeadline: Calendar.current.date(byAdding: .day, value: 20, to: Date())),
        Book(title: "Pride and Prejudice",
             description: "A classic novel by Jane Austen, focusing on the issues of love, class, and manners in early 19th-century England",
             author: "Jane Austen",
             publisher: "T. Egerton, Whitehall",
             year: 1813,
             genre: "Classic, Romance, Satire",
             returningDeadline: Calendar.current.date(byAdding: .day, value: 3, to: Date())),
        Book(title: "One Hundred Years of Solitude",
             description: "A magical realist novel that chronicles the Buendía family over several generations in the fictional town of Macondo",
             author: "Gabriel García Márquez",
             publisher: "Editorial Sudamericana",
             year: 1967,
             genre: "Magical Realism"),
        Book(title: "The Catcher in the Rye",
             description: "Follows the experiences of Holden Caulfield, a disenchanted teenager, during a few days in New York City",
             author: "J.D. Salinger",
             publisher: "Little, Brown and Company",
             year: 1951,
             genre: "Coming-of-Age, Bildungsroman"),
        Book(title: "The Lord of the Rings",
             description: "A high-fantasy trilogy that follows the quest to destroy the One Ring and defeat the Dark Lord Sauron",
             author: "J.R.R. Tolkien",
             publisher: "George Allen & Unwin",
             year: 1954,
             genre: "High Fantasy, Epic Fantasy"),
        Book(title: "Brave New World",
             description: "A dystopian novel that explores a future society where people are conditioned for conformity and pleasure",
             author: "Aldous Huxley",
             publisher: "Chatto & Windus",
             year: 1932,
             genre: "Dystopian Fiction"),
        Book(title: "The Chronicles of Narnia: The Lion, the Witch and the Wardrobe",
             description: "The first book in C.S. Lewis's classic fantasy series, where four siblings discover a magical world through a wardrobe",
             author: "C.S. Lewis",
             publisher: "Geoffrey Bles",
             year: 1950,
             genre: "Fantasy"),
        Book(title: "The Hitchhiker's Guide to the Galaxy",
             description: "Follows the misadventures of Arthur Dent as he travels through space after the Earth is destroyed to make way for an interstellar highway",
             author: "Douglas Adams",
             publisher: "Pan Books",
             year: 1979,
             genre: "Science Fiction, Comedy"),
        Book(title: "The Hunger Games",
             description: "Set in a dystopian future where teenagers are forced to participate in a televised death match known as the Hunger Games",
             author: "Suzanne Collins",
             publisher: "Scholastic",
             year: 2008,
             genre: "Dystopian Fiction, Science Fiction"),
        Book(title: "The Da Vinci Code",
             description: "A mystery thriller that follows symbologist Robert Langdon as he investigates a murder at the Louvre Museum and unravels a conspiracy",
             author: "Dan Brown",
             publisher: "Doubleday",
             year: 2003,
             genre: "Mystery, Thriller, Conspiracy Fiction")
    ]
}