package Exercise6;

public class Main {
    public static void main(String[] args) {
        Image image1 = new ProxyImage("nature.jpg");

        // Image will be loaded and then displayed
        image1.display();

        System.out.println("------");

        // Image already loaded, just display
        image1.display();
    }
}
