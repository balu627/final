package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Locale;

import bean.Bill;
import util.DBConnection;
import util.DBBillTableCreator;

public class BillDao {
    public static int addBill(Bill bill) {
    	System.out.println("hi");
        int status = 0;
        try {
            DBBillTableCreator.createBillTable();
            Connection con = DBConnection.getConnection();
//
            String sql = "INSERT INTO Bill (consumerNo, amount, month, modeOfPayment, paymentTimeDate, transactionId, status) VALUES (?, ?, ?, NULL, NULL, NULL, 'unpaid')";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setLong(1, bill.getConsumerNo());
            ps.setInt(2, bill.getAmount());
            ps.setInt(3, bill.getMonth());
            status = ps.executeUpdate();
            con.close();
//
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    public static void dropBillTable() {
        try {
            Connection con = DBConnection.getConnection();
            Statement stmt = con.createStatement();
            String sql = "DROP TABLE Bill";
            stmt.executeUpdate(sql);
            System.out.println("Bill table dropped successfully!");
            stmt.close();
            con.close();
        } catch (Exception e) {
            System.out.println("Table might not exist yet!");
            e.printStackTrace();
        }
    }

    public static void printAllBills() {
        try {
            Connection con = DBConnection.getConnection();
            String sql = "SELECT * FROM Bill";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            System.out.println("------------------------------------------------------------");
            System.out.printf("%-8s %-12s %-8s %-10s %-15s %-15s %-15s %-8s\n",
                    "BillNo", "consumerNo", "Amount", "Month", "ModeOfPayment", "paymentTimeDate", "transactionId", "Status");
            System.out.println("------------------------------------------------------------");

            while (rs.next()) {
                System.out.printf("%-8d %-12s %-8d %-10s %-15s %-15s %-15s %-8s\n",
                        rs.getInt("billNo"),
                        rs.getString("consumerNo"),
                        rs.getInt("amount"),
                        rs.getInt("month"),
                        rs.getString("modeOfPayment"),
                        rs.getString("paymentTimeDate"),
                        rs.getString("transactionId"),
                        rs.getString("status"));
            }

            System.out.println("------------------------------------------------------------");

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public static ResultSet getUnpaidBills(long user) {
        ResultSet rs = null;
        try {
            Connection con = DBConnection.getConnection();
            String sql = "SELECT * FROM Bill WHERE status='unpaid' AND consumerNo = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setLong(1,user);
            rs = ps.executeQuery();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rs;
    }
    
    public static ResultSet getBillsByNo(int billNo,Connection con) {
        ResultSet rs = null;
        try {
            String sql = "SELECT * FROM Bill WHERE billNo = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1,billNo);
            rs = ps.executeQuery();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rs;
    }
    
    public static boolean checkTransactionId(int tempId)
    {
    	try{
    		Connection con = DBConnection.getConnection();
        	String sql = "select transactionId from Bill where transactionId = ?";
        	PreparedStatement ps = con.prepareStatement(sql);
        	String temp = Integer.toString(tempId);
            ps.setString(1,temp);
            ResultSet rs = ps.executeQuery();
            if(rs.next())
            {
            	return true;
            }
            return false;
    	}
    	catch(Exception e)
    	{
    		e.printStackTrace();
    	}
    	
    	return false;
    }
    
    public static void updateTransactionId(int billNo, String timestamp,String modeOfTransaction,int temptransactionId)
    {
    	try{
    		Connection con = DBConnection.getConnection();
        	String sql = "update Bill SET modeOfPayment = ? , paymentTimeDate = ? , transactionId = ? , status = 'paid' WHERE billNo = ? AND status='unpaid'";
        	
        	PreparedStatement ps = con.prepareStatement(sql);
        	
            ps.setString(1,modeOfTransaction);
            ps.setString(2, timestamp);
            ps.setInt(3,temptransactionId);
            ps.setInt(4, billNo);
            ps.executeUpdate();
            
            con.close();
            return ;
    	}
    	catch(Exception e)
    	{
    		e.printStackTrace();
    	}
    }
    
    public static ResultSet getPastFiveMonths(long user)
    {
        LocalDateTime currentDateTime = LocalDateTime.now();
        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd", Locale.getDefault());
        String dateOnly = currentDateTime.format(dateFormatter);
        
        DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss", Locale.getDefault());
        String timeOnly = currentDateTime.format(timeFormatter);
        
        String timedateformat = dateOnly+" "+timeOnly;
        int month = Integer.parseInt(timedateformat.substring(5, 7));
        long cid = user;
        ResultSet rs = null;
        try
        {
            Connection con = DBConnection.getConnection();
            String sql = "SELECT * FROM Bill WHERE consumerNo = ? AND month <= ? AND  status = 'paid'  ORDER BY month  DESC";
            PreparedStatement ps = con.prepareStatement(sql);      
            ps.setLong(1, cid);
            ps.setInt(2,month);
            rs = ps.executeQuery();
            
       

            return rs;
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return rs;
    }
    
    public static ResultSet getSpecifcPeriod(int fromMonth,int toMonth,long user)
    {
        ResultSet rs = null;
    	try
    	{
    		Connection con = DBConnection.getConnection();
    		String sql = "SELECT * FROM Bill WHERE consumerNo = ? AND month >= ? AND month<= ? AND status = 'paid'  ORDER BY month";
        	
        	PreparedStatement ps = con.prepareStatement(sql);   
        	ps.setLong(1, user);
            ps.setInt(2,fromMonth);
            ps.setInt(3,toMonth);
            rs = ps.executeQuery();
            return rs;
    	}
    	catch(Exception e)
    	{
    		e.printStackTrace();
    	}
    	return rs;
    }

}
