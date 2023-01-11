<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="DBPKG.DBConnection" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="main.css">
<title>회원매출조회</title>
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
<h2>회원매출조회</h2>
<br>

<table>
<tr>
	<th style="width:80px;">회원번호</th>
	<th style="width:80px;">회원성명</th>
	<th style="width:80px;">고객등급</th>
	<th style="width:80px;">매출</th>
</tr>

<%
Connection 	conn = null;
Statement 	stmt = null;
ResultSet	rset = null;

String custno;
String custname;
String grade;
String price;

String sql = "SELECT me.custno, me.custname, me.grade, sum(mo.price) " + 
             "FROM MEMBER_TBL_02 me INNER JOIN MONEY_TBL_02 mo ON me.custno = mo.custno " + 
			 "GROUP BY me.custno, me.custname, me.grade " + 
             "ORDER BY sum(mo.price) DESC";

System.out.println(sql);
  
try
{
	conn = DBConnection.getConnection();
	stmt = conn.createStatement();
	rset = stmt.executeQuery(sql);
	
	while(rset.next())
	{
		custno 	= rset.getString(1);
		custname= rset.getString(2);
		grade 	= rset.getString(3);
		price 	= rset.getString(4);

		switch(grade)
		{
		case "A": grade = "VIP"; break;
		case "B": grade = "일반"; break;
		case "C": grade = "직원"; break;
		default : grade = "미정"; break;	
		
		}
%>
		<tr>
			<td><%= custno %></td>
			<td><%= custname %></td>
			<td><%= grade %></td>
			<td><%= price %></td>		
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