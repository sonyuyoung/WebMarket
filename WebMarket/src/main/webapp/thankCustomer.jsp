<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<title>주문 완료</title>
</head>
<body>
	<%
		String Shipping_cartId = "";
		String Shipping_name = "";
		String Shipping_shippingDate = "";
		String Shipping_country = "";
		String Shipping_zipCode = "";
		String Shipping_addressName = "";
		
		Cookie[] cookies = request.getCookies();
		
		if(cookies!=null){
			for(int i=0; i<cookies.length; i++){
				Cookie thisCookie = cookies[i];
				String n = thisCookie.getName();
				if(n.equals("Shipping_cartId")){
					Shipping_cartId = URLDecoder.decode((thisCookie.getValue()),"utf-8");
				}
				if(n.equals("Shipping_shippingDate")){
					Shipping_shippingDate = URLDecoder.decode((thisCookie.getValue()),"utf-8");
				}
			}
		}
	%>
	<%@ include file = "menu.jsp" %>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">주문 완료</h1>
		</div>
	</div>
	<div class="container">
		<h2 class="alert alert-danger">주문해주셔서 감사합니다.</h2>
		<p>주문은 <%=Shipping_shippingDate %>에 배송될 예정입니다.</p>
		<p>주문번호 : <%=Shipping_cartId %></p>
	</div>
	<div class="container">
		<p><a href="./products.jsp" class="btn btn-secondary"> &laquo; 상품 목록</a>
	</div>
	<%@ include file = "footer.jsp" %>
</body>
</html>
<%
	session.invalidate();

if(cookies!=null){
	for(int i=0; i<cookies.length; i++){
		Cookie thisCookie = cookies[i];
		String n = thisCookie.getName();
		if(n.equals("Shipping_cartId")){
			thisCookie.setMaxAge(0);
		}else if(n.equals("Shipping_name")){
			thisCookie.setMaxAge(0);
		}else if(n.equals("Shipping_shippingDate")){
			thisCookie.setMaxAge(0);
		}else if(n.equals("Shipping_country")){
			thisCookie.setMaxAge(0);
		}else if(n.equals("Shipping_zipCode")){
			thisCookie.setMaxAge(0);
		}else if(n.equals("Shipping_addressName")){
			thisCookie.setMaxAge(0);
		}
		
		response.addCookie(thisCookie);
	}
}
%>












