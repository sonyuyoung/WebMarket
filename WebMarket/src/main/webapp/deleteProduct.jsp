<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="dto.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="dbconn.jsp" %>
	<% 
		String productId = request.getParameter("id");
		
		String sql = "SELECT * FROM product";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		
		if(rs.next()){
			sql = "DELETE FROM product WHERE p_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,productId);
			pstmt.executeUpdate();
		}else{
			out.println("일치하는 상품이 없습니다.");
		}
		
		if(rs!=null){
			rs.close();
		}
		if(pstmt!=null){
			pstmt.close();
		}
		if(conn!=null){
			conn.close();
		}
		
		response.sendRedirect("editProduct.jsp?edit=delete");
	%>
	
	
	
	
	
	
	
	
	
	
	
	
	
	