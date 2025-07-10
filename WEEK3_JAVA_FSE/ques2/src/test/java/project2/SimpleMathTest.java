package project2;

import org.junit.jupiter.api.Tag;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;

@Tag("fast")
class SimpleMathTest {

 @Test
 void testAddition() {
     assertEquals(5, 2 + 3, "2 + 3 should equal 5");
 }
}