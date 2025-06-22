package Algorithm_Data_Structures.SortingCustomerExercise3;

public class Main {
    public static void printOrders(Order[] orders) {
        for (Order o : orders) {
            System.out.println(o);
        }
    }

    public static void main(String[] args) {
        Order[] orders = {
            new Order(101, "Amit", 950.0),
            new Order(102, "Ravi", 1500.0),
            new Order(103, "Nina", 1200.0)
        };

        System.out.println("Original Orders:");
        printOrders(orders);

        System.out.println("\nBubble Sorted Orders (by totalPrice):");
        BubbleSort.sort(orders);
        printOrders(orders);

        Order[] newOrders = {
            new Order(104, "Zara", 890.0),
            new Order(105, "Kiran", 3000.0),
            new Order(106, "Lata", 2100.0)
        };

        System.out.println("\nQuick Sorted Orders (by totalPrice):");
        QuickSort.sort(newOrders, 0, newOrders.length - 1);
        printOrders(newOrders);
    }
}
