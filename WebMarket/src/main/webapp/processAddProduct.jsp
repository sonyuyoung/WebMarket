<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="dto.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="dbconn.jsp" %>
	<% 
		request.setCharacterEncoding("UTF-8");
	
		String realFolder = "C:\\upload";
		int maxSize = 5*1024*1024;
		String encType = "UTF-8";
		
		MultipartRequest multi = new MultipartRequest(request,
				realFolder,maxSize,encType
				, new DefaultFileRenamePolicy());
		
		//SQL문 선언 및 각각의 데이터를 SQL문에 저장
		PreparedStatement pstmt = null;
		String sql = "INSERT INTO product VALUES(?,?,?,?,?,?,?,?,?)";
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, multi.getParameter("productId"));
		pstmt.setString(2, multi.getParameter("name"));
		
		//가격 문자열의 정수형 변환 처리
		String unitPrice = multi.getParameter("unitPrice");
		Integer price;
		if(unitPrice.isEmpty()){
			price = 0;
		}else{
			price = Integer.valueOf(unitPrice);
		}
		pstmt.setInt(3, price);
		
		pstmt.setString(4, multi.getParameter("description"));
		pstmt.setString(5, multi.getParameter("manufacturer"));
		pstmt.setString(6, multi.getParameter("category"));
		
		//재고 수 문자열의 long형 변환 처리
		String unitInStock = multi.getParameter("unitsInStock");
		long stock;
		if(unitInStock == null && unitInStock.isEmpty() ){
			stock = 0;
		}else{
			stock = Long.valueOf(unitInStock);
		}
		pstmt.setLong(7, stock);
		pstmt.setString(8, multi.getParameter("condition"));
		
		Enumeration files = multi.getFileNames();
		String fName = (String)files.nextElement();
		String fileName = multi.getFilesystemName(fName);
		pstmt.setString(9, fileName);
		
		//SQL문 실행
		pstmt.executeUpdate();
		
		if(pstmt!=null){
			pstmt.close();
		}
		if(conn!=null){
			conn.close();
		}
		
		response.sendRedirect("products.jsp");
	%>
	
	
	
	
	
	
	
	
	
	
	
	
	
	