<%@ page import="java.sql.*" %>
<%@ page import="codes.Dbconnection" %>
<!DOCTYPE html>
<html>
<head>
<title>Student Result</title>

<style>
body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: linear-gradient(135deg, #ece9e6, #ffffff);
    margin: 0;
    padding: 20px;
}

.receipt {
    width: 500px;
    margin: auto;
    background: #fff;
    padding: 25px;
    border-radius: 15px;
    box-shadow: 0 10px 25px rgba(0,0,0,0.15);
}

.header {
    text-align: center;
}

.header img {
    width: 70px;
}

.header h2 {
    color: #1976d2;;
    margin: 5px 0;
}

.info {
    margin-top: 10px;
}

table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 15px;
}

th {
    background: #1976d2;;
    color: white;
    padding: 10px;
}

td {
    padding: 8px;
    text-align: center;
    border-bottom: 1px solid #ddd;
}

.result {
    margin-top: 15px;
    padding: 10px;
    background: #f4f6f8;
    border-radius: 10px;
}

.gradeA { color: green; font-weight: bold; }
.gradeB { color: blue; font-weight: bold; }
.gradeC { color: orange; font-weight: bold; }
.fail { color: red; font-weight: bold; }

button {
    width: 100%;
    margin-top: 15px;
    padding: 10px;
    background: #1976d2;;
    color: #fff;
    border: none;
    border-radius: 8px;
    cursor: pointer;
}
</style>

</head>
<body>

<div class="receipt">

<%
String idStr = request.getParameter("id");

if(idStr == null){
    out.println("<h3>Error: ID not found</h3>");
    return;
}

int id = Integer.parseInt(idStr);

Connection con = Dbconnection.getConnection();
PreparedStatement ps = con.prepareStatement("SELECT * FROM studentss1 WHERE id=?");
ps.setInt(1, id);
ResultSet rs = ps.executeQuery();

if(rs.next()){

int dbms = rs.getInt("dbms");
int cn = rs.getInt("cn");
int mp = rs.getInt("mp");
int daa = rs.getInt("daa");
int oe = rs.getInt("oe");

int total = dbms + cn + mp + daa + oe;
double percentage = total / 5.0;

String grade;
String gclass;

if(percentage >= 75){ grade="A"; gclass="gradeA"; }
else if(percentage >= 60){ grade="B"; gclass="gradeB"; }
else if(percentage >= 50){ grade="C"; gclass="gradeC"; }
else { grade="Fail"; gclass="fail"; }
%>

<!-- HEADER -->
<div class="header">
   
    <h2>SNJB's Late Sau. Kantabai Bhavarlalji Jain College of Engineering (SNJB COE), Chandwad</h2>
</div>

<hr>

<!-- STUDENT INFO -->
<div class="info">
<b>Name:</b> <%=rs.getString("name")%><br>
<b>PRN:</b> <%=rs.getString("prn")%>
</div>

<!-- MARKS TABLE -->
<table>
<tr><th>Subject</th><th>Marks</th></tr>
<tr><td>DBMS</td><td><%=dbms%></td></tr>
<tr><td>CN</td><td><%=cn%></td></tr>
<tr><td>MP</td><td><%=mp%></td></tr>
<tr><td>DAA</td><td><%=daa%></td></tr>
<tr><td>OE</td><td><%=oe%></td></tr>
</table>

<!-- RESULT -->
<div class="result">
<b>Total: <%=total%></b><br>
<b>Percentage: <%=String.format("%.2f", percentage)%>%</b><br>
<b>Grade: <span class="<%=gclass%>"><%=grade%></span></b>
</div>

<button onclick="window.print()">Print</button>

<%
}
con.close();
%>

</div>

</body>
</html>