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
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer Home</title>
    <link rel="stylesheet" href="css/style.css">
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
    </style>
</head>
<body>
    <div class="topbar">
        <div class="menu">
            <div class="dropdown">
                <a href="home.jsp">Home</a>
                <div class="dropdown-content">
                    <a href="home.jsp#dashboard">Dashboard</a>
                    <a href="home.jsp#notifications">Notifications</a>
                    <a href="home.jsp#quicklinks">Quick Links</a>
                </div>
            </div>
            
            <div class="dropdown">
                <a href="paybill.jsp">Pay Bill</a>
                <div class="dropdown-content">
                    <a href="viewBills">View Bill</a>
                    <a href="BillHistory">Payment History</a>
                </div>
            </div>
            
            <div class="dropdown">
                <a href="registercomplaint.jsp">Complaint</a>
                <div class="dropdown-content">
                    <a href="registercomplaint.jsp">Register Complaint</a>
                    <a href="complaintstatus.jsp">Complaint Status</a>
                    <a href="pastcomplaints.jsp">Past Complaints</a>
                </div>
            </div>
            
            <div class="dropdown">
                <a href="profile.jsp">Profile</a>
                <div class="dropdown-content">
                    <a href="profile.jsp#personal">Personal Info</a>
                    <a href="profile.jsp#account">Account Settings</a>
                    <a href="profile.jsp#documents">Documents</a>
                </div>
            </div>
        </div>
        
        <div class="user-info">
            <span>Welcome, <%= custName != null ? custName : user %></span>
            <button type="button" onclick="logout()">Logout</button>
        </div>
    </div>

    <div class="welcome-container">
        <h2>Welcome to Your Electricity Account</h2>
        <p>You can now manage your electricity services online.</p>
        
        <div id="dashboard" style="margin-top: 30px;">
            <h3>Account Summary</h3>
            <p><strong>User ID:</strong> <%= user %></p>
            <% if(custName != null) { %>
                <p><strong>Name:</strong> <%= custName %></p>
            <% } %>
            <% if(email != null) { %>
                <p><strong>Email:</strong> <%= email %></p>
            <% } %>
        </div>
    </div>

    <script type="text/javascript">
        function logout() {
            // You can also call a LogoutServlet here if you prefer
            window.location.href = 'LogoutServlet';
        }
    </script>
</body>
</html> 