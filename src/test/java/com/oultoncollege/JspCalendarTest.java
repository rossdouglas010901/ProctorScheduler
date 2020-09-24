package com.oultoncollege;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;


/**
 * Main tests for the Calendar.
 *
 * @author bcopeland
 */
class JspCalendarTest {

    //instance of JspCalendar
    private JspCalendar calendar = new JspCalendar();

    @Test
    void testGetYear() {
        assertEquals(2020, calendar.getYear());
    }

    @Test
    void testGetMonth() {
        assertEquals("January", calendar.getMonth());
    }

    @Test
    void testGetDay() {
        assertEquals("Wednesday", calendar.getDay());
    }

    @Test
    void testGetMonthInt() {
        assertEquals(1, calendar.getMonthInt());
    }

    @Test
    void testGetDate() {
        assertEquals("15/01/20 16:52:20", calendar.getDate());
    }

    @Test
    void testGetCurrentDate() {
        assertEquals("01/15", calendar.getCurrentDate());
    }

    @Test
    void testGetNextDate() {
        assertEquals("15", calendar.getNextDate());
    }

    @Test
    void testGetPrevDate() {
        assertEquals("14", calendar.getPrevDate());
    }

    @Test
    void testGetTime() {
        assertEquals("16:58:59", calendar.getTime());
    }

    @Test
    void testGetDayOfMonth() {
        assertEquals(15, calendar.getDayOfMonth());
    }

    @Test
    void testGetDayOfYear() {
        assertEquals(15, calendar.getDayOfYear());
    }

    @Test
    void testGetWeekOfYear() {
        assertEquals(2, calendar.getWeekOfYear());
    }

    @Test
    void testGetWeekOfMonth() {
        assertEquals(2, calendar.getWeekOfMonth());
    }

    @Test
    void testGetDayOfWeek() {
        assertEquals(15, calendar.getDayOfWeek());
    }

    @Test
    void testGetHour() {
        assertEquals(1, calendar.getHour());
    }

    @Test
    void testGetMinute() {
        assertEquals(06, calendar.getMinute());
    }

    @Test
    void testGetSecond() {
        assertEquals(10, calendar.getSecond());
    }

    @Test
    void testGetEra() {
        assertEquals(21, calendar.getEra());
    }

    @Test
    void testGetUSTimeZone() {
        assertEquals("Alaska", calendar.getUSTimeZone());
    }

    @Test
    void testGetZoneOffset() {
        assertEquals(60 * 60 * 1000, calendar.getZoneOffset());
    }

    @Test
    void testGetDSTOffset() {
        assertEquals(60 * 60 * 1000, calendar.getDSTOffset());
    }

    @Test
    void testGetAMPM() {
        assertEquals(5, calendar.getAMPM());
    }

}
