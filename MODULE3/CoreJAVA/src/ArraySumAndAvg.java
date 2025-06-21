import java.util.Scanner;

public class ArraySumAndAvg {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.println("enter number of elements : ");
        int n = sc.nextInt();
        int []arr = new int[n];
        System.out.println("enter " +n +" elements in array");
        for (int i=0;i<n;i++){
            arr[i] = sc.nextInt();
        }
        int sum = 0;
        for(int num:arr){
            sum += num;
        }
        System.out.println("Sum of elements in array = "+sum);
        System.out.println("Average of elements in array = "+sum/n);
    }
}
