package project2;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.Timeout;

import java.time.Duration;
import java.util.concurrent.TimeUnit;

import static org.junit.jupiter.api.Assertions.assertTimeout;
import static org.junit.jupiter.api.Assertions.assertTimeoutPreemptively;

class PerformanceTesterTest {

 private final PerformanceTester performanceTester = new PerformanceTester();

 @Test
 @Timeout(value = 100, unit = TimeUnit.MILLISECONDS)
 void taskShouldCompleteWithin100MillisecondsAnnotation() {
     performanceTester.performTask();
 }
 
 @Test
 void taskShouldCompleteWithin100MillisecondsAssertion() {
     assertTimeout(Duration.ofMillis(100), () -> {
         performanceTester.performTask();
     });
 }

 @Test
 void taskShouldFailIfTimeoutIsTooShort() {
     assertTimeoutPreemptively(Duration.ofMillis(20), () -> {
         performanceTester.performTask();
     });
 }
}
