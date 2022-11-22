<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>
<script src="/js/loading.js"></script>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link href="/css/loading.css" rel="stylesheet"><script src="https://kit.fontawesome.com/e561738355.js" crossorigin="anonymous"></script>

<title>회원 가입</title>
</head>
<body>
    <div id="loading"><img id="loading-image" src="/images/loading.gif" alt="Loading..." /></div>
	<jsp:include page="../menu.jsp" />

	<section id="mid">
    <p>인가 코드 : ${code}</p>
    <p>유효 토큰 : ${access_token}</p>
    <p>사용자 정보 : ${userInfo}</p>
    <p>동의 정보 : ${agreementInfo}</p>
    <a href="https://kauth.kakao.com/oauth/logout?client_id=e6f60f053eb85f6437f9f7e99973580c&logout_redirect_uri=http://localhost/Lib/klogout">로그아웃</a>
    </section>

	<jsp:include page="../footer.jsp" />
</body>
</html>