package com.oultoncollege.db;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.fail;

import java.net.URISyntaxException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Ignore;
import org.junit.Test;

import com.oultoncollege.model.User;

/**
 *
 * @author bcop
 */
public class DatabaseConnectionTest {

	private DatabaseConnection db = new DatabaseConnection();
	
    public DatabaseConnectionTest() {
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
     * Test of getConnection method, of class DatabaseConnection.
     */
    @Test
    @Ignore
    public void testGetConnection() throws Exception {
        System.out.println("getConnection");
        Connection expResult = null;
        Connection result = db.getConnection();
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of main method, of class DatabaseConnection.
     */
    public static void main(String[] args) {
        DatabaseConnection dc = new DatabaseConnection();
        try {
            Connection connection = dc.getConnection();
            UserDAO userManager = new UserDAO(connection);
            List<User> users = userManager.getUsers();
            System.out.println(users.get(1).getFirstName());
        } catch (ClassNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (SQLException | URISyntaxException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

}
