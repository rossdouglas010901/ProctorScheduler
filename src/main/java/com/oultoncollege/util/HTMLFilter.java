package com.oultoncollege.util;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;

/**
 * HTML filter utility.
 *
 * @author Craig R. McClanahan
 * @author Tim Tye
 */
public final class HTMLFilter {

    /**
     * Filter the specified message string for characters that are sensitive in HTML. This avoids potential attacks caused by including JavaScript
     * codes in the request URL that is often reported in error messages.
     *
     * @param message The message string to be filtered
     * @return the filtered version of the message
     */
    public static String filter(String message) {
        if (message == null) {
            return null;
        }
        char content[] = new char[message.length()];
        message.getChars(0, message.length(), content, 0);
        StringBuilder result = new StringBuilder(content.length + 50);
        for (int i = 0; i < content.length; i++) {
            switch (content[i]) {
                case '<':
                    result.append("&lt;");
                    break;
                case '>':
                    result.append("&gt;");
                    break;
                case '&':
                    result.append("&amp;");
                    break;
                case '"':
                    result.append("&quot;");
                    break;
                default:
                    result.append(content[i]);
            }
        }
        return result.toString();
    }
    
    public static String encodeURI(String value) throws UnsupportedEncodingException {
        return URLEncoder.encode(value, "UTF-8")
        	.replace("@", "%40")	
            .replace("+", "%20")
            .replace("!", "%21")
            .replace("'", "%27")
            .replace("(", "%28")
            .replace(")", "%29")
            .replace("~", "%7E");
    }
    
    public static String decodeURI(String value) throws UnsupportedEncodingException {
        return URLDecoder.decode(value, "UTF-8")
        	.replace("%40", "@")	
            .replace("%20", "+")
            .replace("%21", "!")
            .replace("%27", "'")
            .replace("%28", "(")
            .replace("%29", ")")
            .replace("%7E", "~");
    }    
    
}
