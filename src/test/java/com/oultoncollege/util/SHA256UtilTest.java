package com.oultoncollege.util;

import java.security.NoSuchAlgorithmException;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author bcop
 */
public class SHA256UtilTest {

    private static SHA256Util hash;

    public SHA256UtilTest() {
        hash = new SHA256Util();
    }

    @Before
    public void setUp() {
        hash = new SHA256Util();
    }

    @After
    public void tearDown() {
        hash = null;
    }

    /**
     * Test of getSHA256 method, of class SHA256Util.
     */
    @Test
    public void testGetSHA256() {
        System.out.println("getSHA256");
        String passwordToHash = "hello";
        byte[] salt = "abcdef".getBytes();
        String expResult = "da519bb78a3ac7f31ad576871b301eb18bf346ad96580111ad13b2e3fd9bd83a";
        String result = SHA256Util.getSHA256(passwordToHash, salt);
        assertEquals(expResult, result);
    }

    /**
     * Test of getSalt method, of class SHA256Util.
     */
    @Test
    public void testGetSalt() throws Exception {
        System.out.println("getSalt");
        String result = SHA256Util.getSalt();
        assertNotNull(result);
        assertTrue(result.length() >= 12);
    }

    /*
     * quick-run for auto-generating hashes of specific Test strings
     */
    public static void main(String[] args) throws NoSuchAlgorithmException {
        String passwordToHash = "I$-1t@!Gu^nUf_P4z5W0rD"; //this would be the value passed in by the User
        byte[] salt = hash.getSalt().getBytes(); //NOTE: you'll need to store this securely, but separately from the "users" table using "m:n" mapping table

        String securePassword = hash.getSHA256(passwordToHash, salt);

        System.out.println(securePassword);
    }

}
