package com.oultoncollege.util;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * MD5Util.java
 *  Used to create MD5 Hash's of various strings, for instance a Gravatar email.
 * 
 * @author Gravatar Java SDK
 * @author bcopeland
 */
public class MD5Util {

    /**
     * Calculates the Hexadecimal value of a given byte array.
     * @param array
     * @return 
     */
    public static String hex(byte[] array) {
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < array.length; ++i) {
            sb.append(Integer.toHexString((array[i] & 0xFF) | 0x100).substring(1, 3));
        }
        return sb.toString();
    }

    /**
     * Calculates the Hexadecimal MD5 Hash of a text input.
     * @param message
     * @return 
     */
    public static String md5Hex(String message) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            return hex(md.digest(message.getBytes("CP1252")));
        } catch (NoSuchAlgorithmException | UnsupportedEncodingException ex) {
            ex.printStackTrace();
        }
        return null;
    }
}
