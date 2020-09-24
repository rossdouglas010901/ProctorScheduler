package com.oultoncollege.model;

import com.oultoncollege.util.PreventXSS;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 
 * @author bcop
 */
public class Entry {

    private final int CONVERT_TO_MILITARY_TIME = 12;
    String hour;
    String description;

    
    public Entry(String hour) {
        this.hour = hour;
        this.description = "";
    }

    
    public String getHour() {
        return PreventXSS.filter(this.hour);
    }

    public int getHourValue() {
        String hourAmPm = getHour();
        int hour = 0;
        try {
            String regEx = "^([0-9]+)";
            Pattern pattern = Pattern.compile(regEx);
            Matcher matcher = pattern.matcher(hourAmPm);
            if (matcher.find()) {
                if (this.hour.toLowerCase().contains("pm")) {
                    hour = Integer.parseInt(matcher.group(1)) + CONVERT_TO_MILITARY_TIME;
                } else {
                    hour = Integer.parseInt(matcher.group(1));
                }
            }
            return hour;
        } catch (NumberFormatException nEx) {
            nEx.printStackTrace();
        }
        return -1;
    }

    public String getColor() {
        if (null == description || description.isEmpty()) {
            return "#000000";
        }
        return "#e55039";
    }

    public String getDescription() {
        if (null == description || description.isEmpty()) {
            return "None";
        }
        return this.description;
    }

    public void setDescription(String desc) {
        this.description = PreventXSS.filter(desc);
    }

}
