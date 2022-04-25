<%@page import="java.sql.SQLException"%>
<%@page import="com.study.free.vo.FreeBoardVO"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%@include file="/WEB-INF/inc/header.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/inc/top.jsp"%>
	<%
		String boNo = request.getParameter("boNo");
		try {
			// 1. 드라이버 로드
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			System.out.println("OracleDriver를 찾을 수 없엉");
		}
		Connection conn = null; // 연결하는 객체
		Statement stmt = null; // 쿼리수행 객체
		ResultSet rs = null; // select의 경우 결과 저장 객체

		try {
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "jsp", "oracle");
			stmt = conn.createStatement();
			StringBuffer sb = new StringBuffer();
			sb.append(" SELECT                                          ");
			sb.append("	 	  bo_no       , bo_title    , bo_category  ");
			sb.append("	 	, bo_writer   , bo_pass     , bo_content   ");
			sb.append("	 	, bo_ip       , bo_hit      , bo_reg_date  ");
			sb.append("	 	, bo_mod_date , bo_del_yn                  ");
			sb.append(" FROM free_board                                 ");

			rs = stmt.executeQuery(sb.toString());

			if (rs.next()) {
				FreeBoardVO freeBoard = new FreeBoardVO();
				freeBoard.setBoNo(rs.getInt("bo_no"));
				freeBoard.setBoTitle(rs.getString("bo_title"));
				freeBoard.setBoCategory(rs.getString("bo_category"));
				freeBoard.setBoWriter(rs.getString("bo_writer"));
				freeBoard.setBoPass(rs.getString("bo_pass"));
				freeBoard.setBoContent(rs.getString("bo_content"));
				freeBoard.setBoIp(rs.getString("bo_ip"));
				freeBoard.setBoHit(rs.getInt("bo_hit"));
				freeBoard.setBoRegDate(rs.getString("bo_reg_date"));
				freeBoard.setBoModDate(rs.getString("bo_mod_date"));
				freeBoard.setBoDelYn(rs.getString("bo_del_yn"));
				request.setAttribute("freeBoard", freeBoard);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e) {
				}
			}
			if (stmt != null) {
				try {
					stmt.close();
				} catch (Exception e) {
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
				}
			}
		}
	%>


	<table class="table table-striped table-bordered">
		<tr>
			<th>글번호</th>
			<td>${freeBoard.boNo }</td>
		</tr>
		<tr>
			<th>글제목</th>
			<td>${freeBoard.boTitle }</td>
		<tr>
			<th>글 분류코드</th>
			<td>${freeBoard.boCategory }</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>${freeBoard.boWriter }</td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td>${freeBoard.boPass }</td>
		</tr>
		<tr>
			<th>글내용</th>
			<td>${freeBoard.boContent }</td>
		</tr>
		<tr>
			<th>등록자IP</th>
			<td>${freeBoard.boIp }</td>
		</tr>
		<tr>
			<th>조회수</th>
			<td>${freeBoard.boHit }</td>
		</tr>
		<tr>
			<th>등록일자</th>
			<td>${freeBoard.boRegDate }</td>
		</tr>
		<tr>
			<th>수정일자</th>
			<td>${freeBoard.boModDate }</td>
		</tr>
		<tr>
			<th>삭제여부</th>
			<td>${freeBoard.boDelYn }</td>
		</tr>


	</table>



</body>
</html>