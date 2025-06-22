package Exercise8;

public class Main {
    public static void main(String[] args) {
        PaymentContext context = new PaymentContext();

        // Use Credit Card Payment
        context.setPaymentStrategy(new CreditCardPayment("1234-5678-9876-5432"));
        context.makePayment(1500.00);

        System.out.println("-----");

        // Switch to PayPal Payment
        context.setPaymentStrategy(new PayPalPayment("user@example.com"));
        context.makePayment(2999.99);
    }
}
