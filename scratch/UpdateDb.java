import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

public class UpdateDb {
    public static void main(String[] args) throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital_db?useSSL=false&serverTimezone=UTC", "root", "9353323573");
        Statement stmt = conn.createStatement();
        int rows = stmt.executeUpdate("UPDATE users SET is_approved = 1 WHERE role = 'DOCTOR'");
        System.out.println("Updated " + rows + " existing doctors to be approved.");
        conn.close();
    }
}
