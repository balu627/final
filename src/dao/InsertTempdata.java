package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;

import util.DBBillTableCreator;
import util.DBConnection;

public class InsertTempdata {
    
    public static void InsertBillsData() {
    	
    	DBBillTableCreator.createBillTable();
    	
        try {
            Connection con = DBConnection.getConnection();
            String sql = "INSERT INTO Bill (consumerNo, amount, month, modeOfPayment, paymentTimeDate, transactionId, status) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);

            // Dummy Data 1
            ps.setLong(1, 1234567890124L);
            ps.setInt(2, 2500);
            ps.setInt(3, 5);
            ps.setString(4, "Online");
            ps.setString(5, "2025-05-14 12:30:00");
            ps.setString(6, "TXN1001");
            ps.setString(7, "paid");
            ps.executeUpdate();

            // Dummy Data 2
            ps.setLong(1, 1234567890125L);
            ps.setInt(2, 1800);
            ps.setInt(3, 5);
            ps.setString(4, "Cash");
            ps.setString(5, "2025-05-14 15:45:00");
            ps.setString(6, "TXN1002");
            ps.setString(7, "paid");
            ps.executeUpdate();

            // Dummy Data 3
            ps.setLong(1, 1234567890126L);
            ps.setInt(2, 2200);
            ps.setInt(3, 5);
            ps.setString(4, null);
            ps.setString(5, null);
            ps.setString(6, null);
            ps.setString(7, "unpaid");
            ps.executeUpdate();

            System.out.println("Dummy Bills inserted successfully!");

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public static void DropBills() {
        try {
            Connection con = DBConnection.getConnection();
            Statement stmt = con.createStatement();
            String sql = "Drop FROM Bill";
//            String sql = "DELETE FROM CustomerData";
            stmt.executeUpdate(sql);
            System.out.println("Bill table dropped successfully.");
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Error while dropping Bill table: " + e.getMessage());
        }
    }

}
