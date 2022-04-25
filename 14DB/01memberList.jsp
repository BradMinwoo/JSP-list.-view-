<%@page import="com.study.member.vo.MemberVO"%>
<%@page import="java.lang.reflect.Member"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
<%@page
	import="org.apache.tomcat.dbcp.dbcp2.DriverManagerConnectionFactory"%>
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
<%
	request.setCharacterEncoding("utf-8");
%>
<%@include file="/WEB-INF/inc/header.jsp"%>
<body>
	<%@include file="/WEB-INF/inc/top.jsp"%>

	<%
	
	//#순서는 암기 해주세요#
	// 1. 로드 -> 2. 연결 -> 3.쿼리 수행 -> 4. 종료

		//SQLException 
		try {
			//1.로드
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			System.out.println("OracleDriver를 찾을수 없엉");
		}
		// 2. 연결
		Connection conn = null; // 연결하는 객체
		Statement stmt = null; // 쿼리수행 객체
		ResultSet rs = null; // select의 경우 결과 저장 객체

		try {
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "jsp", "oracle"); //2. 연결
			//3.쿼리수행
			// 왠만하면 select는 디비에서 다 가져와서 .. 편집해서 화면에 출력할것만 따로 ~!
			stmt = conn.createStatement();
			StringBuffer sb = new StringBuffer();
			sb.append(" SELECT											");
			sb.append("      mem_id     , mem_pass    , mem_name		");
			sb.append("    , mem_bir    , mem_zip     , mem_add1		");
			sb.append("    , mem_add2   , mem_hp      , mem_mail		");
			sb.append("    , mem_job    , mem_hobby   , mem_mileage	");
			sb.append("    , mem_del_yn									");
			sb.append(" FROM member										");	
			rs = stmt.executeQuery(sb.toString()); // ;쓰지마
			List<MemberVO> memberList = new ArrayList<>();
			while(rs.next()){
				MemberVO member = new MemberVO();
				member.setMemId(rs.getString("mem_id"));				member.setMemPass(rs.getString("mem_pass"));
				member.setMemName(rs.getString("mem_name"));				member.setMemBir(rs.getString("mem_bir"));
				member.setMemZip(rs.getString("mem_zip"));				member.setMemAdd1(rs.getString("mem_add1"));
				member.setMemAdd2(rs.getString("mem_add2"));				member.setMemHp(rs.getString("mem_hp"));
				member.setMemMail(rs.getString("mem_mail"));	member.setMemJob(rs.getString("mem_job"));
				member.setMemHobby(rs.getString("mem_hobby"));	member.setMemMileage(rs.getInt("mem_mileage"));
				member.setMemDelYn(rs.getString("mem_del_yn"));
				//실수 : list에 안담아....
				memberList.add(member);
			}
			//실수 : setArribute를 안해..... 그럼 데이타 안나와
				request.setAttribute("memberList",memberList);
				
		} catch (SQLException e) {
		e.printStackTrace();
		} finally {
		// 4. 종료
		if(rs!=null){     try {rs.close();}   catch(Exception e){}}
		if(stmt!=null){ try {stmt.close();} catch(Exception e){}}
		if(conn!=null){ try {conn.close();} catch(Exception e){}}

		}
		
	%>
	<table class="table table-striped table-bordered">
		<tbody>
			<c:forEach items="${memberList }" var="member">
				<tr>
<%-- 					<td>${member.memId }</td> --%>
					<td><a href="01memberView.jsp?memId=${member.memId }">${member.memId }</a></td>
					<td>${member.memName }</td>
					<td>${member.memBir }</td>
					<td>${member.memZip }</td>
					<td>${member.memMail }</td>
				</tr>
			</c:forEach>		
		</tbody>
	</table>
	
	
	<%
	
	
// 제발 commit하세요!!! (에러가 안남, 데이터도 안나와...... 의심 하시오!!!)
//순서순서순선순서순서!!!!!!!!!!!!!!JDBC 코딩 순서
// 1. 드라이버 로드
// 2. 연결
// 3. 쿼리행 및 여러가지
// 4. 여러가지
	%>




</body>
</html>