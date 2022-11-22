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
<link href="/css/loading.css" rel="stylesheet">
<title>Map</title>
</head>
<body>
	<div id="loading">
		<img id="loading-image" src="/images/loading.gif" alt="Loading..." />
	</div>
	<jsp:include page="./menu.jsp" />

<main>
      <div class="container py-4">
        <div id="carouselExampleControls" class="carousel slide p-5 mb-4 text-bg-dark rounded-3 bg-opacity-50" style="height: 220px;" data-bs-ride="carousel">
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
          <button class="carousel-control-prev" style="width: 5%;" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
          </button>
          <button class="carousel-control-next" style="width: 5%;"type="button" data-bs-target="#carouselExampleControls" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
          </button>
        </div>



    <div class="row align-items-md-stretch">
      <div class="col-md-6">
        <div class="h-100 px-3 pt-3 pb-5 text-bg-dark rounded-3">
          <h1 class="pb-3 text-center">도서관 위치</h1>

          						<div id="map" style="width:100%;height:80%;"></div>
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

	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=372e9be4c85d8e5f3b182ea4e17070ae&libraries=services"></script>
    <script>
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
            level: 3 // 지도의 확대 레벨
        };

    // 지도를 생성합니다
    var map = new kakao.maps.Map(mapContainer, mapOption);

    // 주소-좌표 변환 객체를 생성합니다
    var geocoder = new kakao.maps.services.Geocoder();

    // 주소로 좌표를 검색합니다
    geocoder.addressSearch('경상남도 창원시 마산회원구 양덕북12길 113 경민인터빌 407호', function(result, status) {

        // 정상적으로 검색이 완료됐으면
         if (status === kakao.maps.services.Status.OK) {

            var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

            // 결과값으로 받은 위치를 마커로 표시합니다
            var marker = new kakao.maps.Marker({
                map: map,
                position: coords
            });

            // 인포윈도우로 장소에 대한 설명을 표시합니다
            var infowindow = new kakao.maps.InfoWindow({
                content: '<div style="width:150px;text-align:center;padding:6px 0; color:black;">IT Library</div>'
            });
            infowindow.open(map, marker);

            // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
            map.setCenter(coords);
        }
    });
    </script>
</body>
</html>
