package Algorithm_Data_Structures.LIBRARYMANAGEMENTSYSTEM;

public class LinearSearch {
    public static Book search(Book[] books, String title) {
        for (Book book : books) {
            if (book.title.equalsIgnoreCase(title)) {
                return book;
            }
        }
        return null;
    }
}
