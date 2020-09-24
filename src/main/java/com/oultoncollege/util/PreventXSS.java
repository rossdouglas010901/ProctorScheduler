package com.oultoncollege.util;

import java.util.regex.Pattern;

import org.owasp.html.HtmlPolicyBuilder;
import org.owasp.html.HtmlSanitizer;
import org.owasp.html.HtmlStreamEventReceiver;
import org.owasp.html.PolicyFactory;
import org.owasp.html.Sanitizers;

import com.google.common.base.Function;

/**
 * Based on the <a href=
 * "http://www.owasp.org/index.php/Category:OWASP_AntiSamy_Project#Stage_2_-_Choosing_a_base_policy_file">AntiSamy Slashdot example</a>. <blockquote>
 * Slashdot (http://www.slashdot.org/) is a techie news site that allows users to respond anonymously to news posts with very limited HTML markup. Now
 * Slashdot is not only one of the coolest sites around, it's also one that's been subject to many different successful attacks. Even more unfortunate
 * is the fact that most of the attacks led users to the infamous goatse.cx picture (please don't go look it up). The rules for Slashdot are fairly
 * strict: users can only submit the following HTML tags and no CSS: {@code <b>}, {@code <u>}, {@code <i>}, {@code <a>},
 * {@code <blockquote>}. <br>
 * Accordingly, we've built a policy file that allows fairly similar functionality. All text-formatting tags that operate directly on the font, color
 * or emphasis have been allowed. </blockquote>
 */
public class PreventXSS {

    /**
     * A policy definition that matches the minimal HTML that Slashdot allows.
     */
    public static final Function<HtmlStreamEventReceiver, HtmlSanitizer.Policy> POLICY_DEFINITION = new HtmlPolicyBuilder()
            .allowStandardUrlProtocols()
            // Allow title="..." on any element.
            .allowAttributes("title").globally()
            // Allow href="..." on <a> elements.
            .allowAttributes("href").onElements("a")
            // Defeat link spammers.
            .requireRelNofollowOnLinks()
            // Allow lang= with an alphabetic value on any element.
            .allowAttributes("lang").matching(Pattern.compile("[a-zA-Z]{2,20}")).globally()
            // The align attribute on <p> elements can have any value below.
            .allowAttributes("align").matching(true, "center", "left", "right", "justify", "char").onElements("p")
            // These elements are allowed.
            .allowElements("a", "p", "div", "i", "b", "em", "blockquote", "tt", "strong", "br", "ul", "ol", "li")
            // Custom slashdot tags.
            // These could be rewritten in the sanitizer using an ElementPolicy.
            .allowElements("quote", "ecode").toFactory();

    public static String filter(String untrustedHTML) {
        PolicyFactory policy = Sanitizers.FORMATTING.and(Sanitizers.LINKS);
        String safeHTML = policy.sanitize(untrustedHTML);
        return safeHTML.trim();
    }
    
}
