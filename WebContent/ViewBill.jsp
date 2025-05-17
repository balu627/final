<%@ page session="true" %>
<%
    String user = (String) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<%@ page import="java.sql.*, dao.BillDao" %>
<%@ page import="java.util.*, bean.Bill" %>
<%@ page import="bean.MonthName" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Unpaid Bills List</title>

<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f8f9fa;
        margin: 0;
        padding: 20px;
        color: #343a40;
        letter-spacing: 1px;
        background-image: url("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSl2e6phZYZ5_SO0KCIPgB2doz9WrsJvIOD_g&s");
        background-repeat: no-repeat;
        background-size: cover;
        background-position: center;
    }
    h2 {
        color: #2c3e50;
        text-align: center;
        margin-bottom: 25px;
        padding-bottom: 10px;
        margin-top:100px;
        border-bottom: 2px solid #e9ecef;
    }
    table {
        width: 100%;
        max-width: 1000px;
        margin: 0 auto;
        border-collapse: collapse;
        box-shadow: 10px 10px rgba(92, 87, 87, 0.2);
        background-color: white;
        border-radius:5px;
    }
    thead tr {
        background-color: #2e4053;
        color: white;
        text-align: left;
        
    }
    th, td {
        padding: 12px 15px;
        text-align: center;
        
    }
    tbody tr {
        border-bottom: 1px solid #dddddd;
    }
    tbody tr:nth-of-type(even) {
        background-color: #f3f3f3;
    }
    tbody tr:hover {
        background-color: #e3f2fd;
        cursor: pointer;
    }
    tfoot tr {
        background-color: #e9ecef;
        font-weight: bold;
    }
    /* Status styling */
    td:last-child[data-status="unpaid"] {
        color: #e74c3c;
        font-weight: bold;
    }
    
    #tableContainer {
        height: 370px;
        overflow-y: scroll;
        overflow-x: hidden;
    }
    
    #payButton {
        margin: 40px auto;
        display: block;
        padding: 12px 25px;
        font-size: 16px;
        font-weight:600;
        background-color: #3498db;
        color: white;
        border: none;
        border-radius: 20px;
        cursor: pointer;
        transition: background-color 0.3s;
        letter-spacing: 1px;
    }
    #payButton:hover {
        background-color: #2c80b4;
    }
    #payButton:disabled {
        background-color: #95a5a6;
        cursor: not-allowed;
    }
    .selected-row {
        background-color: #d4e6f7 !important;
    }
    input[type="checkbox"] {
        transform: scale(1.3);
        cursor: pointer;
    }
</style>

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

document.addEventListener('DOMContentLoaded', () => {
    document.querySelectorAll('tbody tr').forEach(row => {
        row.addEventListener('click', e => {
            if (e.target.type !== 'checkbox') {
                let cb = row.querySelector('input[type="checkbox"]');
                cb.checked = !cb.checked;
                toggleRowAndTotal(cb);
            }
        });
    });

    document.querySelectorAll('input[name="billSelect"]').forEach(cb => {
        cb.addEventListener('change', () => toggleRowAndTotal(cb));
    });

    updatePayButton();
});

function toggleRowAndTotal(cb) {
    updateRowStyle(cb.closest('tr'), cb.checked);
    updateTotal();
    updatePayButton();
}
    
    
    const checkboxes = document.querySelectorAll('input[name="billSelect"]');
    checkboxes.forEach(checkbox => {
        checkbox.addEventListener('change', function() {
            updateRowStyle(this.closest('tr'), this.checked);
            updateTotal();
            updatePayButton();
        });
    });

    function updateRowStyle(row, isChecked) {
        if (isChecked) {
            row.classList.add('selected-row');
        } else {
            row.classList.remove('selected-row');
        }
    }

    function updateTotal() {
        let checkboxes = document.querySelectorAll('input[name="billSelect"]:checked');
        let total = 0;
        checkboxes.forEach(cb => {
            total += parseFloat(cb.getAttribute('amount'));
        });
        document.getElementById("totalAmount").innerText = "₹" + total.toFixed(2);
    }

    function updatePayButton() {
        const payButton = document.getElementById("payButton");
        const checkedCount = document.querySelectorAll('input[name="billSelect"]:checked').length;
        payButton.disabled = checkedCount === 0;
    }

</script>



</head>
<body>

<h2>List of Unpaid Bills</h2>

<form action="PayBillServlet" method="post">
    <div id="tableContainer">
        <table>
            <thead>
                <tr>
                    <th>Select</th>
                    <th>Bill No</th>
                    <th>Customer ID</th>
                    <th>Amount</th>
                    <th>Month</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <%
                    MonthName mn = new MonthName();
                    List<Bill> unpaidBills = (List<Bill>) request.getAttribute("unpaidBills");
                    if (unpaidBills != null && !unpaidBills.isEmpty()) {
                        for (Bill b : unpaidBills) {
                             String month = mn.getMonthName(b.getMonth());
                %>
                <tr>
                    <td>
                        <input type="checkbox" name="billSelect" value="<%= b.getBillNo() %>" 
                               amount="<%= b.getAmount() %>">
                    </td>
                    <td><%= b.getBillNo() %></td>
                    <td><%= b.getConsumerNo() %></td>
                    <td>₹<%= b.getAmount() %></td>
                    <td><%= month %></td>
                    <td data-status="<%= b.getStatus().toLowerCase() %>"><%= b.getStatus() %></td>
                </tr>
                <%
                        }
                    }
                %>
            </tbody>
            <tfoot>
                <tr>
                    <td colspan="3">Total Amount</td>
                    <td colspan="3" id="totalAmount">₹0.00</td> 
                </tr>
            </tfoot>
        </table>
    </div>

    <button type="submit" id="payButton" disabled>Pay Selected Bills</button>
</form>

</body>
</html>