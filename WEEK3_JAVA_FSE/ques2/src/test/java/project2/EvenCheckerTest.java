package project2;

//src/test/java/EvenCheckerTest.java
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;
import static org.junit.jupiter.api.Assertions.*;

class EvenCheckerTest {

 private final EvenChecker checker = new EvenChecker();

 @ParameterizedTest
 @ValueSource(ints = {2, 4, 8, -2, -10, 100})
 void shouldReturnTrueForEvenNumbers(int number) {
     assertTrue(checker.isEven(number), number + " should be even");
 }

 @ParameterizedTest
 @ValueSource(ints = {1, 3, 9, -5, -11, 101})
 void shouldReturnFalseForOddNumbers(int number) {
     assertFalse(checker.isEven(number), number + " should be odd");
 }
}