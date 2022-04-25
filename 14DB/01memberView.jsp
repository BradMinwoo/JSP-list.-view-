<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.study.member.vo.MemberVO"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
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
	String memId = request.getParameter("memId");
	
	Connection conn = null; // 연결하는 객체
	PreparedStatement pstmt = null;

	ResultSet rs = null; // select의 경우 결과 저장 객체
	
	try {
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "jsp", "oracle"); //2. 연결
		//3.쿼리수행
		// 왠만하면 select는 디비에서 다 가져와서 .. 편집해서 화면에 출력할것만 따로 ~!
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT											");
		sb.append("      mem_id     , mem_pass    , mem_name		");
		sb.append("    , mem_bir    , mem_zip     , mem_add1		");
		sb.append("    , mem_add2   , mem_hp      , mem_mail		");
		sb.append("    , mem_job    , mem_hobby   , mem_mileage	");
		sb.append("    , mem_del_yn									");
		sb.append(" FROM member										");	
		sb.append(" WHERE mem_id =?									");
		
		pstmt = conn.prepareStatement(sb.toString());		
		pstmt.setString(1, memId); // '' 신경 x pstmt가 알아서 잘 넣어줘용

		rs=pstmt.executeQuery();
		
		
		if(rs.next()){
			MemberVO member = new MemberVO();
			member.setMemId(rs.getString("mem_id"));			member.setMemPass(rs.getString("mem_pass"));
			member.setMemName(rs.getString("mem_name"));		member.setMemBir(rs.getString("mem_bir"));
			member.setMemZip(rs.getString("mem_zip"));		member.setMemAdd1(rs.getString("mem_add1"));
			member.setMemAdd2(rs.getString("mem_add2"));		member.setMemHp(rs.getString("mem_hp"));
			member.setMemMail(rs.getString("mem_mail"));		member.setMemJob(rs.getString("mem_job"));
			member.setMemHobby(rs.getString("mem_hobby"));	member.setMemMileage(rs.getInt("mem_mileage"));
			member.setMemDelYn(rs.getString("mem_del_yn"));
			request.setAttribute("member", member);
		}
		//실수 : setArribute를 안해..... 그럼 데이타 안나와
// 			request.setAttribute("memberList",memberList);
			
	} catch (SQLException e) {
	e.printStackTrace();
	} finally {
	// 4. 종료
	if(rs!=null){     try {rs.close();}   catch(Exception e){}}
	if(pstmt!=null){ try {pstmt.close();} catch(Exception e){}}
	if(conn!=null){ try {conn.close();} catch(Exception e){}}
	
	}
 
%>
<%-- ${member } --%>
<!-- 파라미터 존재여부!!!그러므로 LIST에서 들어가거나 파라미터를 쓰시오  -->
<table  class="table  table=striped table-bordered">
	<tr>
		<th>memId</th>
		<th> ${member.memId}</th>
	</tr>
	<tr>
		<th>memName</th>
		<th>${member.memName}</th>
	</tr>
	<tr>
		<th>memBir</th>
		<th>${member.memBir}</th>
	</tr>
	<tr>
		<th>memZip</th>
		<th>${member.memZip}</th>
	</tr>
	<tr>
		<th>주소</th>
		<th>  ${member.memAdd1 } ${member.memAdd2 }</th>
	</tr>
	<tr>
		<th> 전화번호</th>
		<th>${member.memHp}</th>
	</tr>
	<tr>
		<th>메일</th>
		<th>${member.memMail}</th>
	</tr>
	<tr>
		<th>직업</th>
		<th>${member.memJob}</th>
	</tr>
	<tr>
		<th>취미</th>
		<th>${meber.memHobby }</th>
	</tr>
	<tr>
		<th>마일리지</th>
		<th>${meber.memHobby }</th>
	</tr>
	<tr>
		<th>ㅈ</th>
		<th>${meber.memDelYn }</th>
	</tr>
	

</table>


</body>
</html>