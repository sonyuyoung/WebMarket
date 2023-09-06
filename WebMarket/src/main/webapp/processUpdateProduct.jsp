<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="dto.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="dbconn.jsp" %>
	<% 
	
		String realFolder = "C:\\upload";
		int maxSize = 5*1024*1024;
		String encType = "UTF-8";
		
		MultipartRequest multi = new MultipartRequest(request,
				realFolder,maxSize,encType
				, new DefaultFileRenamePolicy());
		
		//파일이름 가져오기
		Enumeration files = multi.getFileNames();
		String fName = (String)files.nextElement();
		String fileName = multi.getFilesystemName(fName);
		
		//SQL문 선언 및 각각의 데이터를 SQL문에 저장
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT * FROM product WHERE p_id=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,multi.getParameter("productId"));
		rs = pstmt.executeQuery();
		if(rs.next()){
			if(fileName != null){
				sql = "UPDATE product SET p_name=? ,p_unitPrice=? , p_description=? ,"+
						"p_manufacturer=? , p_category=? , p_unitsInStock=?"+ 
						", p_condition=? , p_fileName=? WHERE p_id = ?";
				
			}else{
				sql = "UPDATE product SET p_name=? ,p_unitPrice=? , p_description=? ,"+
						"p_manufacturer=? , p_category=? , p_unitsInStock=?"+ 
						", p_condition=? WHERE p_id = ?";
			}
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, multi.getParameter("name"));
			
			//가격 문자열의 정수형 변환 처리
			String unitPrice = multi.getParameter("unitPrice");
			Integer price;
			if(unitPrice.isEmpty()){
				price = 0;
			}else{
				price = Integer.valueOf(unitPrice);
			}
			pstmt.setInt(2, price);
			
			pstmt.setString(3, multi.getParameter("description"));
			pstmt.setString(4, multi.getParameter("manufacturer"));
			pstmt.setString(5, multi.getParameter("category"));
			
			//재고 수 문자열의 long형 변환 처리
			String unitInStock = multi.getParameter("unitsInStock");
			long stock;
			if(unitInStock == null && unitInStock.isEmpty() ){
				stock = 0;
			}else{
				stock = Long.valueOf(unitInStock);
			}
			pstmt.setLong(6, stock);
			pstmt.setString(7, multi.getParameter("condition"));
			
			if(fileName!=null){
				pstmt.setString(8,fileName);
				pstmt.setString(9, multi.getParameter("productId"));
			}else{
				pstmt.setString(8, multi.getParameter("productId"));
			}
			//SQL문 실행
			int flag = pstmt.executeUpdate();
			System.out.println("update flag : "+flag);
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
		
		response.sendRedirect("products.jsp");
	%>
	
	
	
	
	
	
	
	
	
	
	
	
	
	