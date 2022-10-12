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
      function gtag(){dataLayer.push(arguments);}
      gtag('js', new Date());

      gtag('config', 'G-1N3FJ1ETYL');
    </script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>
<script src="/js/loading.js"></script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link href="http://localhost/css/loading.css" rel="stylesheet"><script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>
<script src="https://kit.fontawesome.com/e561738355.js" crossorigin="anonymous"></script>
<title>장바구니</title>
</head>
<body>
<div id="loading"><img id="loading-image" src="/images/loading.gif" alt="Loading..." /></div>
	<jsp:include page="./menu.jsp" />

	<section id="mid">
		<div class="contents">
			<div class="ct1">
				<h1>대여 목록</h1>
			</div>
			<div class="loanlist">
				<div class="cartlist_info">
					<div class="cartlist_abc">
						<p>책 제목(저자)</p>
					</div>
					<div class="cartlist_abc">
						<p>대여 기한(연체일)</p>
					</div>
					<div class="cartlist_abc">
						<p></p>
					</div>
				</div>
				<c:forEach var="book" items="${booklist}" varStatus="status">
					<c:if test="${book.status == true}">
						<div class="cartlist_a">
							<div class="cartlist_abc">
								<p>
									<a href="getbook/${book.library.bid}"> ${book.library.title}(${book.library.writer})</a>
								</p>
							</div>
							<div class="cartlist_abc">
								<p>
									${book.startDate } ~ ${book.endDate }

									<c:choose>
										<c:when test="${book.period > 0}">
                    		(${book.period}일)
					</c:when>
										<c:otherwise>
                    		(0일)
					</c:otherwise>
									</c:choose>
								</p>
							</div>
							<c:choose>
								<c:when test="${book.period > 0}">
									<div class="cartlist_abc">
										<a href="/Lib/ReturnBook?bid=${book.library.bid}&id=<%=sessionId%>&period=${book.period}"> <span class="badge bg-secondary">반납하기</span></a>
										</li>
									</div>
								</c:when>
								<c:otherwise>
									<div class="cartlist_abc">
										<a href="/Lib/ReturnBook?bid=${book.library.bid}&id=<%=sessionId%>&period=0"> <span class="badge bg-secondary">반납하기</span></a>
										</li>
									</div>
								</c:otherwise>
							</c:choose>
						</div>
					</c:if>
				</c:forEach>
				- 연체 시 (연체일 * 3)일동안 도서를 대여 할 수 없습니다.
			</div>
			<div class="ct1">
				<h1>도서 대여 기록(반납하지 않은 책 제외)</h1>
			</div>
			<div class="loanlist">
				<div class="cartlist_info">

					<div class="cartlist_abc">
						<p>책 제목(저자)</p>
					</div>
					<div class="cartlist_abc">
						<p>대여 기한</p>
					</div>
					<div class="cartlist_abc">
						<p></p>
					</div>
				</div>
				<c:forEach var="book" items="${booklist}" varStatus="status">
					<c:if test="${book.status == false}">
						<div class="cartlist_a">
							<div class="cartlist_abc">
								<p>
									<a href="getbook/${book.library.bid}"> ${book.library.title}(${book.library.writer})</a>
								</p>
							</div>
							<div class="cartlist_abc">
								<p>${book.startDate }~${book.endDate }</p>
							</div>
							<c:choose>
								<c:when test="${book.reviewed == false}">
									<div class="cartlist_abc">
										<button class="btn btn-outline-info mb-3" type="button" data-bs-toggle="collapse" data-bs-target="#addForm${book.library.bid}" aria-expanded="false" aria-controls="addForm">리뷰 등록</button>
										</li>
									</div>
						</div>
						<!-- 리뷰 등록 기능 -->
						<div class="collapse" id="addForm${book.library.bid}">
							<div class="card card-body">
								<form action="/Lib/review" method="post" enctype="multipart/form-data" autocomplete="off">
									<input type="text" name="login.lid" class="form-control" value="<%=sessionId%>" hidden>
									<input type="text" name="library.bid" class="form-control" value="${book.library.bid}" hidden>
									<input type="text" name="loan.id" class="form-control" value="${book.id}" hidden>
									<label class="form-label"> 제목 </label> <input type="text" name="title" class="form-control"> <label class="form-label">리뷰 내용</label>
									<textarea rows="5" cols="50" name="contents" class="form-control"></textarea>
									<label class="form-label"> 평점 </label>
									<select name="score" class="form-control" value="${review.score}">
                                        <option value="1"> ★☆☆☆☆ </option>
                                        <option value="2"> ★★☆☆☆ </option>
                                        <option value="3"> ★★★☆☆ </option>
                                        <option value="4"> ★★★★☆ </option>
                                        <option value="5"> ★★★★★ </option>
                                    </select>
									<!-- 평점 추가 해야함 -->
									<button type="submit" class="btn btn-success mt-3">저장</button>
								</form>
							</div>
						</div>
						</c:when>
						<c:otherwise>
							<div class="cartlist_abc">
								<button class="btn btn-outline-info mb-3" type="button">리뷰 작성 완료</button>
								</li>
							</div>
			            </div>
			</c:otherwise>
			</c:choose>
			</c:if>
			</c:forEach>
		</div>
		</div>
		</div>
	</section>
	<jsp:include page="./footer.jsp" />
	<%
	String alert = (String) request.getAttribute("alert");
	if (alert != null) {
		if (alert.equals("0")) {
	%>
	<script>
		alert('리뷰가 등록되었습니다.');
	</script>
	<%
	} else if (alert.equals("1")) {
	%>
	<script>
		alert('반납 기한을 초과하여 도서 대여가 불가능합니다.\n ${overdue} 이후 도서 대여가 가능합니다.');
	</script>
	<%
	}
	}
	%>
</body>
</html>