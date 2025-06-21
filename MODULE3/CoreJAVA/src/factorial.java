import java.util.Scanner;

public class factorial {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.println("Enter a non-negative number :");
        int n = sc.nextInt();

        int res = 1;
        for (int i=1 ;i<=n;i++){
            res *= i;
        }
        System.out.println(res);
    }
}
