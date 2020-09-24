package com.oultoncollege.util;

import com.sendgrid.Method;
import com.sendgrid.Request;
import com.sendgrid.Response;
import com.sendgrid.SendGrid;
import com.sendgrid.helpers.mail.Mail;
import com.sendgrid.helpers.mail.objects.Content;
import com.sendgrid.helpers.mail.objects.Email;
import java.io.IOException;

/**
 * SendGrid - Email example
 *
 * @author bcop
 */
public class SendGridEmail {

    public static void sendMessage(String from, String to, String subject, String msg) {
        Email fromEmail = new Email(from);
        Email toEmail = new Email(to);
        Content body = new Content("text/plain", msg);
        Mail mail = new Mail(fromEmail, subject, toEmail, body);

        SendGrid sg = new SendGrid(System.getenv("SENDGRID_API_KEY"));
        Request request = new Request();
        try {
            request.setMethod(Method.POST);
            request.setEndpoint("mail/send");
            request.setBody(mail.build());
            Response response = sg.api(request);
            System.out.println(response.getStatusCode());
            System.out.println(response.getBody());
            System.out.println(response.getHeaders());
        } catch (IOException ex) {
            ex.printStackTrace();
        }
    }
}
