package Algorithm_Data_Structures.E_COMMERCEPLATFORMExercise2;

import java.util.Arrays;
import java.util.Comparator;

public class BinarySearch {
    public static int search(Product[] products, String targetName) {
        // Sort array by productName
        Arrays.sort(products, Comparator.comparing(p -> p.productName));

        int left = 0, right = products.length - 1;
        while (left <= right) {
            int mid = (left + right) / 2;
            int cmp = targetName.compareToIgnoreCase(products[mid].productName);
            if (cmp == 0) return mid;
            else if (cmp < 0) right = mid - 1;
            else left = mid + 1;
        }
        return -1;
    }
}
