package Algorithm_Data_Structures.LIBRARYMANAGEMENTSYSTEM;

import java.util.Arrays;
import java.util.Comparator;

public class BinarySearch {
    public static Book search(Book[] books, String title) {
        // Sort books by title
        Arrays.sort(books, Comparator.comparing(b -> b.title.toLowerCase()));

        int left = 0, right = books.length - 1;

        while (left <= right) {
            int mid = (left + right) / 2;
            int compare = title.compareToIgnoreCase(books[mid].title);

            if (compare == 0) return books[mid];
            else if (compare < 0) right = mid - 1;
            else left = mid + 1;
        }

        return null;
    }
}
