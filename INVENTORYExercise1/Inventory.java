package Algorithm_Data_Structures.INVENTORYExercise1;

import java.util.HashMap;

public class Inventory {
    private HashMap<Integer, Product> products = new HashMap<>();

    public void addProduct(Product product) {
        products.put(product.productId, product);
    }

    public void updateProduct(int productId, Product updatedProduct) {
        products.put(productId, updatedProduct);
    }

    public void deleteProduct(int productId) {
        products.remove(productId);
    }

    public void displayInventory() {
        for (Product p : products.values()) {
            System.out.println(p.productId + " | " + p.productName + " | Qty: " + p.quantity + " | ₹" + p.price);
        }
    }
}
