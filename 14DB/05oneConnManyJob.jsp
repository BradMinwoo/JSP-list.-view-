<%@page import="java.sql.DriverManager"%>
<%@page import="org.apache.tomcat.dbcp.dbcp2.DriverManagerConnectionFactory"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="javax.servlet.jsp.jstl.sql.Result"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%request.setCharacterEncoding("utf-8"); %>
<%@include file="/WEB-INF/inc/header.jsp"%>
<body>
<%@include file="/WEB-INF/inc/top.jsp"%>
<%
	Class.forName("oracle.jdbc.driver.OracleDriver");
	long startTimes = System.currentTimeMillis();
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs =null;
	
	try{
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "jsp", "oracle");
		stmt = conn.createStatement();
		for(int i = 0 ; i<1000 ; i++){
		rs= stmt.executeQuery("select * from member");
			
		}
				
	}catch(SQLException e){
		e.printStackTrace();
		
	}finally{
		if(conn !=null) conn.close();
		if(stmt !=null) stmt.close();
		if(rs !=null) rs.close();
	}
	long endTimes = System.currentTimeMillis();
	out.print("걸린시간 : "+(endTimes - startTimes) ); // 100~200

%>
</body>
</html>