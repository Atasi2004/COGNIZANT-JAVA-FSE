package Algorithm_Data_Structures.INVENTORYExercise1;
public class Main {
    public static void main(String[] args) {
        Inventory inventory = new Inventory();

        Product p1 = new Product(101, "Mouse", 20, 499.99);
        Product p2 = new Product(102, "Keyboard", 10, 899.50);

        inventory.addProduct(p1);
        inventory.addProduct(p2);
        inventory.displayInventory();

        Product updated = new Product(102, "Mechanical Keyboard", 15, 1299.00);
        inventory.updateProduct(102, updated);
        inventory.deleteProduct(101);

        System.out.println("After updates:");
        inventory.displayInventory();
    }
}

