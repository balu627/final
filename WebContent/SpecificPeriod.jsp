<%@ page session="true" %>
<%
    String user = (String) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    String custName = (String) session.getAttribute("custName");
    String email = (String) session.getAttribute("email");
%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*, bean.Bill,bean.MonthName" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Bill Payment History</title>
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 20px;
        line-height: 1.6;
        color: #333;
        background-image: url("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSl2e6phZYZ5_SO0KCIPgB2doz9WrsJvIOD_g&s");
        background-repeat: no-repeat;
        background-size: cover;
        background-position: center;
    }
    
    h1 {
        color: #2c3e50;
        border-bottom: 2px solid #3498db;
        padding-bottom: 10px;
        margin-bottom: 20px;
        text-align: center;
    }

    /* Add space for nav bar */
    .navbar {
        background-color: #2e4053;
        padding: 10px;
        color: white;
        text-align: center;
        margin-bottom: 20px;
    }
    
    table {
        width: 80%;  /* Reduce table width */
        margin: 20px auto;  /* Center the table and add top/bottom margin */
        border-collapse: collapse;
        box-shadow: 10px 10px rgba(92, 87, 87, 0.2);
        background-color: #f5f5f5;
    }
    
    th, td {
        padding: 12px 15px;
        text-align: center;
        border-bottom: 1px solid #ddd;
    }
    
    th {
        background-color: #2e4053;
        color: white;
        font-weight: bold;
    }
    
    tr:nth-child(even) {
        background-color: white;
    }
    
    tr:hover {
        background-color: #e9e9e9;
    }

    #tableContainer {
        margin-left:30px;
        height: 370px;
        overflow-y: scroll;
        overflow-x: hidden;
    }
    
    .status-paid {
        color: #27ae60;
        font-weight: bold;
    }
    
    .status-pending {
        color: #e74c3c;
        font-weight: bold;
    }
    
    .month-name {
        text-transform: capitalize;
    }
    
    .no-records {
        text-align: center;
        padding: 20px;
        color: #7f8c8d;
        font-style: italic;
    }
    
    .amount {
        text-align: center;
    }
    
    .date {
        white-space: nowrap;
    }
    .search{
    width:100vw;
    display:flex;
    flex-direction: column;
    justify-content:center;
    align-items:center;
    }
    
</style>
</head>
<body>

<!-- Navbar section -->
<div class="navbar">
    <strong>Navigation Bar</strong>
</div>
<%  String fromstr = (String) request.getAttribute("from");
    String tostr = (String) request.getAttribute("to");
    int fromint = Integer.parseInt(fromstr);
    int toint = Integer.parseInt(tostr);
    MonthName mn = new MonthName();
    String from = mn.getMonthName(fromint);
    String to = mn.getMonthName(toint);
%>


<h1>Bill Payment History from <%= from  %> to <%=  to %></h1>

<% 
List<Bill> paidBills = (List<Bill>) request.getAttribute("specificperiodbills"); 
if (paidBills == null || paidBills.isEmpty()) { 
%>
    <p class="no-records">No bill records found.</p>
<% } else { %>
    <div id="tableContainer">
    <table>
        <thead>
            <tr>
                <th>Bill No</th>
                <th>Payment Mode</th>
                <th>Month</th>
                <th class="amount">Amount (&#8377;)</th>
                <th>Payment Date</th>
                <th>Transaction ID</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
            <% for (Bill bill : paidBills) { %>
                <tr>
                    <td><%= bill.getBillNo() %></td>  
                    <td><%= bill.getModeOfPayment() %></td>
                    <td class="month-name">
                        <% 
                        if (bill.getMonth() >= 1 && bill.getMonth() <= 12) {
                            out.print(mn.getMonthName(bill.getMonth()));
                        } else {
                            out.print("Invalid Month");
                        }
                        %>
                    </td>
                    <td class="amount">&#8377;<%= bill.getAmount() %></td>
                    <td class="date"><%= bill.getPaymentTimeDate() %></td>
                    <td><%= bill.getTransactionId() %></td>
                    <td class="<%= "status-" + bill.getStatus().toLowerCase() %>">
                        <%= bill.getStatus() %>
                    </td>
                </tr>
            <% } %>
                
        </tbody>
    </table>
</div>
    
<% } %>

<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.0/jquery.min.js"></script>
    <script>
       $(document).ready(function(){
            var rowCount = $('tbody tr').length;
            console.log(rowCount);
            if (rowCount < 8 ) {
                $("<style>", {id: "myStyle"}).appendTo("head");
                $("#myStyle").html("#tableContainer { overflow: hidden; }");
            }else {
                $('#tableContainer').addClass('do-scroll');
            }
        });
    </script>

</body>
</html>
