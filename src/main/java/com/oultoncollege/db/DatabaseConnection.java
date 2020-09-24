package com.oultoncollege.db;

import java.net.URI;
import java.net.URISyntaxException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import static com.oultoncollege.db.Settings.*;

/**
 * DatabaseConnection.java Helper/utility class for initiating and accessing Database connections.
 *
 * @author Anton Chartovich
 * @author Liu Youfeng
 * @author bcopeland
 */
public class DatabaseConnection {

    public Connection getConnection() throws SQLException, ClassNotFoundException, URISyntaxException {
        Class.forName(DB_DRIVER);
        URI dbUri = new URI(Settings.dataSource());

        String dbUser = dbUri.getUserInfo().split(":")[0];
        String dbPassword = dbUri.getUserInfo().split(":")[1];
        String dbURL = "jdbc:mysql://" + dbUri.getHost() + dbUri.getPath();

        Connection dbConnection = DriverManager.getConnection(dbURL, dbUser, dbPassword);
        return dbConnection;
    }

    public static void cleanupConnection(Connection dbConnection) {
        try {
            if (!dbConnection.isClosed()) {
                dbConnection.close();
            }
        } catch (SQLException sqlEx) {
            System.err.println("Error trying to close DB Connection!");
            sqlEx.printStackTrace(); //leave full trace in this case for now as we need to ensure no memory leaks
        }
    }

}
