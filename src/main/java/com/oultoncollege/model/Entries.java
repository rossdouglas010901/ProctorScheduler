package com.oultoncollege.model;

import java.util.Hashtable;
import com.oultoncollege.util.DateTimeConverter;

/**
 * Entries.java Creates appointment timeslot entries in the Daily View.
 *
 * @author Anton Chartovich
 * @author bcopeland
 */
public class Entries {

    private Hashtable<String, Entry> entries;

//all-day 24 timeslots
//    private static final String[] AVAILABLE_TIMESLOTS = {"12am","1am","2am","3am","4am","5am","6am","7am","8am","9am","10am","11am","12pm","1pm","2pm","3pm","4pm","5pm","6pm","7pm","8pm","9pm","10pm","11pm"};
    private static final String[] AVAILABLE_TIMESLOTS = {"8am", "9am", "10am", "11am", "12pm", "1pm", "2pm", "3pm", "4pm", "5pm", "6pm", "7pm", "8pm", "9pm"};

    public Entries() {
        entries = new Hashtable<String, Entry>(getRows());
        for (int i = 0; i < getRows(); i++) {
            entries.put(AVAILABLE_TIMESLOTS[i], new Entry(AVAILABLE_TIMESLOTS[i]));
        }
    }

    public int getRows() {
        return AVAILABLE_TIMESLOTS.length;
    }

    public Entry getEntry(int timeslot) {
        return this.entries.get(AVAILABLE_TIMESLOTS[timeslot]);
    }

    public int getTimeslot(String timeInput) {
        for (int i = 0; i < getRows(); i++) {
            if (timeInput.equals(AVAILABLE_TIMESLOTS[i])) {
                return i;
            }
        }
        return -1;
    }

    /**
     * Adds a description to a specific timeslot (and changes the color).
     *
     * @param timeInput
     * @param description
     */
    public void addAppointmentTimeslot(String timeInput, String description) {
        String formattedTime = DateTimeConverter.formattedTime(timeInput);
        int timeslot = getTimeslot(formattedTime);
        if (timeslot >= 0) {
            entries.get(AVAILABLE_TIMESLOTS[timeslot]).setDescription(description);
        }
    }

}
