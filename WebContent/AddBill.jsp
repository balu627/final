<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add Bill Page</title>
<style>
    body {
        font-family: Lexend, sans-serif;
        margin: 0;
        padding: 20px;
        color: #333;
        letter-spacing: 1px;
        background-image: url("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSl2e6phZYZ5_SO0KCIPgB2doz9WrsJvIOD_g&s");
        background-repeat: no-repeat;
        background-size: cover;
        background-position: center;
    }
    
    h1 {
        color: #2c3e50;
        text-align: center;
        margin-bottom: 30px;
        margin-top:100px;
        text-shadow: 1px 1px 2px rgba(0,0,0,0.1);
    }

    /* form{
        display: flex;
        flex-direction: column;
        width: 100%;
    } */
    
    .container {
        display: flex;
        flex-direction: row;
        flex-wrap: wrap;
        max-width: 550px;
        background-color: #f5f5f5;
        margin: 0 auto;
        padding: 30px;
        border-radius: 8px;
        color:black;
        box-shadow: 10px 10px rgba(92, 87, 87, 0.2);
    }

    .container>div:first-child {
        flex: 1 0 100%;
    } 

    .container>div {
        flex: 0 1 48%;
    }

    .child2 {
        margin-right: 10px;
    }
     
    input[type="text"], #month{
        width: 100%;
        padding: 12px;
        margin: 8px 0 20px;
        border: 1px solid #ddd;
        border-radius: 20px;
        box-sizing: border-box;
        font-size: 12px;
        font-weight:200;
        transition: border 0.3s;
        letter-spacing: 1.2px;
        color: #566573;
        opacity: 1;
        font-size:15px;
    }

    ::placeholder {
        color: #566573;
        opacity: 1;
        font-size:15px;
    }
    
    input[type="text"]:focus {
        border-color: #3498db;
        outline: none;
        box-shadow: 0 0 5px rgba(52,152,219,0.5);
    }
    
    input[type="submit"] {
        margin-top:10px;
        background-color: #2e4053;
        color: white;
        padding: 12px 20px;
        border: none;
        border-radius: 20px;
        cursor: pointer;
        width: 45%;
        margin-left:25%;
        font-style: normal;
        font-weight: 600;
        font-size: 16px;
        line-height: 20px;
        font-family: Lexend, sans-serif;
        transition: background-color 0.5s;
        letter-spacing: 1px;
    }
    
    input[type="submit"]:hover {
        background-color: #2980b9;
        box-shadow: 0px 5px 5px 0px rgba(143, 148, 155, 0.2);
        
    }
    
    label {
        font-weight: bold;
        display: block;
        margin-bottom: 5px;
        letter-spacing: 1px;
        font-size:17px;
    }
</style>
</head>
<body>
<h1>Add Bill</h1>
    <form  class="container" action="addBillservlet" method="post">
        <div class="child1">
            <label for="consumerNo">Consumer Number:</label>
            <input type="text" id="consumerNo" name="consumerNo" pattern="^\d{13}$" minlength="13" maxlength="13"  placeholder="Enter consumer number" required>
        </div>
        
        <div class="child2">
            <label for="amount">Amount:</label>
            <input type="text" id="amount" name="amount" minlength="1" maxlength="8" pattern="^[1-9]\d{0,7}$" placeholder="Enter amount">
        </div>

        <div class="child3">
            <label for="month">Month:</label>
            <select id="month" name="month">
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
        </div>
    
        <input type="submit" value="Submit Bill">
    </form>
</body>
</html>
