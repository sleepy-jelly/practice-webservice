<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="DBPKG.DBConnection" %>    


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEMBER 테이블에 추가</title>
</head>
<body>

<%
	Connection 	conn = null;		// DB 연결 객체
	Statement	stmt = null;		// 쿼리전송을 위한 Statement 객체
	int result = 0;
	
	request.setCharacterEncoding("UTF-8");

	String custno 	= request.getParameter("custno");
	String custname = request.getParameter("custname");
	String phone	= request.getParameter("phone");
	String address 	= request.getParameter("address");
	
	
	String joindate = request.getParameter("joindate");
	joindate = joindate.replaceAll("-", "");
	String grade 	= request.getParameter("grade");
	String city		= request.getParameter("city");	
		
	String sql = "INSERT INTO MEMBER_TBL_02 VALUES(" + custno + ", " +
					"'" + custname + "', " + 
					"'" + phone + "', " +
					"'" + address + "', " +
					"'" + joindate + "', " +
					"'" + grade + "', " +
					"'" + city + "')";
	
	System.out.println(sql);
	
try
{
	// DB를 연결하여 준비된 쿼리를 전송한다.
	conn = DBConnection.getConnection();
	stmt = conn.createStatement();
	
	result = stmt.executeUpdate(sql);
	
	
	// INSERT문을 commit시킨다.
	if (false == conn.getAutoCommit())
		conn.commit();
	
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