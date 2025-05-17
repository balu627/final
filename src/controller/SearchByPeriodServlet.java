package controller;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.Bill;
import dao.BillDao;

@WebServlet("/SearchByPeriodServlet")
public class SearchByPeriodServlet extends HttpServlet {
      
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int fromMonth = Integer.parseInt(request.getParameter("from"));
		int toMonth = Integer.parseInt(request.getParameter("to"));
		HttpSession session = request.getSession();
		long user = Long.parseLong((String) session.getAttribute("consumerNo"));
		if(fromMonth>toMonth)
		{
			request.setAttribute("message", "From Cannot be Greater than To Month.");
			request.getRequestDispatcher("billAdded.jsp").forward(request, response);
		}
		
		List<Bill> specificperiodbills = new ArrayList<>();
		ResultSet rs = BillDao.getSpecifcPeriod(fromMonth,toMonth,user);
		try {
			while(rs.next())
			{
				Bill temp = new Bill();
            	temp.setBillNo(rs.getInt("billNo"));
            	temp.setMonth(rs.getInt("month"));
            	temp.setStatus(rs.getString("status"));
            	temp.setAmount(rs.getInt("amount"));
            	temp.setTransactionId(rs.getInt("transactionId"));
            	temp.setPaymentTimeDate(rs.getString("paymentTimeDate"));
            	temp.setModeOfPayment(rs.getString("modeOfPayment"));
            	specificperiodbills.add(temp);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		String sendfm = Integer.toString(fromMonth);
		String sendtm = Integer.toString(toMonth);
		request.setAttribute("from", sendfm);
		request.setAttribute("to", sendtm);
		request.setAttribute("specificperiodbills", specificperiodbills);
	    request.getRequestDispatcher("SpecificPeriod.jsp").forward(request, response);
	}

}
