package com.oultoncollege.db;

import java.net.URISyntaxException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import com.oultoncollege.db.DatabaseConnection;
import com.oultoncollege.model.User;

/**
 * UserDAO.java User Manager (Data Access Object).
 *
 * @author Anton Chartovich
 * @author Liu Youfeng
 * @author bcopeland
 */
public class UserDAO {

    private Connection conn;
    private PreparedStatement stmt;
    private String sql = "";

    public UserDAO(Connection connection) {
        this.conn = connection;
    }

    /**
     * Add "salt" to shaker for this User (secondary step in CREATE User).
     */
    public int addSalt(User user, String salt) throws ClassNotFoundException, SQLException {
        sql = "INSERT INTO shaker (UID, Salt) VALUES (?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            System.out.println("trying to store secure salt");
            ps.setInt(1, user.getUserID());
            System.out.println("UID :" + user.getUserID());
            ps.setString(2, salt);

            ps.executeUpdate();

            conn.close();
            ps.close();

            return 1;
        } catch (SQLException ex) {
            System.err.println(ex);
        }
        return 0;
    }
    
    /**
     * Edit "salt" in shaker for this User (secondary step in UPDATE User).
     */
    public int updateSalt(User user, String salt) throws ClassNotFoundException, SQLException {
        sql = "UPDATE shaker SET Salt=? WHERE UID=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            System.out.println("trying to store secure salt");
            ps.setString(1, salt);
            ps.setInt(2, user.getUserID());
            System.out.println("UID :" + user.getUserID());

            ps.executeUpdate();

            conn.close();
            ps.close();

            return 1;
        } catch (SQLException ex) {
            System.err.println(ex);
        }
        return 0;
    }

    /**
     * CREATE User
     */
    public int createUser(User user) throws ClassNotFoundException, SQLException {

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            System.out.println("trying to create a user");
            int rows = 0;
            String sql = "INSERT INTO users (UserID, Email, Password, FirstName, LastName, PhoneNumber, PhoneExt, AccountTypeID) VALUES (?,?,?,?,?,?,?,?)";
            System.out.println("another debug check");
            ps.setInt(1, user.getUserID());
            System.out.println("users :" + user.getUserID());
            ps.setString(2, user.getPassword());
            System.out.println("users :" + user.getPassword());
            ps.setString(2, user.getEmail());
            System.out.println("users :" + user.getEmail());
            ps.setString(3, user.getFirstName());
            System.out.println("users :" + user.getFirstName());
            ps.setString(4, user.getLastName());
            System.out.println("users :" + user.getLastName());
            ps.setString(5, user.getPhoneNumber());
            System.out.println("users :" + user.getPhoneNumber());
            ps.setString(6, user.getPhoneExt());
            System.out.println("users :" + user.getPhoneExt());
            ps.setInt(7, user.getAccountTypeID());
            System.out.println("users :" + user.getAccountTypeID());

            rows = ps.executeUpdate();

            conn.close();
            return rows;
        } catch (SQLException ex) {
            System.err.println(ex);
        }
        return 0;
    }

    public void addUser(User user) throws ClassNotFoundException, SQLException {
        try {
            sql = "INSERT INTO users(Email,Password,FirstName,LastName,AccountTypeID) VALUES (?,?,?,?,?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, user.getEmail());
            stmt.setString(2, user.getPassword());
            stmt.setString(3, user.getFirstName());
            stmt.setString(4, user.getLastName());
            stmt.setInt(5, user.getAccountTypeID());
            stmt.executeUpdate();
            System.out.println("Added user info for user with ID: " + stmt.getResultSet().getRow());
            stmt.close();
            conn.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    // read user
    public List<User> getUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int userID = rs.getInt("UserID");
                String email = rs.getString("Email");
                String password = rs.getString("Password");
                String firstName = rs.getString("FirstName");
                String lastName = rs.getString("LastName");
                String phoneNumber = rs.getString("PhoneNumber");
                String phoneExt = rs.getString("PhoneExt");
                int accountTypeID = rs.getInt("AccountTypeID");
                User p = new User(userID, email, password, firstName, lastName, phoneNumber, phoneExt, accountTypeID);
                users.add(p);
            }
            rs.close();
            ps.close();
        } catch (SQLException ex) {
            System.err.println(ex);
        }
        return users;
    }

    public User getUserByID(int id) {
        User user = null;
        String sql = "SELECT * FROM users WHERE UserID = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int userID = rs.getInt("UserID");
                String emailFromDB = rs.getString("Email");
                String password = rs.getString("Password");
                String firstName = rs.getString("FirstName");
                String lastName = rs.getString("LastName");
                String phoneNumber = rs.getString("PhoneNumber");
                String phoneExt = rs.getString("PhoneExt");
                int accountTypeID = rs.getInt("AccountTypeID");
                user = new User(userID, emailFromDB, password, firstName, lastName, phoneNumber, phoneExt, accountTypeID);
            }
            rs.close();
            ps.close();
        } catch (SQLException ex) {
            System.err.println(ex);
        }
        return user;
    }

    public User getUserByEmail(String email) {
        User user = null;
        String sql = "SELECT * FROM users WHERE Email = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int userID = rs.getInt("UserID");
                String emailFromDB = rs.getString("Email");
                String password = rs.getString("Password");
                String firstName = rs.getString("FirstName");
                String lastName = rs.getString("LastName");
                String phoneNumber = rs.getString("PhoneNumber");
                String phoneExt = rs.getString("PhoneExt");
                int accountTypeID = rs.getInt("AccountTypeID");
                user = new User(userID, emailFromDB, password, firstName, lastName, phoneNumber, phoneExt, accountTypeID);
            }
            rs.close();
            ps.close();
        } catch (SQLException ex) {
            System.err.println(ex);
        }
        return user;
    }

    // update user 
    public int updateUser(User user) {
        int rows = 0;
        String sql = "UPDATE users SET email = ?, Password = ?, FirstName = ?, LastName = ?, PhoneNumber = ?, PhoneExt = ?, AccountTypeID = ? WHERE UserID = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getEmail());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getFirstName());
            ps.setString(4, user.getLastName());
            ps.setString(5, user.getPhoneNumber());
            ps.setString(6, user.getPhoneExt());
            ps.setInt(7, user.getAccountTypeID());
            ps.setInt(8, user.getUserID()); //1st column, but falls last in UPDATE query
            rows = ps.executeUpdate();

            ps.close();
        } catch (SQLException ex) {
            System.err.println(ex);
        }
        return rows;
    }

    // Delete user
    public int deleteUser(User user) {
        int rows = 0;
        String sql = "DELETE FROM users WHERE UserID = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, user.getUserID());
            rows = ps.executeUpdate();
            ps.close();
        } catch (SQLException ex) {
            System.err.println(ex);
        }
        return rows;
    }

}
