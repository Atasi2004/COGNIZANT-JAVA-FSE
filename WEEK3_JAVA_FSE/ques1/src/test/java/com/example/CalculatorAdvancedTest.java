package com.example;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import static org.junit.Assert.*;

public class CalculatorAdvancedTest {

    private Calculator calculator;

    @Before
    public void setUp() {
        System.out.println("Setting up a new Calculator instance...");
        calculator = new Calculator();
    }

    @After
    public void tearDown() {
        System.out.println("Tearing down the Calculator instance.");
        calculator = null;
    }

    @Test
    public void testAdd_WithAAA_Pattern() {
        System.out.println("Running testAdd...");
        int a = 15;
        int b = 20;
        int expectedResult = 35;

        int actualResult = calculator.add(a, b);

        assertEquals("15 + 20 should equal 35", expectedResult, actualResult);
    }

    @Test
    public void testSubtract_WithAAA_Pattern() {
        System.out.println("Running testSubtract...");

        int a = 25;
        int b = 20;
        int expectedResult = 5;

        int actualResult = calculator.subtract(a, b);

        assertEquals("25 - 20 should equal 5", expectedResult, actualResult);
    }

    @Test(expected = IllegalArgumentException.class)
    public void testDivide_ByZero_WithAAA_Pattern() {
        System.out.println("Running testDivide by zero...");

        int a = 10;
        int b = 0;

        calculator.divide(a, b);

    }
}