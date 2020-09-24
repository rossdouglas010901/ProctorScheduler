package com.oultoncollege.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import com.oultoncollege.model.Appointment;

/**
 * AppointmentDAO.java Appointment Manager (Data Access Object).
 *
 * @author Anton Chartovich
 * @author Liu Youfeng
 * @author bcopeland
 */
public class AppointmentDAO {

    private Connection connection;
    private String sql = "";

    public AppointmentDAO(Connection connection) {
        this.connection = connection;
    }

    /**
     * CREATE Appointment
     */
    public int createAppointment(Appointment appointment) {
        System.out.println("Create a new Appointment");
        int rows = 0;
        sql = "INSERT INTO appointment (StartTime, EndTime, Title, Description, Location, StudentCount, ProctorID, CourseID, AppointmentTypeID) VALUES (?,?,?,?,?,?,?,?,?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setTimestamp(1, appointment.getStartTime());
            System.out.println("Appointment Start:" + appointment.getStartTime());
            ps.setTimestamp(2, appointment.getEndTime());
            System.out.println("Appointment End:" + appointment.getEndTime());
            ps.setString(3, appointment.getTitle());
            System.out.println("Appointment Title:" + appointment.getTitle());
            ps.setString(4, appointment.getDescription());
            System.out.println("Appointment Desc:" + appointment.getDescription());
            ps.setString(5, appointment.getLocation());
            System.out.println("Appointment Location:" + appointment.getLocation());
            ps.setInt(6, appointment.getStudentCount());
            System.out.println("Appointment Students:" + appointment.getStudentCount());
            ps.setInt(7, appointment.getProctorID());
            System.out.println("Appointment Proctor:" + appointment.getProctorID());
            ps.setInt(8, appointment.getCourseID());
            System.out.println("Appointment Course:" + appointment.getCourseID());
            ps.setInt(9, appointment.getAppointmentTypeID());
            System.out.println("Appointment Type (ID):" + appointment.getAppointmentTypeID());

            rows = ps.executeUpdate();
            ps.close();
        } catch (SQLException sqlEx) {
            System.err.println(sqlEx);
        }
        return rows;
    }

    /**
     * Retrieve all Appointments currently stored in DB.
     *
     * @return
     */
    public List<Appointment> getAppointments() {
        List<Appointment> appointments = new ArrayList<>();
        sql = "SELECT * FROM appointment";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int appointmentID = rs.getInt("AppointmentID");
                String title = rs.getString("Title");
                String description = rs.getString("Description");
                String location = rs.getString("Location");
                Timestamp startTime = rs.getTimestamp("StartTime");
                Timestamp endTime = rs.getTimestamp("EndTime");
                int studentCount = rs.getInt("StudentCount");
                int proctorID = rs.getInt("ProctorID");
                int courseID = rs.getInt("CourseID");
                int appointmentTypeID = rs.getInt("AppointmentTypeID");
                Appointment appt = new Appointment(appointmentID, startTime, endTime, title, description, location, studentCount, proctorID, courseID, appointmentTypeID);
                appointments.add(appt);
            }
            rs.close();
            ps.close();
        } catch (SQLException ex) {
            System.err.println(ex);
        }
        return appointments;
    }

    /**
     * Retrieve the day's (or month's) Appointments by Date (start/end time range).
     *
     * @param start
     * @param end
     * @return
     */
    public List<Appointment> getAppointmentsByDate(Timestamp start, Timestamp end) {
        List<Appointment> appointments = new ArrayList<>();
        sql = "SELECT * FROM appointment WHERE StartTime >= ? AND EndTime <= ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setTimestamp(1, start);
            ps.setTimestamp(2, end);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int appointmentID = rs.getInt("AppointmentID");
                Timestamp startTime = rs.getTimestamp("StartTime");
                Timestamp endTime = rs.getTimestamp("EndTime");
                String title = rs.getString("Title");
                String description = rs.getString("Description");
                String location = rs.getString("Location");
                int studentCount = rs.getInt("StudentCount");
                int proctorID = rs.getInt("ProctorID");
                int courseID = rs.getInt("CourseID");
                int appointmentTypeID = rs.getInt("AppointmentTypeID");
                Appointment appt = new Appointment(appointmentID, startTime, endTime, title, description, location, studentCount, proctorID, courseID, appointmentTypeID);
                appointments.add(appt);
            }
            rs.close();
            ps.close();
        } catch (SQLException ex) {
            System.err.println(ex);
        }
        return appointments;
    }
    
    public List<Appointment> getAppointmentsByUser(int userID) {
        List<Appointment> appointments = new ArrayList<>();
        sql = "SELECT * FROM appointment WHERE ProctorID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
        	ps.setInt(1, userID);
        	ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int appointmentID = rs.getInt("AppointmentID");
                Timestamp startTime = rs.getTimestamp("StartTime");
                Timestamp endTime = rs.getTimestamp("EndTime");
                String title = rs.getString("Title");
                String description = rs.getString("Description");
                String location = rs.getString("Location");
                int studentCount = rs.getInt("StudentCount");
                int proctorID = rs.getInt("ProctorID");
                int courseID = rs.getInt("CourseID");
                int appointmentTypeID = rs.getInt("AppointmentTypeID");
                Appointment appt = new Appointment(appointmentID, startTime, endTime, title, description, location, studentCount, proctorID, courseID, appointmentTypeID);
                appointments.add(appt);
            }
            rs.close();
            ps.close();
        } catch (SQLException ex) {
            System.err.println(ex);
        }
        return appointments;
    }

    /**
     * Gets a specific Appointment by its ID.
     *
     * @param apptID
     * @return
     */
    public Appointment getAppointmentByID(int apptID) {
        Appointment appointment = null;
        sql = "SELECT * FROM appointment WHERE AppointmentID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, apptID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int appointmentID = rs.getInt("AppointmentID");
                Timestamp startTime = rs.getTimestamp("StartTime");
                Timestamp endTime = rs.getTimestamp("EndTime");
                String title = rs.getString("Title");
                String description = rs.getString("Description");
                String location = rs.getString("Location");
                int studentCount = rs.getInt("StudentCount");
                int proctorID = rs.getInt("ProctorID");
                int courseID = rs.getInt("CourseID");
                int appointmentTypeID = rs.getInt("AppointmentTypeID");
                appointment = new Appointment(appointmentID, startTime, endTime, title, description, location, studentCount, proctorID, courseID, appointmentTypeID);
            }
            rs.close();
            ps.close();
        } catch (SQLException ex) {
            System.err.println(ex);
        }
        return appointment;
    }

    /**
     * Update appointment.
     *
     * @param appointment
     * @return
     */
    public int updateAppointment(Appointment appointment) {
        int rows = 0;
        sql = "UPDATE appointment SET StartTime = ?, EndTime = ?, Title = ?, Description = ?, Location = ?, StudentCount = ?, ProctorID = ?, CourseID = ?, AppointmentTypeID = ? WHERE AppointmentID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setTimestamp(1, appointment.getStartTime());
            ps.setTimestamp(2, appointment.getEndTime());
            ps.setString(3, appointment.getTitle());
            ps.setString(4, appointment.getDescription());
            ps.setString(5, appointment.getLocation());
            ps.setInt(6, appointment.getStudentCount());
            ps.setInt(7, appointment.getProctorID());
            ps.setInt(8, appointment.getCourseID());
            ps.setInt(9, appointment.getAppointmentTypeID());
            ps.setInt(10, appointment.getAppointmentID());
            rows = ps.executeUpdate();
            ps.close();
        } catch (SQLException sqlEx) {
            System.err.println(sqlEx);
        }
        return rows;
    }

    /**
     * Delete appointment.
     *
     * @param appointment
     * @return
     */
    public int deleteAppointment(Appointment appointment) {
        int rows = 0;
        sql = "DELETE FROM appointment WHERE AppointmentID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, appointment.getAppointmentID());
            rows = ps.executeUpdate();
            ps.close();
        } catch (SQLException sqlEx) {
            System.err.println(sqlEx);
        }
        return rows;
    }

}
