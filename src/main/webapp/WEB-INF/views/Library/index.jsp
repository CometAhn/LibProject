<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%>
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
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://kit.fontawesome.com/e561738355.js" crossorigin="anonymous"></script>
<title>Home</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link href="http://localhost/css/loading.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>

<script src="/js/loading.js"></script>
</head>
<body>
<div id="loading"><img id="loading-image" src="/images/loading.gif" alt="Loading..." /></div>
<script type="text/javascript">
	function nobook() {
		alert('재고가 없습니다.');
	}
</script>
<%-- 상단 내비게이션 --%>
<%@ include file="./menu.jsp"%>
<!-- 첫번째 섹션 -->
<main>
  <h1 class="text-center">환영 합니다</h1>
  <br>
  <h2 class="text-center">이달의 추천 도서</h2>

  <div class="album py-5 bg-light">
    <div class="container">
      <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">

        <c:forEach var="book" items="${booklist}" varStatus="status">
          <div class="col">
            <div class="card shadow-sm">
              <a href="getbook/${book.library.bid}"><img src="${book.library.bookCover}" alt="" width="100%" height="225"></a>
              <div class="card-body">
                <p class="card-text">${book.library.title}</p>
                <p class="card-text">${book.library.writer}</p>
                <div class="d-flex justify-content-between align-items-center">
                  <div class="btn-group">
                    <a href="getbook/${book.library.bid}"><button type="button" class="btn btn-sm btn-outline-secondary">view</button></a>
                  </div>
                  <small class="text-muted">재고 : ${book.library.stock}</small>
                </div>
              </div>
            </div>
          </div>
        </c:forEach>

      </div>
    </div>
  </div>
</main>
<br>
<%-- footer --%>
<jsp:include page="./footer.jsp" />
</body>
</html>