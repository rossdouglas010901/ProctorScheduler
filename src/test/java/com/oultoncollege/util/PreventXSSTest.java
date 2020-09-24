package com.oultoncollege.util;

import com.google.common.base.Charsets;
import com.google.common.io.CharStreams;
import static com.oultoncollege.util.PreventXSS.POLICY_DEFINITION;
import java.io.IOException;
import java.io.InputStreamReader;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;
import org.owasp.html.Handler;
import org.owasp.html.HtmlSanitizer;
import org.owasp.html.HtmlStreamRenderer;

/**
 *
 * @author bcop
 */
public class PreventXSSTest {
    
    public PreventXSSTest() {
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
     * Test of filter method, of class PreventXSS.
     */
    @Test
    public void testFilter() {
        System.out.println("filter");
        String untrustedHTML = "<script>alert('hi');</script>";
        String expResult = "";
        String result = PreventXSS.filter(untrustedHTML);
        assertEquals(expResult, result);
    }

    
    /**
     * A test-bed that reads HTML from stdin and writes sanitized content to stdout.
     */
    public static void main(String[] args) throws IOException {
        if (args.length != 0) {
            System.err.println("Reads from STDIN and writes to STDOUT");
            System.exit(-1);
        }
        System.err.println("[Reading from STDIN]");
        // Fetch the HTML to sanitize.
        String html = CharStreams.toString(new InputStreamReader(System.in, Charsets.UTF_8));
        // Set up an output channel to receive the sanitized HTML.
        HtmlStreamRenderer renderer = HtmlStreamRenderer.create(System.out,
                // Receives notifications on a failure to write to the output.
                new Handler<IOException>() {
            public void handle(IOException ex) {
                // System.out suppresses IOExceptions
                throw new AssertionError(null, ex);
            }
        },
                // Our HTML parser is very lenient, but this receives notifications on
                // truly bizarre inputs.
                new Handler<String>() {
            public void handle(String x) {
                throw new AssertionError(x);
            }
        });
        // Use the policy defined above to sanitize the HTML.
        HtmlSanitizer.sanitize(html, POLICY_DEFINITION.apply(renderer));
    }
    
}
