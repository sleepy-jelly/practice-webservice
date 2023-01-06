<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ page import= "java.sql.Connection" %>
    <%@ page import= "java.sql.Statement" %>
    <%@ page import= "java.sql.ResultSet" %>
    
    <%@ page import= "DBPKG.DBConnection" %>
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEMBER TABLE</title>
</head>
<body>


<%
	 class SameKeyException extends Exception {
	  public SameKeyException(String message) {
	     super(message);

	 }
	}
	
	Connection conn = null;  // db connection obj;
	Statement stmt = null;	// statement obj;
	
	int result =0;
	
	request.setCharacterEncoding("UTF-8");

	String custno= request.getParameter("custno");
	String custname =request.getParameter("custname");
	String phone = request.getParameter("phone");
	String address= request.getParameter("address");
	String joindate = request.getParameter("joindate");
	String grade = request.getParameter("grade");
	String city = request.getParameter("city");
	String resultMessage =null;
	String sql = "INSERT INTO MEMBER_TBL_02 VALUES(" + custno + ", " + "'"+custname +"'" 
													+ ", "+"'" +phone+"'"+", " + "'"+address +"'"+
															", " + "'"+ joindate +"'"+
															", " + "'"+ grade +"'"+
															", " + "'"+ city +"'"+
															")";
			
	
	
	//1. connect with db. use with connection obj;   
	//2. create statement obj
	//3. send query 
	
	try{
		conn=DBConnection.getConnection();
		stmt = conn.createStatement();
		
		
		
		
		
		
		String sql2 = "SELECT * FROM MEMBER_TBL_02 WHERE custno = '" + custno + "'";
		ResultSet rs = stmt.executeQuery(sql2);
		
		
		
		
		 if (rs.next()) {
			 
				  //if there is value already exist
				  
			   throw new SameKeyException("Same Key already exists");
			} else {
			   // value does not exist
				//send query and check the result;
				result=stmt.executeUpdate(sql);
			}
		
		
		//commit insert
		if(false==conn.getAutoCommit()){
		conn.commit();
		}
		
		
		//closing
		stmt.close();
		conn.close();
		
		
		
	}catch(Exception excp){
		out.println("[Error]"+excp.getMessage());
		excp.getStackTrace();
	}finally{
		out.println("<h1>"+result +"</h1>");
		if(result==1){
			resultMessage = "저장에 성공 하였습니다.";
			
		}else{
			resultMessage = "저장에 실패 하였습니다.";

		}
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