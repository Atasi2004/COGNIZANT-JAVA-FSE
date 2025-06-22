package Algorithm_Data_Structures.E_COMMERCEPLATFORMExercise2;

public class LinearSearch {
    public static int search(Product[] products, String targetName) {
        for (int i = 0; i < products.length; i++) {
            if (products[i].productName.equalsIgnoreCase(targetName)) {
                return i;
            }
        }
        return -1;
    }
}

    
