package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.LoginDao;
import util.DBUserTableCreator;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userType = request.getParameter("userType");
        String userId = request.getParameter("userId");
        String password = request.getParameter("password");


        try {
            DBUserTableCreator.createAdminTable();
        	String result = LoginDao.checklogin(userType,userId,password);
        	if(!result.equals("Match"))
        	{
        		request.setAttribute("message", result);
        	    request.setAttribute("redirectPage", "login.jsp");
        	    request.getRequestDispatcher("message.jsp").forward(request, response);
        	}
        	
        		ResultSet rs = LoginDao.getSuccessCredentials(userId,userType);
        		
        		rs.next();
        		
        		HttpSession session = request.getSession();
        			
                session.setAttribute("user", userId);
                session.setAttribute("name", rs.getString("name"));
                session.setAttribute("email", rs.getString("email"));
                session.setAttribute("role", userType);
                if(!userType.equals("admin"))
                {
                	 String str = Long.toString(rs.getLong("consumerId"));
                	    session.setAttribute("consumerNo", str);                }

                if (userType.equals("admin")) {
                    response.sendRedirect("adminhome.jsp");
                } else {
                    response.sendRedirect("home.jsp");
                }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error: " + e.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
        }
    }      