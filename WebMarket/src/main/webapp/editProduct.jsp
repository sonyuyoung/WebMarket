<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="dto.Product"%>
<%@page import="java.util.Date"%>
<%-- <jsp:useBean id="productDAO" class="dao.ProductRepository" scope="session" /> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 편집</title>
<script type="text/javascript">
	function deleteConfirm(id){
		if(confirm("해당 상품을 삭제합니다!!") == true){
			location.href = "./deleteProduct.jsp?id=" + id;
		}else{
			return;
		}
	}
</script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
</head>
<body>
<%@ include file = "menu.jsp" %>
<%-- <jsp:include page = "menu.jsp"> --%>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">
				상품 편집
			</h1>
		</div>
	</div>
	<div class="container">
		<div class="row" align="center">
			<%@ include file="dbconn.jsp" %>
			<% 
				String edit = request.getParameter("edit");
			
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				
				String sql = "SELECT * FROM product";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while(rs.next()){
			%>
			<div class="col-md-4">
			<img src="/upload/<%=rs.getString("p_fileName")%>"
				style="width:100%;">
				<h3><%=rs.getString("p_name") %></h3>
				<p><%=rs.getString("p_description") %></p>
				<p><%=rs.getString("p_unitPrice") %>원</p>
				<p><%
						if(edit.equals("update")){
					%>
						<a href="./updateProduct.jsp?id=<%=rs.getString("p_id")%>"
						class="btn btn-success" role="button">수정 &raquo;</a>
					<%} else if(edit.equals("delete")){%>
						<a href="#" onclick="deleteConfirm('<%=rs.getString("p_id")%>')"
						class="btn btn-danger" role="button">삭제 &raquo;</a>
					<%} %>
				</p>
			</div>
			<%} 
				if(rs!=null){
					rs.close();
				}
				if(pstmt!=null){
					pstmt.close();
				}
				if(conn!=null){
					conn.close();
				}
			%>
		</div>
		<hr>
	</div>
<%@ include file = "footer.jsp" %>
</body>
</html>









