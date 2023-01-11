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
<title>홈쇼핑 회원 정보 수정</title>
<link rel="stylesheet" href="main.css">
</head>


<body>
<%
Connection 	conn = null;	// DBMS를 연결하는 객체
Statement 	stmt = null;	// 쿼리를 처리하는 객체
ResultSet	rset = null;	// 쿼리 결과를 저장하는 객체

String custname = null;
String phone = null;
String address = null;
Date joindate = null;
String grade = null;
String city = null;


String custno = request.getParameter("custno");
String sql = "SELECT * FROM MEMBER_TBL_02 WHERE custno=" + custno;

try
{
	conn = DBConnection.getConnection();
	stmt = conn.createStatement();
	rset = stmt.executeQuery(sql);
	
	
	while(rset.next())
	{
		custname = rset.getString("custname");
		phone = rset.getString("phone");
		address = rset.getString("address");
		
		System.out.println(address);
		
		joindate = rset.getDate("joindate");
		grade = rset.getString("grade");
		city = rset.getString("city");
		
	}
	
	rset.close();
	stmt.close();
	conn.close();

}
catch(Exception excp)
{
	System.out.println("[ERROR] " + excp.getMessage());
	excp.printStackTrace();
	
}

%>
<header>
	<h1>쇼핑몰 회원관리  ver1.0</h1>
</header>

<nav>
	<a href="register.jsp">회원등록</a>
	<a href="inquiry.jsp">회원목록조회/수정</a>
	<a href="#">회원매출조회</a>
	<a href="index.jsp">홈으로</a>
</nav>

<section>
<br>
<h2>홈쇼핑 회원 정보 수정</h2>
<br>

<form id="id_modForm" method="post" name="modForm">
<table style="width:500px">
<tr>
	<td>회원번호</td>
	<td><input type="text" id="id_custno" name="custno" value="<%= custno %>" readonly></td>
</tr>
<tr>
	<td>회원성명</td>     
	<td><input type="text" id="id_custname" name="custname" value="<%= custname %>"></td>
</tr>
<tr>
	<td>전화번호</td>
	<td><input type="text" id="id_phone" name="phone" value="<%= phone %>"></td>
</tr>
<tr>
	<td>회원주소</td>
	<td><input type="text" id="id_address" name="address" value="<%= address %>"></td>
</tr>
<tr>
	<td>가입일자</td>
	<td><input type="text" id="id_joindate" name="joindate" value="<%= joindate %>"></td>
</tr>
<tr>
	<td>고객등급[A:VIP, B:일반, C:직원]</td>
	<td><input type="text" id="id_grade" name="grade" value="<%= grade %>"></td>
</tr>
<tr>
	<td>도시코드</td>
	<td><input type="text" id="id_city" name="city" value="<%= city %>"></td>
</tr>


</table>
</form>
<table style="width:500px">
<tr>
	<td colspan="2"><button id="id_saveMember">저장</button> <button id="id_inqMember">조회</button></td>	
</tr>
</table>
</section>

<footer>
	<h4>HRDKOREA Copyrightⓒ2016 All rights reserved. Human Resources Development Service of Korea.</h4>
</footer>

<iframe name="hiddenframe" style="display:none"></iframe> 

<script>

(()=>{
	// 1. 폼 도큐먼트 오브젝트를 가지고 온다.
	const frmMod 		= document.querySelector('#id_modForm');		// 폼
	
	const btnSavMember 	= document.querySelector('#id_saveMember');	// 저장 버튼
	const btnInqMember 	= document.querySelector('#id_inqMember');	// 조회 버튼
	
	const objs = [
		// {객체, 메시지, 메시지}
		{box : document.querySelector("#id_custname"),	size : 20, 	nodataMsg : '회원성명이 입력되지 않습니다.', 	invalidMsg : '회원성명 데이터가 잘못되었습니다.'},
		{box : document.querySelector("#id_phone"), 	size : 13,	nodataMsg : '회원전화가 입력되지 않습니다.', 	invalidMsg : '회원전화 데이터가 잘못되었습니다.'},
		{box : document.querySelector("#id_address"), 	size : 60,	nodataMsg : '회원주소가 입력되지 않습니다.', 	invalidMsg : '회원주소 데이터가 잘못되었습니다.'},
		{box : document.querySelector("#id_joindate"), 	size : 10,	nodataMsg : '가입일자가 입력되지 않습니다.', 	invalidMsg : '가입일자 데이터가 잘못되었습니다.'},
		{box : document.querySelector("#id_grade"), 	size : 1,	nodataMsg : '고객등급이 입력되지 않습니다.', 	invalidMsg : '고객등급 데이터가 잘못되었습니다.'},
		{box : document.querySelector("#id_city"), 		size : 2,	nodataMsg : '도시코드가 입력되지 않습니다.', 	invalidMsg : '도시코드 데이터가 잘못되었습니다.'}
		
	];
	
	
	
	// 모든 입력 박스에 데이터가 존재한다면 true;
	const checkDataExist = function()
	{		
		for (let i = 0; i < objs.length; i++)
		{
			if (objs[i].box.value.length === 0)
				return i;
			
		}
		
		return true;
		
	}
	
	
	const checkDataValid = function()
	{
		// box들의 데이터 길이를 검사
		for (let i = 0; i < objs.length; i++)
		{
			if (objs[i].box.value.length > objs[i].size)
				return i;
						
		}
		
		let date = objs[3].box.value.replaceAll("-", "");
		
		// 가입일자는 숫자
		if (true == isNaN(date))
		{
			return 3;
		}
		
		
		// 고객등급은 문자
		if (false == isNaN(objs[4].box.value))
		{
			return 4;
		}
		
		// 도시코드는 숫자
		if (true == isNaN(objs[5].box.value))
		{
			return 5;
		}
		
		return true;
	}
	
	btnSavMember.addEventListener('click', ()=>{

		let res;
		
		// 데이터가 존재 하는지 판단.
		res = checkDataExist();
		
		if (true !== res)
		{
			// 문제되는 객체에 해당하는 메시지를 출력
			alert(objs[res].nodataMsg);
			objs[res].box.focus();		
			return;
			
		}
		
		
		res = checkDataValid();
		
		if (true !== res)
		{
			// 문제되는 객체에 해당하는 메시지를 출력
			alert(objs[res].invalidMsg);
			objs[res].box.focus();	
			return;
			
		} 
		
		
		//------------------->
		// 폼데이터가 전달될 URL설정
		frmMod.action = "update.jsp";
		frmMod.target = "hiddenframe";		 
		frmMod.submit();
				
	});
	
	
	btnInqMember.addEventListener('click', ()=>{
		location.href = 'inquiry.jsp';		
	
	});
	
	
	
		
})();




</script>
</body>
</html>