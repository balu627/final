package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import bean.Bill;
import dao.BillDao;

@WebServlet("/addBillservlet")
public class addBillservlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    long consumerNo = Long.parseLong(request.getParameter("consumerNo"));
	    int amount = Integer.parseInt(request.getParameter("amount"));
	    int month = Integer.parseInt(request.getParameter("month"));
	    
	    Bill bill = new Bill();
	    bill.setConsumerNo(consumerNo);
	    bill.setAmount(amount);
	    bill.setMonth(month);
	    int status = BillDao.addBill(bill);
//////	    BillDao.dropBillTable();
	    BillDao.printAllBills();
	    if (status > 0) {
	        request.setAttribute("message", "Bill added successfully!");
	    } else {
	        request.setAttribute("message", "Failed to add bill.");
	    }

	    request.getRequestDispatcher("billAdded.jsp").forward(request, response);
	}

}
