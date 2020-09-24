package com.oultoncollege.util;

import static java.time.temporal.TemporalAdjusters.firstDayOfMonth;
import static java.time.temporal.TemporalAdjusters.lastDayOfMonth;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;

/**
 * DateTimeConverter.java
 *	Utilities to assist in date and time format conversions.
 * @author bcop
 */
public class DateTimeConverter {

    private static final int MINUTES_IN_HOUR = 60;
    
    /**
     * Places a leading zero in front of any single-digit number
     * @param numericalDateTime
     * @return 
     */
    public static String padTime(int numericalDateTime) {
        if (numericalDateTime < 10) {
            return "0" + numericalDateTime;
        } else {
            return "" + numericalDateTime;
        }
    }

    /**
     * Places a leading zero in front of any single-digit numerical text
     * @param numericalDateTime
     * @return 
     */
    public static String padTime(String numericalDateTime) {
        try {
            if (Integer.parseInt(numericalDateTime) < 10) {
                return "0" + numericalDateTime;
            } else {
                return "" + numericalDateTime;
            }
        } catch (NumberFormatException nEx) {
            nEx.printStackTrace();
        }
        return null;
    }
    
    /**
     * Pads any single-digit numerical text and expands it to a corresponding "on the hour" time representation
     * @param numericalDateTime
     * @return
     */
    public static String padExpandTime(String numericalDateTime) {
    	if (numericalDateTime.length() < 5) {
    		return padTime(numericalDateTime) + ":00";
    	} else {
    		return padTime(numericalDateTime);
		}
    }
    
    /**
     * Formats time from "8:00 am" or "10:00 pm"  formats to abbreviated "8am" or "10pm"
     * @param timeInput
     * @return 
     */
    public static String formattedTime(String timeInput) {
        int hour = 0;
        String amPm = "";
        try {
            hour = Integer.parseInt(timeInput.split(":")[0]);
            if (timeInput.toLowerCase().contains("pm") || hour > 12) {
                hour -= 12;
                amPm = "pm";
            } else {
                amPm = "am";
            }
        } catch (NumberFormatException numEx) {
            numEx.printStackTrace();
        }
        return "" + hour + amPm;
    }
    
    /**
     * Calculates a "zero-based" Timeslot value from a Time String of the format HH:MM:ss
     *  (NOTE: assumes use of 24-hour time clock for all passed in values).
     * 
     * @param dayStartTime 
     * @param time
     * @return 
     */
    public static int calculateTimeslot(String dayStartTime, String time) {
        int dayStartHour = Integer.parseInt(dayStartTime.split(":")[0]);
        int dayStartMinute = Integer.parseInt(dayStartTime.split(":")[1]);
        int timeHour = Integer.parseInt(time.split(":")[0]);        
        int timeMinute = Integer.parseInt(time.split(":")[1]);
        int currentHourTimeslot = (timeHour - dayStartHour) * MINUTES_IN_HOUR;
        int currentMinuteTimeslot = timeMinute - dayStartMinute;
        return currentHourTimeslot + currentMinuteTimeslot;
    }
    
    /**
     * Converts SQL date text of the format "yyyy-mm-dd" to corresponding
     * HTML5 date input of the format "mm/dd/yyyy"
     * @param sqlDateText
     * @return
     */
    public static String convertSqlDateTextToHTML5(String sqlDateText) {
    	String[] date = sqlDateText.split("-");
		return date[1] + "/" + date[2] + "/" + date[0];
    }
    
    /**
     * Trims SQL time text of the format "HH:MM:SS.mm" to corresponding
     * HTML5 date input of the basic "HH:MM" 24-hour military time format.
     * @param sqlDateText
     * @return
     */
    public static String convertSqlTimeTextToMilitary(String sqlTimeText) {
    	String[] time = sqlTimeText.split(":");
		return time[0] + ":" + time[1];
    }
    
    /**
     * Converts time like "08:00:00.0" or "17:00:00.0" to "8:00 AM" or "5:00 PM"
     * @param timeInput
     * @return 
     */
    public static String convertSqlTimeTextToHTML5(String sqlTimeText) {
        int hour = 0;
        int minute = 0;
        String amPm = "";
        try {
            hour = Integer.parseInt(sqlTimeText.split(":")[0]);
            if (hour > 12) {
                hour -= 12;
                amPm = "PM";
            } else {
                amPm = "AM";
            }
            minute = Integer.parseInt(sqlTimeText.split(":")[1]);
        } catch (NumberFormatException numEx) {
            numEx.printStackTrace();
        }
        return hour + ":" + padTime(minute) + " " + amPm;
    }
    
    /**
     * Converts an SQL DateTime object to the corresponding DateTime textual representation
     * @param sqlTimestamp
     * @return
     */
    public static String convertTimestampToText(java.sql.Timestamp sqlTimestamp) {
        DateTimeFormatter formatter = DateTimeFormatter.ISO_LOCAL_DATE_TIME;
        String timestampAsString = formatter.format(sqlTimestamp.toLocalDateTime());
        String hourMinuteSecond = timestampAsString.split("T")[1];
        int hour = Integer.parseInt(hourMinuteSecond.split(":")[0]);
        int minute = Integer.parseInt(hourMinuteSecond.split(":")[1]);
        return padTime(hour) + ":" + padTime(minute);
    }
    
    /**
     * Processes a textual date and converts it to the corresponding SQL Date Object
     * @param dateText
     * @return
     * @throws ParseException 
     */
    public static java.sql.Date convertDateTextToSQL(String dateText) throws ParseException {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Date parsedDate = format.parse(dateText);
        return new java.sql.Date(parsedDate.getTime());
    }
    
    /**
     * Converts a DateTime textual representation to the corresponding SQL DateTime object
     * @param dateTimeText
     * @return 
     */
    public static java.sql.Timestamp convertDateTimeTextToSQL(String dateTimeText) {
        Timestamp dateTime = null;
        try {
            Date date = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").parse(dateTimeText);
            dateTime = new Timestamp(date.getTime());
        } catch(ParseException pEx) {
            pEx.printStackTrace();
        }
        return dateTime;
    }
    
    public static long getDuration(String start, String end) {
        String startTime = start.split(" ")[1];
        String endTime = end.split(" ")[1];
        SimpleDateFormat format = new SimpleDateFormat("HH:mm:ss");
        long duration = 0L;
        try {
            Date date1 = format.parse(startTime);
            Date date2 = format.parse(endTime);            
            duration = date2.getTime() - date1.getTime();
        } catch(ParseException pEx) {
            pEx.printStackTrace();
        }
        return duration;
    }
    
    /**
     * Get the first day of the month in which the passed date falls.
     * @param initialDate
     * @return 
     */
    public static LocalDate getMonthStart(LocalDate initialDate) {
    	return initialDate.with(firstDayOfMonth());
    }
    
    /**
     * Get the last day of the month in which the passed date falls.
     * @param initialDate
     * @return 
     */
    public static LocalDate getMonthEnd(LocalDate initialDate) {
    	return initialDate.with(lastDayOfMonth());
    }    
    
    /**
     * Check whether the start and end times are valid.
     * @param start
     * @param end
     * @return 
     */
    public static boolean validTimeslot(String start, String end) {
    	return (Integer.parseInt(start) < Integer.parseInt(end));
    }
}
