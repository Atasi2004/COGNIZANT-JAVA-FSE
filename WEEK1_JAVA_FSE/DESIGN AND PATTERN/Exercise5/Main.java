package Exercise5;

public class Main {
    public static void main(String[] args) {
        // Base notifier: only Email
        Notifier emailNotifier = new EmailNotifier();
        emailNotifier.send("Server down!");

        System.out.println("-----");

        // Email + SMS
        Notifier smsNotifier = new SMSNotifierDecorator(new EmailNotifier());
        smsNotifier.send("Low disk space!");

        System.out.println("-----");

        // Email + SMS + Slack
        Notifier allNotifier = new SlackNotifierDecorator(new SMSNotifierDecorator(new EmailNotifier()));
        allNotifier.send("High memory usage!");
    }
}
