package com.oultoncollege.model;

import java.sql.Timestamp;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

/**
 * Appointment.java Stores data about a single Appointment.
 *
 * @author bcop
 */
@Entity
public class Appointment {

    @Id
    @GeneratedValue(strategy = GenerationType.TABLE)
    private int appointmentID;
    private String title;
    private String description;
    private String location;
    private Timestamp startTime;
    private Timestamp endTime;
    private int studentCount;
    private int proctorID;
    private int courseID;
    private int appointmentTypeID;

    public Appointment() {
        // TODO Auto-generated constructor stub - required for JPA mappings
    }

    public Appointment(int appointmentID, Timestamp startTime, Timestamp endTime, String title, String description, String location, int studentCount, int proctorID, int courseID, int appointmentTypeID) {
        setAppointmentID(appointmentID);
        setStartTime(startTime);
        setEndTime(endTime);
        setTitle(title);
        setDescription(description);
        setLocation(location);
        setStudentCount(studentCount);
        setProctorID(proctorID);
        setCourseID(courseID);
        setAppointmentTypeID(appointmentTypeID);
    }

    public int getAppointmentID() {
        return appointmentID;
    }

    public void setAppointmentID(int appointmentID) {
        this.appointmentID = appointmentID;
    }

    public Timestamp getStartTime() {
        return startTime;
    }

    public void setStartTime(Timestamp startTime) {
        this.startTime = startTime;
    }

    public Timestamp getEndTime() {
        return endTime;
    }

    public void setEndTime(Timestamp endTime) {
        this.endTime = endTime;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public int getStudentCount() {
        return studentCount;
    }

    public void setStudentCount(int studentCount) {
        this.studentCount = studentCount;
    }

    public int getProctorID() {
        return proctorID;
    }

    public void setProctorID(int proctorID) {
        this.proctorID = proctorID;
    }

    public int getCourseID() {
        return courseID;
    }

    public void setCourseID(int courseID) {
        this.courseID = courseID;
    }

    public int getAppointmentTypeID() {
        return appointmentTypeID;
    }

    public void setAppointmentTypeID(int appointmentTypeID) {
        this.appointmentTypeID = appointmentTypeID;
    }

}
