package com.oultoncollege.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

/**
 *
 * @author bcop
 */
public class ServiceCaller {

    /**
     * makeRequest Basic raw URL request to the provided endpoint.
     *
     * @param endpoint String representing the URL to make a GET request to and read data from
     * @return String response from calling the URL
     */
    public static String makeRequest(String endpoint) throws MalformedURLException, IOException {
        HttpURLConnection uc = null;
        URL url = new URL(endpoint);
        uc = (HttpURLConnection) url.openConnection();
        uc.setRequestMethod("GET");
        StringBuffer response = new StringBuffer();
        int responseCode = uc.getResponseCode();
        //if status of request is HTTP/1.0 200 OK
        if (responseCode == 200) {
            BufferedReader in = new BufferedReader(new InputStreamReader(uc.getInputStream()));
            String inputLine;
            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();
        }
        return response.toString();
    }
}
