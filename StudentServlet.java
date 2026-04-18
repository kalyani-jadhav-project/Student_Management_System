package codes;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/StudentServlet")
public class StudentServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        System.out.println("Action: " + action);

        try {
            Connection con = Dbconnection.getConnection();

            // ===== ADD =====
            if ("add".equals(action)) {

                System.out.println("Adding student...");

                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String contact = request.getParameter("contact");
                String dob = request.getParameter("dob");
                String year = request.getParameter("year");
                String prn = request.getParameter("prn");
                String department = request.getParameter("department");

                int dbms = 0, cn = 0, mp = 0, daa = 0, oe = 0;

                try { dbms = Integer.parseInt(request.getParameter("dbms")); } catch(Exception e){}
                try { cn   = Integer.parseInt(request.getParameter("cn")); } catch(Exception e){}
                try { mp   = Integer.parseInt(request.getParameter("mp")); } catch(Exception e){}
                try { daa  = Integer.parseInt(request.getParameter("daa")); } catch(Exception e){}
                try { oe   = Integer.parseInt(request.getParameter("oe")); } catch(Exception e){}

                // ✅ CALCULATE PERCENTAGE
                int total = dbms + cn + mp + daa + oe;
                double percentage = total / 5.0;

                PreparedStatement ps = con.prepareStatement(
                "INSERT INTO studentss1(name,email,contact,dob,percentage,year,prn,department,dbms,cn,mp,daa,oe) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)");

                ps.setString(1, name);
                ps.setString(2, email);
                ps.setString(3, contact);
                ps.setString(4, dob);
                ps.setDouble(5, percentage);
                ps.setString(6, year);
                ps.setString(7, prn);
                ps.setString(8, department);

                ps.setInt(9, dbms);
                ps.setInt(10, cn);
                ps.setInt(11, mp);
                ps.setInt(12, daa);
                ps.setInt(13, oe);

                int rows = ps.executeUpdate();
                System.out.println("Inserted Rows: " + rows);

                ps.close();
            }

            // ===== DELETE =====
            else if ("delete".equals(action)) {

                int id = Integer.parseInt(request.getParameter("id"));

                PreparedStatement ps = con.prepareStatement(
                "DELETE FROM studentss1 WHERE id=?");

                ps.setInt(1, id);
                ps.executeUpdate();
                ps.close();
            }

            // ===== UPDATE =====
            else if ("update".equals(action)) {

                int id = Integer.parseInt(request.getParameter("id"));

                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String contact = request.getParameter("contact");
                String dob = request.getParameter("dob");
                String year = request.getParameter("year");
                String prn = request.getParameter("prn");
                String department = request.getParameter("department");

                int dbms = 0, cn = 0, mp = 0, daa = 0, oe = 0;

                try { dbms = Integer.parseInt(request.getParameter("dbms")); } catch(Exception e){}
                try { cn   = Integer.parseInt(request.getParameter("cn")); } catch(Exception e){}
                try { mp   = Integer.parseInt(request.getParameter("mp")); } catch(Exception e){}
                try { daa  = Integer.parseInt(request.getParameter("daa")); } catch(Exception e){}
                try { oe   = Integer.parseInt(request.getParameter("oe")); } catch(Exception e){}

                // ✅ CALCULATE PERCENTAGE AGAIN
                int total = dbms + cn + mp + daa + oe;
                double percentage = total / 5.0;

                PreparedStatement ps = con.prepareStatement(
                "UPDATE studentss1 SET name=?, email=?, contact=?, dob=?, percentage=?, year=?, prn=?, department=?, dbms=?, cn=?, mp=?, daa=?, oe=? WHERE id=?");

                ps.setString(1, name);
                ps.setString(2, email);
                ps.setString(3, contact);
                ps.setString(4, dob);
                ps.setDouble(5, percentage);
                ps.setString(6, year);
                ps.setString(7, prn);
                ps.setString(8, department);

                ps.setInt(9, dbms);
                ps.setInt(10, cn);
                ps.setInt(11, mp);
                ps.setInt(12, daa);
                ps.setInt(13, oe);

                ps.setInt(14, id);

                int rows = ps.executeUpdate();
                System.out.println("Updated Rows: " + rows);

                ps.close();
            }

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("dashboard.jsp");
    }
}