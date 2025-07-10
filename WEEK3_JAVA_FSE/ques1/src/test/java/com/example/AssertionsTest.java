package com.example;

import org.junit.Test;
import static org.junit.Assert.*;

public class AssertionsTest {

    @Test
    public void testAssertions() {
        String str1 = new String("junit");
        String str2 = new String("junit");
        String str3 = null;
        String str4 = "junit";
        String str5 = "junit";

        int variable1 = 1;
        int variable2 = 2;

        int[] anArray1 = { 1, 2, 3 };
        int[] anArray2 = { 1, 2, 3 };

        assertEquals("str1 and str2 should be equal", str1, str2);

        assertTrue("variable1 should be less than variable2", variable1 < variable2);

        assertFalse("variable1 should not be greater than variable2", variable1 > variable2);

        assertNull("str3 should be null", str3);

        assertNotNull("str1 should not be null", str1);

        assertSame("str4 and str5 should refer to the same object", str4, str5);

        assertArrayEquals("The arrays should be equal", anArray1, anArray2);
    }
}