<%@page import="org.apache.jasper.tagplugins.jstl.core.If"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String sessionId = (String) session.getAttribute("sessionId");
int count = (int) request.getAttribute("count");
int i = 0;
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
<script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>
<script src="/js/loading.js"></script>
<link href="http://localhost/css/loading.css" rel="stylesheet">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://kit.fontawesome.com/e561738355.js" crossorigin="anonymous"></script>
<title>장바구니</title>
</head>
<body>
	<div id="loading">
		<img id="loading-image" src="/images/loading.gif" alt="Loading..." />
	</div>
	<script type="text/javascript">
		function manybookincart() {
			alert('최대 3권까지 대여할 수 있습니다.');
		}
		function nobook() {
			alert('장바구니에 책이 존재하지 않습니다.');
		}
		function manybooksum() {
			alert('장바구니의 책과 빌린 책의 수의 합이 4권이 넘습니다.');
		}
		function loading() {
			$('#loading').show();
		}
	</script>
	<%
	String msg = (String) request.getAttribute("msg");

	if (msg != null) {
		if (msg.equals("0")) {
	%>
	<script>
		alert('재고 수량이 없는 책이 포함되어 있습니다.\n확인 후 다시 시도해주세요.');
		location.href = "/Lib/listcart?id=${sessionId}";
	</script>
	<%
	} else if (msg.equals("1")) {
	%>
	<script>
		alert('반납 기한을 초과하여 도서 대여가 불가능합니다.\n ${overdue} 이후 도서 대여가 가능합니다.');
	</script>
	<%
	}
	}
	%>
	<jsp:include page="./menu.jsp" />
	<!-- 첫번째 섹션 -->

<div class="container mt-5 pt-5" style="height: 500px;">
  <h1 class="text-center p-3">장바구니</h1>
	<div class="mx-auto w-50 p-3 border border-dark border-opacity-25 rounded d-flex justify-content-center">
		<table class="table table-hover">
			<thead>
				<tr>
					<th scope="col">#</th>
					<th scope="col">책 제목(작가)</th>
					<th scope="col">재고 수</th>
					<th scope="col">삭제</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="book" items="${booklist}" varStatus="status">
					<tr>
						<th scope="row">${status.count}</th>
						<td><a href="getbook/${book.library.bid}">${book.library.title}(${book.library.writer })</a></td>
						<td>${book.library.stock }</td>
						<td><a href="/Lib/deleteCart?bid=${book.library.bid}&id=<%=sessionId%>"> <span class="badge bg-secondary">&times;</span></a></td>
					</tr>
					<%i++;%>
				</c:forEach>
			</tbody>
		</table>
	</div>
            <div class="d-flex justify-content-center p-3 mb-5">
			<%
			if (i == 0) {
			%><td align="right"><a href="#" class="btn btn-danger mb-5" onclick="nobook()">대여하기</a></td>
			<%
			} else if (i > 3) {
			%><td align="right"><a href="#" class="btn btn-danger mb-5" onclick="manybookincart()">대여하기</a></td>
			<%
			} else if (i + count > 3) {
			%><td align="right"><a href="#" class="btn btn-danger mb-5" onclick="manybooksum()">대여하기</a></td>
			<%
			} else {
			%><td align="right"><a href="/Lib/loan?id=<%=sessionId%>" class="btn btn-primary mb-5" onclick="loading()">대여하기</a></td>
			<%
			}
			%>
            </div>
            </div>
	<jsp:include page="./footer.jsp" />
</body>
</html>