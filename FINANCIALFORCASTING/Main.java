package Algorithm_Data_Structures.FINANCIALFORCASTING;

public class Main {
    public static void main(String[] args) {
        double presentValue = 10000.0;
        double growthRate = 0.10; // 10%
        int years = 5;

        double futureValue = FinancialForecast.calculateFutureValue(presentValue, growthRate, years);
        System.out.println("Future Value (Recursion): ₹" + futureValue);

        double optimizedFV = FinancialForecast.calculateFutureValueMemo(presentValue, growthRate, years);
        System.out.println("Future Value (Memoization): ₹" + optimizedFV);
    }
}
