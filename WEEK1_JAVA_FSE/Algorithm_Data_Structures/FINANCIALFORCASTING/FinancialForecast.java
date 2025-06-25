package Algorithm_Data_Structures.FINANCIALFORCASTING;

public class FinancialForecast {

    // Recursive method to calculate future value
    public static double calculateFutureValue(double presentValue, double growthRate, int years) {
        if (years == 0) return presentValue;
        return calculateFutureValue(presentValue, growthRate, years - 1) * (1 + growthRate);
    }

    // Optimized version using memoization (optional)
    public static double[] memo;

    public static double calculateFutureValueMemo(double presentValue, double growthRate, int years) {
        memo = new double[years + 1];
        return helper(presentValue, growthRate, years);
    }

    private static double helper(double pv, double rate, int year) {
        if (year == 0) return pv;
        if (memo[year] != 0) return memo[year];
        return memo[year] = helper(pv, rate, year - 1) * (1 + rate);
    }
}
