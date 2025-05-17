package controller;

import java.io.IOException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import bean.Bill;
import dao.BillDao;

@WebServlet("/viewBills")
public class viewBillServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Bill> data = new ArrayList<>();
        HttpSession session = request.getSession();
        long user = Long.parseLong((String) session.getAttribute("consumerNo"));
        try {
            ResultSet rs = BillDao.getUnpaidBills(user);
            while (rs != null && rs.next()) {
                Bill bill = new Bill();
                bill.setBillNo(rs.getInt("billNo"));
                bill.setConsumerNo(rs.getLong("consumerNo"));
                bill.setAmount(rs.getInt("amount"));
                bill.setMonth(rs.getInt("month"));
                bill.setStatus(rs.getString("status"));
                data.add(bill);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("unpaidBills", data);
        request.getRequestDispatcher("ViewBill.jsp").forward(request, response);
    }
}
