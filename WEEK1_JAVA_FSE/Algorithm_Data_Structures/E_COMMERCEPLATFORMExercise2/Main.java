package Algorithm_Data_Structures.E_COMMERCEPLATFORMExercise2;

public class Main {
    public static void main(String[] args) {
        Product[] products = {
            new Product(1, "Laptop", "Electronics"),
            new Product(2, "Shoes", "Footwear"),
            new Product(3, "Mobile", "Electronics"),
            new Product(4, "Watch", "Accessories")
        };

        int indexLinear = LinearSearch.search(products, "Mobile");
        System.out.println("Linear Search: Found at index " + indexLinear);

        int indexBinary = BinarySearch.search(products, "Mobile");
        System.out.println("Binary Search: Found at index " + indexBinary);
    }
}
