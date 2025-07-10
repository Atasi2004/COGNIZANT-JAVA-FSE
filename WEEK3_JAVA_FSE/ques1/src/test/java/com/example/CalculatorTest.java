package com.example;

import org.junit.Test;
import static org.junit.Assert.*;

public class CalculatorTest {

    @Test
    public void testAdd() {

        Calculator calculator = new Calculator();
        int a = 5;
        int b = 10;
        int expectedResult = 15;

        int actualResult = calculator.add(a, b);

        assertEquals("5 + 10 should equal 15", expectedResult, actualResult);
    }

    @Test
    public void testSubtract() {

        Calculator calculator = new Calculator();
        int expected = 5;

        int actual = calculator.subtract(10, 5);

        assertEquals("10 - 5 should equal 5", expected, actual);
    }

    @Test
    public void testDivide_Success() {

        Calculator calculator = new Calculator();
        double expected = 2.5;

        double actual = calculator.divide(5, 2);

        assertEquals("5 / 2 should equal 2.5", expected, actual, 0.0001);
    }

    @Test(expected = IllegalArgumentException.class)
    public void testDivide_ByZero() {

        Calculator calculator = new Calculator();

        calculator.divide(10, 0);
    }
}