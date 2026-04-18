
package codes;

import java.sql.*;

public class Dbconnection {
    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            return DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/student_db",
                "root",
                "Kalyani@12345"
            );

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}