package Exercise7;

public class WebApp implements Observer {
    private String name;

    public WebApp(String name) {
        this.name = name;
    }

    @Override
    public void update(String stockName, double price) {
        System.out.println(name + " (Web): " + stockName + " is now ₹" + price);
    }
}
