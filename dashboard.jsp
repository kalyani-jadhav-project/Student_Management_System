<%@ page import="java.sql.*" %>
<%@ page import="codes.Dbconnection" %>
<!DOCTYPE html>
<html>
<head>
<title>Dashboard</title>
<link rel="stylesheet" href="style.css?v=1">
</head>
<body>

<!-- ================= ADD STUDENT ================= -->
<div class="container">
<h2>Add Student Details</h2>

<form action="StudentServlet" method="post">

<input type="text" name="name" placeholder="Name" required>
<input type="text" name="email" placeholder="Email" required>

<input type="text" name="contact" placeholder="Contact">
<input type="date" name="dob">

<input type="text" name="year" placeholder="Year">
<input type="text" name="prn" placeholder="PRN" required>
<input type="text" name="department" placeholder="Department" required>

<!-- SUBJECT MARKS -->
<input type="number" name="dbms" placeholder="DBMS Marks">
<input type="number" name="cn" placeholder="CN Marks">
<input type="number" name="mp" placeholder="MP Marks">
<input type="number" name="daa" placeholder="DAA Marks">
<input type="number" name="oe" placeholder="OE Marks">

<button type="submit" name="action" value="add">Add Student Details</button>

</form>
</div>

<!-- ================= SEARCH ================= -->
<form method="get" action="dashboard.jsp" style="margin:15px;">
<input type="text" name="searchPrn" placeholder="Enter PRN to search">
<button type="submit">Search</button>
</form>

<!-- ================= TABLE ================= -->
<%
Connection con = Dbconnection.getConnection();

String searchPrn = request.getParameter("searchPrn");

PreparedStatement ps;

if(searchPrn != null && !searchPrn.isEmpty()){
    ps = con.prepareStatement("SELECT * FROM studentss1 WHERE prn=?");
    ps.setString(1, searchPrn);
} else {
    ps = con.prepareStatement("SELECT * FROM studentss1");
}

ResultSet rs = ps.executeQuery();
%>

<table border="1" width="100%">

<tr>
<th>PRN</th>
<th>Name</th>
<th>Email</th>
<th>Year</th>
<th>DOB</th>

<th>DBMS</th>
<th>CN</th>
<th>MP</th>
<th>DAA</th>
<th>OE</th>

<!-- ✅ ADDED -->
<th>Percentage</th>

<th>Action</th>
</tr>

<%
while(rs.next()){
    
    // ✅ CALCULATE PERCENTAGE HERE
    int dbms = rs.getInt("dbms");
    int cn   = rs.getInt("cn");
    int mp   = rs.getInt("mp");
    int daa  = rs.getInt("daa");
    int oe   = rs.getInt("oe");

    double percentage = (dbms + cn + mp + daa + oe) / 5.0;
%>

<tr>
<td><%=rs.getString("prn")%></td>
<td><%=rs.getString("name")%></td>
<td><%=rs.getString("email")%></td>
<td><%=rs.getString("year")%></td>
<td><%=rs.getString("dob")%></td>

<td><%=dbms%></td>
<td><%=cn%></td>
<td><%=mp%></td>
<td><%=daa%></td>
<td><%=oe%></td>

<!-- ✅ SHOW PERCENTAGE -->
<td><%=percentage%></td>

<td>

<!-- UPDATE -->
<a href="update.jsp?id=<%=rs.getInt("id")%>">
<button type="button">Update</button>
</a>

<!-- DELETE -->
<form action="StudentServlet" method="post" style="display:inline;">
<input type="hidden" name="id" value="<%=rs.getInt("id")%>">
<button type="submit" name="action" value="delete">Delete</button>
</form>

<!-- RECEIPT -->
<a href="receipt.jsp?id=<%=rs.getInt("id")%>">
<button type="button">Result</button>
</a>

</td>

</tr>

<%
}
con.close();
%>

</table>

</body>
</html>