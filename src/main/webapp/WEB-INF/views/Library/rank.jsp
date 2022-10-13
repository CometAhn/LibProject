<%@page import="org.apache.jasper.tagplugins.jstl.core.If"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String sessionId = (String) session.getAttribute("sessionId");
%>
<!DOCTYPE html>
<html>
<head>
<!-- Google tag (gtag.js) -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-1N3FJ1ETYL"></script>
<script>
	window.dataLayer = window.dataLayer || [];
	function gtag() {
		dataLayer.push(arguments);
	}
	gtag('js', new Date());

	gtag('config', 'G-1N3FJ1ETYL');
</script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>
<script src="/js/loading.js"></script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link href="http://localhost/css/loading.css" rel="stylesheet">
<script src="https://kit.fontawesome.com/e561738355.js" crossorigin="anonymous"></script>
<title>순위</title>
</head>
<body>
	<div id="loading">
		<img id="loading-image" src="/images/loading.gif" alt="Loading..." />
	</div>
	<jsp:include page="./menu.jsp" />
	<!-- 첫번째 섹션 -->

	<div class="container">
		<h1 class="text-center p-3">리뷰 TOP 3</h1>
		<div class="mx-auto w-50 p-3 border border-dark border-opacity-25 rounded d-flex justify-content-center">
			<table class="table table-hover">
				<thead class="text-center">
					<tr>
						<th scope="col">순위</th>
						<th scope="col">아이디(이름)</th>
						<th scope="col">작성한 리뷰 수</th>
					</tr>
				</thead>
				<tbody class="text-center">
					<c:forEach var="RC" items="${RClist}" varStatus="status">
						<tr>
							<th scope="row">${status.count}</th>
							<td>${RC.lid}(${RC.name})</td>
							<td>${RC.reviewCount}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>


		<h1 class="text-center p-3 mt-5">대여 TOP 3</h1>

		<div class="mx-auto w-50 p-3 border border-dark border-opacity-25 rounded d-flex justify-content-center">
			<table class="table table-hover">
				<thead class="text-center">
					<tr>
						<th scope="col">순위</th>
						<th scope="col">아이디(이름)</th>
						<th scope="col">대여한 누적 도서 수</th>
					</tr>
				</thead>
				<tbody class="text-center">
					<c:forEach var="LC" items="${LClist}" varStatus="status">
						<tr>
							<th scope="row">${status.count}</th>
							<td>${LC.lid}(${LC.name})</td>
							<td>${LC.loanCount}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>


		<h1 class="text-center p-3 mt-5">리뷰 추천 TOP 3</h1>

		<div class="mx-auto w-50 p-3 border border-dark border-opacity-25 rounded d-flex justify-content-center">
			<table class="table table-hover">
				<thead class="text-center">
					<tr>
						<th scope="col">순위</th>
						<th scope="col">아이디(이름)</th>
						<th scope="col">받은 추천 수</th>
					</tr>
				</thead>
				<tbody class="text-center">
					<c:forEach var="LlC" items="${LlClist}" varStatus="status">
						<tr>
							<th scope="row">${status.count}</th>
							<td>${LlC.lid}(${LlC.name})</td>
							<td>${LlC.likesCount}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>

	<jsp:include page="./footer.jsp" />
</body>
</html>