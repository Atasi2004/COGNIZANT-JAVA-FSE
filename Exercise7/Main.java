package Exercise7;

public class Main {
    public static void main(String[] args) {
        StockMarket stockMarket = new StockMarket();

        Observer mobileApp = new MobileApp("InvestorOne");
        Observer webApp = new WebApp("TraderX");

        stockMarket.registerObserver(mobileApp);
        stockMarket.registerObserver(webApp);

        stockMarket.setStockPrice("TCS", 3587.50);
        System.out.println("-----");
        stockMarket.setStockPrice("Infosys", 1460.00);
    }
}
