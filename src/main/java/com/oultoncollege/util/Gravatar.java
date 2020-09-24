package com.oultoncollege.util;

import java.io.IOException;


/**
 * Gravatar.java
 * Checks whether or not a valid Gravatar profile and thumbnail image exists of the format:
 *   https://www.gravatar.com/avatar/<MD5_HASH>
 * FOR EXAMPLE:
 *   https://en.gravatar.com/205e460b479e2e5b48aec07710c08d50.json
 * With a corresponding profile image of:
 *   https://secure.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50
 * 
 * @author bcopeland
 */
public class Gravatar {
   
    public static boolean checkProfileExists(String path) {
        String data = "";
        try { 
            data = ServiceCaller.makeRequest(path);
        } catch(IOException ex) {
            ex.printStackTrace();
        }
        if (data.contains("User not found")) {
            return false;
        } else {
            return true;
        }
    }

    
}
