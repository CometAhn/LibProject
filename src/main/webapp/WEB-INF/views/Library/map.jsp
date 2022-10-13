<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
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
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>
<script src="/js/loading.js"></script>
<script src="https://kit.fontawesome.com/e561738355.js" crossorigin="anonymous"></script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link href="http://localhost/css/loading.css" rel="stylesheet">
<title>Map</title>
</head>
<body>
	<div id="loading">
		<img id="loading-image" src="/images/loading.gif" alt="Loading..." />
	</div>
	<jsp:include page="./menu.jsp" />

<main>
  <div class="container py-4">
    <div id="carouselExampleControls" class="carousel slide p-5 mb-4 text-bg-dark rounded-3 bg-opacity-50" data-bs-ride="carousel">
      <div class="carousel-inner">
        <div class="carousel-item active">
          <div class="container-fluid py-1">
            <h1 class="display-5 fw-bold mb-2">1. 환영합니다.</h1>
            <p class="col-md-10 fs-4">도서관 웹 소개페이지입니다. This is the library web introduction page.</p>
          </div>
        </div>
        <div class="carousel-item">
          <div class="container-fluid py-1">
            <h1 class="display-5 fw-bold mb-2">2. 환영합니다.</h1>
            <p class="col-md-10 fs-4">도서관 웹 소개페이지입니다. This is the library web introduction page.</p>
          </div>
        </div>
        <div class="carousel-item">
          <div class="container-fluid py-1">
            <h1 class="display-5 fw-bold mb-2">3. 환영합니다.</h1>
            <p class="col-md-10 fs-4">도서관 웹 소개페이지입니다. This is the library web introduction page.</p>
          </div>
        </div>
      </div>
      <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Previous</span>
      </button>
      <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Next</span>
      </button>
    </div>



    <div class="row align-items-md-stretch">
      <div class="col-md-6">
        <div class="h-100 px-3 pt-3 pb-5 text-bg-dark rounded-3">
          <h1 class="pb-3 text-center">도서관 위치</h1>
          						<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1629.4933461709093!2d128.58319310059574!3d35.23170130097478!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x356f32161a07d2b5%3A0xd8e276b01df1f6e4!2z7JWE7J207Yuw7JeQ65OA64S37ZWZ7JuQ!5e0!3m2!1sko!2skr!4v1663147825611!5m2!1sko!2skr" width="100%" height="80%" style="border: 0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
        </div>
      </div>
      <div class="col-md-6">
        <div class="h-100 p-5 bg-light border rounded-3">
          <p><h3>전화번호 : 055-123-1234</p>

          <p>주소 : 경남 창원시 마산길 12-3</p>

          <p>운영 시간 : 09:00 ~ 18:00</p>

          <p>문의 사항 : admin@ipi.pw</p>
        </div>
      </div>
    </div>
  </div>
</main>

	<jsp:include page="./footer.jsp" />
</body>
</html>
