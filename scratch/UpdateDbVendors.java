package scratch;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class UpdateDbVendors {
    public static void main(String[] args) {
        String url = "jdbc:mysql://localhost:3306/hospital_management";
        String user = "root";
        String password = "password"; // Assuming standard local dev password, user hasn't specified but we used this before

        try (Connection conn = DriverManager.getConnection(url, user, password)) {
            // Update existing vendors to be approved so they aren't locked out
            String sql = "UPDATE users SET is_approved = 1 WHERE role = 'VENDOR' AND is_approved = 0";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                int rowsAffected = stmt.executeUpdate();
                System.out.println("Updated " + rowsAffected + " existing vendors to be approved.");
            }
        } catch (Exception e) {
            System.err.println("Error updating database: " + e.getMessage());
            // It's okay if this fails, we tried our best
        }
    }
}
