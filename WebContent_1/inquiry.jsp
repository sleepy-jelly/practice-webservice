<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="DBPKG.DBConnection" %>

<%@ page import="java.util.Date" %>




<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원목록 조회/수정</title>
<link rel="stylesheet" href="main.css">
</head>
<body>
   
<header>
   	<h1>쇼핑몰 회원관리  ver1.0</h1>
</header>

<nav>
	<a href="register.jsp">회원등록</a>
	<a href="inquiry.jsp">회원목록조회/수정</a>
	<a href="sale.jsp">회원매출조회</a>
	<a href="index.jsp">홈으로</a>
</nav>    

<section>
	<br>
	<h2>회원목록조회/수정</h2>
	<br>
	
	<table>
		<tr>
			<th style="width:80px;">회원번호</th>
			<th style="width:80px;">회원성명</th>
			<th style="width:130px;">전화번호</th>
			<th style="width:200px;">주소</th>
			<th style="width:120px;">가입일자</th>
			<th style="width:80px;">고객등급</th>
			<th style="width:80px;">거주지역</th>
		</tr>
	
<%
	Connection  conn = null;
	Statement	stmt = null;
	ResultSet 	rset = null;
	
	String sql = "SELECT * FROM MEMBER_TBL_02 ORDER BY custno";
	
	String custno;
	String custname;
	String phone;
	String address;
	Date joindate;
	String grade;
	String city;	
	
try 
{
	conn = DBConnection.getConnection();
	stmt = conn.createStatement();	
	
	rset = stmt.executeQuery(sql);
	
	
	while(rset.next())
	{				
		custno 		= rset.getString("custno");
		custname 	= rset.getString("custname");
		phone		= rset.getString("phone");
		address		= rset.getString("address");
		joindate	= rset.getDate("joindate");
		grade		= rset.getString("grade");
		city		= rset.getString("city");
		
		switch(grade)
		{
			case "A" : grade = "VIP"; break;
			case "B" : grade = "일반"; break;
			case "C" : grade = "직원"; break;
			default  : grade = "미정"; break;
			
		}
		
%>
		<!-- tr을 추가. -->
		<tr>
			<td><a href="modify.jsp?custno=<%= custno %>"><%= custno %></a></td>
			<td><%= custname %></td>
			<td><%= phone %></td>
			<td><%= address %></td>
			<td><%= joindate %></td>
			<td><%= grade %></td>
			<td><%= city %></td>		
		</tr>	



<%


	}
	
	
}
catch(Exception excp)
{
	System.out.println("[ERROR] " + excp.getMessage());
	excp.printStackTrace();

}

%>
	
	</table>

</section>

<footer>
	<h4>HRDKOREA Copyrightⓒ2016 All rights reserved. Human Resources Development Service of Korea.</h4>
</footer>

</body>
</html>