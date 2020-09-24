package com.oultoncollege.util;

import java.sql.Date;
import java.sql.Timestamp;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;
import org.junit.Ignore;
import static org.junit.jupiter.api.Assertions.assertEquals;

/**
 *
 * @author bcopeland
 */
public class DateTimeConverterTest {
    
    public DateTimeConverterTest() {
    }
    
    @BeforeClass
    public static void setUpClass() {
    }
    
    @AfterClass
    public static void tearDownClass() {
    }
    
    @Before
    public void setUp() {
    }
    
    @After
    public void tearDown() {
    }

    /**
     * Test of padDateTime method, of class DateTimeConverter.
     */
    @Test
    public void testPadDateTime_int() {
        System.out.println("padDateTime");
        int numericalDateTime = 1;
        String expResult = "01";
        String result = DateTimeConverter.padTime(numericalDateTime);
        assertEquals(expResult, result);
    }

    /**
     * Test of padDateTime method, of class DateTimeConverter.
     */
    @Test
    public void testPadDateTime_String() {
        System.out.println("padDateTime");
        String dateTimeText = "1";
        String expResult = "01";
        String result = DateTimeConverter.padTime(dateTimeText);
        assertEquals(expResult, result);
    }

    /**
     * Test of formattedTime method, of class DateTimeConverter.
     */
    @Test
    @Ignore
    public void testFormattedTime() {
        System.out.println("formattedTime");
        String timeInput = "";
        String expResult = "";
        String result = DateTimeConverter.formattedTime(timeInput);
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of convertDateTextToSQL method, of class DateTimeConverter.
     */
    @Test
    @Ignore
    public void testConvertDateTextToSQL() throws Exception {
        System.out.println("convertDateTextToSQL");
        String dateText = "";
        Date expResult = null;
        Date result = DateTimeConverter.convertDateTextToSQL(dateText);
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of convertDateTimeTextToSQL method, of class DateTimeConverter.
     */
    @Test
    @Ignore
    public void testConvertDateTimeTextToSQL() {
        System.out.println("convertDateTimeTextToSQL");
        String dateTimeText = "";
        Timestamp expResult = null;
        Timestamp result = DateTimeConverter.convertDateTimeTextToSQL(dateTimeText);
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }
    
}
