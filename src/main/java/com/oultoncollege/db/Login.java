package com.oultoncollege.db;

import java.net.URISyntaxException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import com.oultoncollege.model.User;
import com.oultoncollege.util.SHA256Util;

/**
 * Login.java Authenticates Users to the ProctorScheduler WebApp by performing a basic validation check. Initially just "GIVEN username AND password
 * WHEN username SAME AS usernameFromDB AND password SAME AS passwordFromDB THEN
 *
 * @author Liu Youfeng
 * @author bcopeland
 */
public class Login {

    private DatabaseConnection db = new DatabaseConnection();
    private Connection connection = null;
    private PreparedStatement checkCredentials = null;
    private ResultSet resultSet = null;

    public String authenticateUser(User user) throws ClassNotFoundException {
        String username = user.getEmail();
        String password = user.getPassword();
        String usernameDB = "";
        String passwordDB = "";
        int accountTypeID = 0;

        try {
            connection = db.getConnection();

            String sql = "SELECT s.Salt FROM users AS u LEFT JOIN shaker AS s ON u.UserID = s.UID WHERE u.Email=?";
            checkCredentials = connection.prepareStatement(sql);
            checkCredentials.setString(1, username);
            resultSet = checkCredentials.executeQuery();
            String salt = "";
            if (resultSet.next()) {
                salt = resultSet.getString("Salt");
            }
            String securePassword = SHA256Util.getSHA256(password, salt.getBytes());

            sql = "SELECT Email,Password,AccountTypeID FROM users WHERE Email = ? AND Password = ?";
            checkCredentials = connection.prepareStatement(sql);
            checkCredentials.setString(1, username);
            checkCredentials.setString(2, securePassword);

            resultSet = checkCredentials.executeQuery();
            if (resultSet.next()) {
                usernameDB = resultSet.getString("Email");
                passwordDB = resultSet.getString("Password");
                accountTypeID = resultSet.getInt("AccountTypeID");

//TODO: only for test purpose... need to actively load "account_type" table data here
                if (username.equals(usernameDB) && securePassword.equals(passwordDB) && accountTypeID == 1) {
                    return "admin";
                } else if (username.equals(usernameDB) && securePassword.equals(passwordDB) && (accountTypeID == 2 || accountTypeID == 3)) {
                    return "proctor";
                } else if (username.equals(usernameDB) && securePassword.equals(passwordDB) && accountTypeID == 4) {
                    return "student";
                } else {
                    return "invalid";
                }
            }
            db.cleanupConnection(connection);
        } catch (SQLException | URISyntaxException e) {
            e.printStackTrace();
        }
        return "Invalid user credentials";
    }

}
