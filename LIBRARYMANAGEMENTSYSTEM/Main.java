package Algorithm_Data_Structures.LIBRARYMANAGEMENTSYSTEM;

public class Main {
    public static void main(String[] args) {
        Book[] library = {
            new Book(101, "Java Fundamentals", "James Gosling"),
            new Book(102, "Python Basics", "Guido van Rossum"),
            new Book(103, "Data Structures", "Robert Lafore"),
            new Book(104, "Algorithms", "Thomas Cormen")
        };

        System.out.println("Linear Search for 'Data Structures':");
        Book result1 = LinearSearch.search(library, "Data Structures");
        System.out.println(result1 != null ? result1 : "Not found");

        System.out.println("\nBinary Search for 'Algorithms':");
        Book result2 = BinarySearch.search(library, "Algorithms");
        System.out.println(result2 != null ? result2 : "Not found");
    }
}
