<%@ page session="true" %>
<%
    String user = (String) session.getAttribute("user");
    String role = (String) session.getAttribute("role");
    
    if (user == null || !"admin".equals(role)) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    String name = (String) session.getAttribute("name");
    String email = (String) session.getAttribute("email");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/material-design-iconic-font/2.2.0/css/material-design-iconic-font.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Bree+Serif&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Bree Serif', serif;
            margin: 0;
            background-image: url("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSl2e6phZYZ5_SO0KCIPgB2doz9WrsJvIOD_g&s");
            background-repeat: no-repeat;
            background-size: cover;
            background-position: center;
            height:100vh;
        }
        .topbar {
            background-color: #004466;
            color: white;
            padding: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .menu {
            display: flex;
            align-items: center;
        }
        .menu > div {
            position: relative;
            margin-right: 20px;
        }
        .menu a {
            color: white;
            text-decoration: none;
            font-weight: bold;
            padding: 10px 15px;
            display: inline-block;
        }
        .menu a:hover {
            background-color: #006699;
        }
        .dropdown-content {
            display: none;
            position: absolute;
            background-color: #f9f9f9;
            min-width: 160px;
            box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
            z-index: 1;
        }
        .dropdown-content a {
            color: #004466;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
        }
        .dropdown-content a:hover {
            background-color: #ddd;
        }
        .dropdown:hover .dropdown-content {
            display: block;
        }
        .user-info {
            display: flex;
            align-items: center;
        }
        .user-info span {
            margin-right: 15px;
            font-weight: bold;
        }
        .user-info button {
            padding: 6px 12px;
            background-color: #ff4d4d;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .user-info button:hover {
            background-color: #e60000;
        }
        .welcome-container {
            padding: 40px;
            background-color: rgba(255, 255, 255, 0.9);
            margin: 50px auto;
            width: 80%;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        .admin-features {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
            margin-top: 30px;
        }
        .feature-card {
            background: white;
            border-radius: 8px;
            padding: 20px;
            margin: 10px;
            width: 200px;
            text-align: center;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
    <div class="topbar">
        <div class="menu">
            <div class="dropdown">
                <a href="adminHome.jsp">Dashboard</a>
                <div class="dropdown-content">
                    <a href="adminHome.jsp#stats">Statistics</a>
                    <a href="adminHome.jsp#reports">Reports</a>
                    <a href="adminHome.jsp#settings">Settings</a>
                </div>
            </div>
            
            <div class="dropdown">
                <a href="manageConsumers.jsp">Manage Consumers</a>
                <div class="dropdown-content">
                    <a href="viewConsumers.jsp">View Consumers</a>
                    <a href="addConsumer.jsp">Add Consumer</a>
                    <a href="editConsumer.jsp">Edit Consumer</a>
                </div>
            </div>
            
            <div class="dropdown">
                <a href="manageBills.jsp">Billing</a>
                <div class="dropdown-content">
                    <a href="AddBill.jsp">AddBill</a>
                    <a href="viewBills.jsp">View Bills</a>
                    <a href="paymentHistory.jsp">Payment History</a>
                </div>
            </div>
            
            <div class="dropdown">
                <a href="manageComplaints.jsp">Complaints</a>
                <div class="dropdown-content">
                    <a href="viewComplaints.jsp">View Complaints</a>
                    <a href="resolveComplaints.jsp">Resolve Complaints</a>
                </div>
            </div>
        </div>
        
        <div class="user-info">
            <span>Welcome Admin, <%= name %></span>
            <button type="button" onclick="logout()">Logout</button>
        </div>
    </div>

    <div class="welcome-container">
        <h2>Admin Dashboard</h2>
        <p>Manage all electricity portal operations from here.</p>
        
        <div id="stats" style="margin-top: 30px;">
            <h3>Quick Stats</h3>
            <div class="admin-features">
                <div class="feature-card">
                    <i class="zmdi zmdi-accounts" style="font-size: 30px; color: #004466;"></i>
                    <h4>Total Consumers</h4>
                    <p>1,250</p>
                </div>
                <div class="feature-card">
                    <i class="zmdi zmdi-money" style="font-size: 30px; color: #004466;"></i>
                    <h4>Payments Today</h4>
                    <p>₹85,420</p>
                </div>
                <div class="feature-card">
                    <i class="zmdi zmdi-alert-triangle" style="font-size: 30px; color: #004466;"></i>
                    <h4>Pending Complaints</h4>
                    <p>24</p>
                </div>
                <div class="feature-card">
                    <i class="zmdi zmdi-assignment" style="font-size: 30px; color: #004466;"></i>
                    <h4>Bills Generated</h4>
                    <p>1,180</p>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        function logout() {
            window.location.href = 'LogoutServlet';
        }
    </script>
</body>
</html>   