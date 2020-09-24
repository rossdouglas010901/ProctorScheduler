package com.oultoncollege.controller;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * LogoutServlet.java
 *  Logs out the currently active User by invalidating their Session.
 * 
 * @author Liu Youfeng
 * @author bcopeland
 */
//@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	ServletContext appContext = getServletContext();
    	String app = appContext.getContextPath();
    	
    	HttpSession session = request.getSession(false); // Fetch session object
        if (session != null) {
            session.invalidate(); // removes all session attributes bound to the session
            request.setAttribute("errMessage", "You have logged out successfully");
            response.sendRedirect(app);
            System.out.println("Logged out");
        } else {
             System.out.println("Tried to Logout but no valid Session");
        }
    }
}
