<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.Date" %>

<%@ page import="DBPKG.DBConnection" %>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
Connection 	conn = null;	// DBMS를 연결하는 객체
Statement 	stmt = null;	// 쿼리를 처리하는 객체
ResultSet	rset = null;	// 쿼리 결과를 저장하는 객체
int result = 0;

String custno = null;
String custname = null;
String phone = null;
String address = null;
String joindate = null;
String grade = null;
String city = null;


//데이터를 가지고온다.
request.setCharacterEncoding("UTF-8");

custno 	= request.getParameter("custno");
custname= request.getParameter("custname");
phone 	= request.getParameter("phone");
address = request.getParameter("address");
joindate= request.getParameter("joindate");
joindate = joindate.replaceAll("-", "");

grade 	= request.getParameter("grade");
city 	= request.getParameter("city");

// 데이터를 가지고 SQL 쿼리를 만든다.
String sql = "UPDATE MEMBER_TBL_02 SET " + 
				"custname='" + custname + "', " +
				"phone='" + phone + "', " +
				"address='" + address + "', " +
				"joindate=to_date('" + joindate + "', 'yyyy-mm-dd')," +
				"grade='" + grade + "', " +
				"city='" + city + "'" +
				" WHERE custno='" + custno + "'";

try 
{
	// 1. DBMS에 연결을 한다.
	conn = DBConnection.getConnection();
		
	// 2. 쿼리를 전송한다.
	stmt = conn.createStatement();
	result = stmt.executeUpdate(sql);
		
	// 결과가 정상적이면 commit
	if (result == 1)
	{
		// INSERT문을 commit시킨다.
		if (false == conn.getAutoCommit())
			conn.commit();
		
	}
	
	
	// 정리한다.
	stmt.close();
	conn.close();
		
	
	
}
catch(Exception excp)
{
	System.out.println("[ERROR] " + excp.getMessage());
	excp.printStackTrace();
		

}
finally
{
	out.println("<h1>" + result + "</h1>");

}


%>

<script>
(()=>{
	
	const resultElem = document.querySelector("h1");
	
	if (resultElem.textContent == '1')
	{
		alert("회원정보를 저장하였습니다.");
		
	}
	else
	{
		alert("회원정보를 저장에 실패하였습니다.");
	}
	
	
	parent.location.reload();
	
	
	
})();



</script>
</body>
</html>