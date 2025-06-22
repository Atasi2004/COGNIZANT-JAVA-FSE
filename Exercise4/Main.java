package Exercise4;

public class Main {
    public static void main(String[] args) {
        // Using PayPal Adapter
        PayPal payPal = new PayPal();
        PaymentProcessor paypalProcessor = new PayPalAdapter(payPal);
        paypalProcessor.processPayment(500.00);

        // Using Stripe Adapter
        Stripe stripe = new Stripe();
        PaymentProcessor stripeProcessor = new StripeAdapter(stripe);
        stripeProcessor.processPayment(1000.00);
    }
}
