<%@page import="java.util.ArrayList"%>
<%@page import="dto.Product"%>
<%@page import="dao.ProductRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="dbconn.jsp" %>
<%
	String id = request.getParameter("id");
	if(id == null || id.trim().equals("")){
		response.sendRedirect("products.jsp");
		return;
	}

	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String sql = "SELECT * FROM product WHERE p_id = ?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1,id);
	rs = pstmt.executeQuery();
	
	if(!rs.next()){
		response.sendRedirect("excpetionNoProductId.jsp");
	}
	
	sql = "SELECT * FROM product";
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	
	ArrayList<Product> goodsList = new ArrayList<Product>();
	
	while(rs.next()){
		Product product = new Product();
		product.setProductId(rs.getString("p_id"));
		product.setPname(rs.getString("p_name"));
		product.setUnitPrice(rs.getInt("p_unitPrice"));
		product.setDescription(rs.getString("p_description"));
		product.setCategory(rs.getString("p_category"));
		product.setMenufacturer(rs.getString("p_manufacturer"));
		product.setUnitsInStock(rs.getLong("p_unitsInStock"));
		product.setCondition(rs.getString("p_condition"));
		product.setFilename(rs.getString("p_fileName"));
		goodsList.add(product);
	}
	
	Product goods = new Product();
	for(int i=0; i<goodsList.size(); i++){
		goods = goodsList.get(i);
		if(goods.getProductId().equals(id)){
			break;
		}
	}
	
	ArrayList<Product> list = (ArrayList<Product>) session.getAttribute("cartlist");
	if(list == null){
		list = new ArrayList<Product>();
		session.setAttribute("cartlist", list);
	}
	
	int cnt = 0;
	Product goodsQnt = new Product();
	for(int i=0; i<list.size(); i++){
		goodsQnt = list.get(i);
		if(goodsQnt.getProductId().equals(id)){
			cnt++;
			int orderQuantity = goodsQnt.getQuantity() + 1;
			goodsQnt.setQuantity(orderQuantity);
		}
	}
	if(cnt==0){
		goods.setQuantity(1);
		list.add(goods);
	}
	
	response.sendRedirect("product.jsp?id=" + id);
%>









