package project2;

public class ExceptionThrower {

 public void throwExceptionIfNegative(int number) {
     if (number < 0) {
         throw new IllegalArgumentException("Number cannot be negative");
     }
 }
}