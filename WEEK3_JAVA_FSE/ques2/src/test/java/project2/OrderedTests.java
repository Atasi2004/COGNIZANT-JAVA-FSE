package project2;

import org.junit.jupiter.api.MethodOrderer;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
class OrderedTests {

 @Test
 @Order(1)
 void firstTest() {
     System.out.println("Executing first test...");
 }

 @Test
 @Order(3)
 void thirdTest() {
     System.out.println("Executing third test...");
 }

 @Test
 @Order(2)
 void secondTest() {
     System.out.println("Executing second test...");
 }
}