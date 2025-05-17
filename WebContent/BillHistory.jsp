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

    input[type="submit"] {
        margin-top:10px;
        margin-left:-50px;
        background-color: #2e4053;
        color: white;
        padding: 10px 8px;
        border: none;
        border-radius: 20px;
        cursor: pointer;
        width: 10%;
        position:relative;
        left:100px;
        font-style: normal;
        font-weight: 600;
        font-size: 16px;
        line-height: 20px;
        font-family: "Lexend", sans-serif;
        transition: background-color 0.5s;
        letter-spacing: 1px;
    }
    
    input[type="submit"]:hover {
        background-color: #2980b9;
        box-shadow: 0px 5px 5px 0px rgba(143, 148, 155, 0.2);
    }

    #search-range {
        margin-top:30px;
        margin-left:400px;
    }

    #from, #to {
        padding: 10px 8px;
        border: none;
        border-radius: 20px;
        cursor: pointer;
        width: 20%;
        font-style: normal;
        font-weight: 500;
        font-size: 16px;
        line-height: 20px;
        font-family: "Lexend", sans-serif;
        transition: background-color 0.5s;
        letter-spacing: 1px;
    }
    
    label {
        font-style: normal;
        font-weight: 600;
        font-size: 16px;
        line-height: 20px;
        font-family: "Lexend", sans-serif;
        letter-spacing: 1px;
    }

</style>
</head>
<body>


<div class="navbar">
    <strong>Navigation Bar</strong>
</div>

<h1>Bill Payment History (Last 5 Months)</h1>
 
<% 
List<Bill> paidBills = (List<Bill>) request.getAttribute("paidBillsFiveMonths"); 
MonthName mn = new MonthName();
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
                        <td><%= bill.getModeOfPayment() != null ? bill.getModeOfPayment() : "N/A" %></td>
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

    <div >

    <form class="search" action="SearchByPeriodServlet" method="post">
            <div class="periodinput" id="search-range">
                <label for="from">From:</label>
                <select id="from" name="from">
                    <option value="1">January</option>
                    <option value="2">February</option>
                    <option value="3">March</option>
                    <option value="4">April</option>
                    <option value="5">May</option>
                    <option value="6">June</option>
                    <option value="7">July</option>
                    <option value="8">August</option>
                    <option value="9">September</option>
                    <option value="10">October</option>
                    <option value="11">November</option>
                    <option value="12">December</option>
                </select>
             <label for="to">To :</label>
                <select id="to" name="to">
                    <option value="1">January</option>
                    <option value="2">February</option>
                    <option value="3">March</option>
                    <option value="4">April</option>
                    <option value="5">May</option>
                    <option value="6">June</option>
                    <option value="7">July</option>
                    <option value="8">August</option>
                    <option value="9">September</option>
                    <option value="10">October</option>
                    <option value="11">November</option>
                    <option value="12">December</option>
                </select>
            
                <input type="submit" value="Search">
        </div>
           
        </form>
    </div>
    
 <% } %>


<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.0/jquery.min.js"></script>
    <script>
       $(document).ready(function(){
            var rowCount = $('tbody tr').length;
            console.log(rowCount);
            if (rowCount < 6 ) {
                $("<style>", {id: "myStyle"}).appendTo("head");
                $("#myStyle").html("#tableContainer { overflow: hidden; }");
            }else {
                $('#tableContainer').addClass('do-scroll');
            }
        });
    </script>

</body>
</html>
