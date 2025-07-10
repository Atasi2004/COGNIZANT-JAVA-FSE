package project2;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class ExceptionThrowerTest {

 private final ExceptionThrower exceptionThrower = new ExceptionThrower();

 @Test
 void shouldThrowExceptionForNegativeInput() {
     IllegalArgumentException thrownException = assertThrows(
         IllegalArgumentException.class,
         () -> exceptionThrower.throwExceptionIfNegative(-1)
     );

     assertEquals("Number cannot be negative", thrownException.getMessage());
 }

 @Test
 void shouldNotThrowExceptionForPositiveInput() {
     assertDoesNotThrow(
         () -> exceptionThrower.throwExceptionIfNegative(10)
     );
 }
}
