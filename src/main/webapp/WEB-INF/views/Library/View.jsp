<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String sessionId = (String) session.getAttribute("sessionId");
	boolean admin;


	if (session.getAttribute("admin") != null) {
		admin = (Boolean) session.getAttribute("admin");
	} else {
		admin = false;
	}
%>
<!DOCTYPE html>
<html>
<head>
    <!-- Google tag (gtag.js) -->
    <script async src="https://www.googletagmanager.com/gtag/js?id=G-1N3FJ1ETYL"></script>
    <script>
      window.dataLayer = window.dataLayer || [];
      function gtag(){dataLayer.push(arguments);}
      gtag('js', new Date());

      gtag('config', 'G-1N3FJ1ETYL');
    </script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>
<script src="/js/loading.js"></script>
<link href="/css/loading.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>
<script src="https://kit.fontawesome.com/e561738355.js" crossorigin="anonymous"></script>
<title>${book.title} 상세정보</title>
</head>
<body>
<div id="loading"><img id="loading-image" src="/images/loading.gif" alt="Loading..." /></div>

	<%
	String msg = (String) request.getAttribute("msg");

	if (msg != null) {
		if (msg.equals("0")) {
	%>
	<script>
		alert('이미 장바구니에 추가된 책입니다.');
		location.href = "/Lib/getbook/${bid}";
	</script>
	<%
	//response.sendRedirect("lib?action=getBook&id=" + bid);
	} else if (msg.equals("1")) {
	%>
	<script>
		alert('장바구니에 추가했습니다.');
		location.href = "/Lib/getbook/${bid}";
	</script>
	<%
	} else if (msg.equals("2")) {
	%>
	<script>
		alert('책 대여 후 반납하지 않은 책은 장바구니에 담을 수 없습니다.');
		location.href = "/Lib/getbook/${bid}";
	</script>
	<%
	} else if (msg.equals("3")) {
	%>
	<script>
		alert('리뷰가 변경되었습니다.');
		location.href = "/Lib/getbook/${bid}";
	</script>
	<%
	} else if (msg.equals("4")) {
	%>
	<script>
		alert('리뷰를 삭제했습니다.');
		location.href = "/Lib/getbook/${bid}";
	</script>
	<%
	} else if (msg.equals("5")) {
      	%>
      	<script>
      		alert('리뷰를 추천했습니다.');
      	</script>
      	<%
	} else if (msg.equals("6")) {
      	%>
      	<script>
      		alert('리뷰 추천을 취소했습니다.');
      	</script>
      	<%
    } else if (msg.equals("7")) {
        %>
        <script>
        	alert('도서 정보를 변경했습니다.');
        </script>
        <%
    }
    }
	%>

	<!-- 상단 메뉴 -->
	<jsp:include page="./menu.jsp" />
	<script type="text/javascript">
		function addtocart() {
			if (confirm("장바구니에 담은 후 장바구니로 이동 하시겠습니까?")) {
		    location.href = "/Lib/addcarttocart?bid=${book.bid}";
			} else {
		    location.href = "/Lib/addcart?bid=${book.bid}";
			}
		}
    	function loginfirst() {
		    alert('로그인 후 이용가능합니다.');
		    location.href = "/Lib/loginpage";
    	}
	</script>

	<section id="mid">
	</section>

	<div class="container w-75 mt-5 mx-auto">
		<hr>
		<div class="card w-75 mx-auto">
			<img class="card-img-top" src="${book.bookCover}">
			<div class="card-body">
				<h4 class="card-title">책 제목 : ${book.title}</h4>
				<p class="card-text">작가명 : ${book.writer}</p>
				<p class="card-text">책 내용 : ${book.description}</p>
				<p class="card-text">분류 : ${book.category}</p>
				<p class="card-text">출판사 : ${book.publisher}</p>
				<p class="card-text">재고수 : ${book.stock}</p>
			</div>
			<form name="addform" action="" method="post">
				<% if (sessionId != null) {
				    %>
				<a class="btn btn-info" onclick="addtocart()">도서 대여 &raquo;</a>
				    <% } else { %>
				<a class="btn btn-info" onclick="loginfirst()">도서 대여 &raquo;</a>
				 <% } %>

				  <a href="/Lib/list?pagenum=1&items=Title&text=" class="btn btn-secondary">도서 목록 &raquo;</a>
	<%
	if (admin == true) {
	%>
				  <a class="btn btn-outline-info" type="button" data-bs-toggle="collapse" data-bs-target="#editForm" aria-expanded="false" aria-controls="editForm">도서 수정</a>
			</form>
					<div class="collapse" id="editForm">
					<div class="card card-body">
                   			<form action="/Lib/bookup" method="post" enctype="multipart/form-data" autocomplete="off">
                   			<input type="text" name="bid" class="form-control" value="${book.bid}" hidden>
                   				<label class="form-label">제목</label> <input type="text" name="title" class="form-control" value="${book.title}"><label class="form-label"> 글쓴이</label> <input type="text" name="writer" class="form-control" value="${book.writer}"> <label class="form-label">책 내용</label>
                   				<textarea rows="5" cols="50" name="description" class="form-control">${book.description}</textarea>
                   				<label class="form-label">분류</label> <input type="text" name="category" class="form-control" value="${book.category}"> <label class="form-label">출판사</label> <input type="text" name="publisher" class="form-control" value="${book.publisher}"> <label class="form-label">수량</label> <input type="text" name="stock" class="form-control" value="${book.stock}"> <label class="form-label">이미지</label> <input type="file" name="file" class="form-control">
                   				<button type="submit" class="btn btn-success mt-3">변경</button>
                   			</form>
                   		</div>
                   	</div>

	<%
	}
	%>
		</div>
		<hr>
	</div>

	<div class="container w-75 mt-5 mx-auto">
		<h1>Review</h1>
		<c:forEach var="review" items="${reviewlist}" varStatus="status">
			<div class="card w-75 mx-auto">
				<div class="card-body">
					<h4 class="card-title">제목 : ${review.title}</h4>
					<p class="card-text">내용 : ${review.contents}</p>
					<p class="card-text">평점 :
                        <c:if test="${review.score == '5'}">
					         ★★★★★
					    </c:if>
                        <c:if test="${review.score == '4'}">
					         ★★★★☆
					    </c:if>
                        <c:if test="${review.score == '3'}">
	    				     ★★★☆☆
    					</c:if>
                        <c:if test="${review.score == '2'}">
    					     ★★☆☆☆
    					</c:if>
                        <c:if test="${review.score == '1'}">
    					     ★☆☆☆☆
    					</c:if>
					</p>
					<c:if test="${review.login.lid == sessionId}">
						<a href="/Lib/delreview/${review.loan.id}" class="btn btn-danger">삭제</a>
						<a class="btn btn-outline-info" type="button" data-bs-toggle="collapse" data-bs-target="#addForm${review.id}" aria-expanded="false" aria-controls="addForm">리뷰 수정</a>
					</c:if>
				    <c:choose>
					    <c:when test="${empty sessionId}">
					        <a href="#" onclick="loginfirst()" class="btn btn-light">${review.likes} <i class="far fa-thumbs-up"></i></a>
					    </c:when>
					    <c:otherwise>
                            <c:if test="${!empty review.reviewLikesList}">
		                    <c:forEach var="likes" items="${review.reviewLikesList}" varStatus="status">
                                <c:if test="${likes.login.lid == sessionId}">
					                <a href="/Lib/reviewlikes/${review.library.bid}/${review.id}" class="btn btn-primary">${review.likes} <i class="far fa-thumbs-up"></i></a>
					            </c:if>
                                <c:if test="${likes.login.lid != sessionId}">
					                <a href="/Lib/reviewlikes/${review.library.bid}/${review.id}" class="btn btn-light">${review.likes} <i class="far fa-thumbs-up"></i></a>
					            </c:if>
		                    </c:forEach>
    					    </c:if>
                            <c:if test="${empty review.reviewLikesList}">
					                <a href="/Lib/reviewlikes/${review.library.bid}/${review.id}" class="btn btn-light">${review.likes} <i class="far fa-thumbs-up"></i></a>
    					    </c:if>
					    </c:otherwise>
				    </c:choose>
					<!-- 리뷰 수정 기능 -->
						<div class="collapse" id="addForm${review.id}">
							<div class="card card-body">
								<form action="/Lib/upreview" method="post" enctype="multipart/form-data">
									<input type="text" name="id" class="form-control" value="${review.id}" hidden> <input type="text" name="library.bid" class="form-control" value="${book.bid}" hidden> <label class="form-label"> 제목 </label> <input type="text" name="title" class="form-control" value="${review.title}"> <label class="form-label">리뷰 내용</label>
									<textarea rows="5" cols="50" name="contents" class="form-control">${review.contents}</textarea>
									<label class="form-label"> 평점 </label>
                                    <select name="score" id="score" class="form-control">
                                        <option value="1"> ★☆☆☆☆ </option>
                                        <option value="2"> ★★☆☆☆ </option>
                                        <option value="3"> ★★★☆☆ </option>
                                        <option value="4"> ★★★★☆ </option>
                                        <option value="5"> ★★★★★ </option>
                                    </select>
									<!-- 평점 추가 해야함 -->
									<button type="submit" class="btn btn-success mt-3">수정</button>
								</form>
							</div>
						</div>
				</div>
			</div>
		</c:forEach>
	</div>

	<!-- 하단 메뉴 -->
	<jsp:include page="./footer.jsp" />
</body>
</html>