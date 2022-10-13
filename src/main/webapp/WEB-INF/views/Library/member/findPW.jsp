<%@ page contentType="text/html; charset=utf-8"%>
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link href="http://localhost/css/loading.css" rel="stylesheet">
<script src="https://kit.fontawesome.com/e561738355.js" crossorigin="anonymous"></script>
<link href="http://localhost/css/findpw.css" rel="stylesheet">
<script src="https://www.google.com/recaptcha/api.js" async defer></script>
<title>비밀번호 찾기</title>
</head>
<body class="text-center">
	<script type="text/javascript">
		function checkForm() {
			if (grecaptcha.getResponse().length == 0) {
				alert('reCAPTCHA 동의 후 다시 로그인 해주세요.');
				return false;
			}

			if (!document.newMember.email.value) {
				alert("인증번호를 입력하세요.");
				return false;
			}

			$('#loading').show();
		}
	</script>

	<div id="loading">
		<img id="loading-image" src="/images/loading.gif" alt="Loading..." />
	</div>

	<jsp:include page="../menu.jsp" />

	<div class="justify-content-center d-flex justify-content-center">
		<div class="w-25 p-3 border border-dark border-opacity-25 rounded d-flex justify-content-center">
			<form name="newMember" class="form-signin" action="/Lib/findpww" method="post" onsubmit="return checkForm()">
				<h1 class="pb-5 mt-n3">비밀번호 찾기</h1>
				<%
				String error;

				if (request.getAttribute("error") != null) {
					error = (String) request.getAttribute("error");
				} else {
					error = null;
				}
				if (error != null) {
					if (error == "0") {
						out.println("<div class='alert alert-danger'>");
						out.println("reCAPTCHA 동의 후 다시 시도 해주세요.");
						out.println("</div>");
					} else if (error == "1") {
						out.println("<div class='alert alert-danger'>");
						out.println("일치하는 정보가 없습니다.");
						out.println("</div>");
					} else if (error == "2") {
						out.println("<div class='alert alert-success'>");
						out.println("카카오 로그인을 사용하는 이메일입니다.<br>");
						out.println("카카오 로그인을 이용해주세요.");
						out.println("</div>");
					}
				}
				%>
				<div class="form-floating">
					<input type="text" class="form-control" name="lid" value="${id}" placeholder="ID" required> <label for="floatingInput">아이디</label>
				</div>
				<div class="form-floating">
					<input type="email" class="form-control" name="email" value="${email}" placeholder="mail" required> <label for="floatingInput">이메일</label>
				</div>

				<div class="p-3 d-flex justify-content-center">
					<div class="g-recaptcha" data-sitekey="6LctdVYiAAAAANSXZSeaohuJzWh5SCH6mvjrd-o9"></div>
				</div>
				<p>
					<button class="btn btn btn-lg btn-success btn-block" type="submit">임시비밀번호 전송</button>
				</p>
				<p class="pb-3">
					<a href="/Lib/loginpage">로그인 </a> / <a href="/Lib/findid"> 아이디 찾기</a>
				</p>
				<p>
					<a class="d-flex justify-content-center" href="https://kauth.kakao.com/oauth/authorize?client_id=e6f60f053eb85f6437f9f7e99973580c&redirect_uri=http://localhost/Lib/kakao&response_type=code"><img src="/images/kakao_login_large_narrow.png" alt=""></a>
				</p>
			</form>
		</div>
	</div>

	<jsp:include page="../footer.jsp" />
</body>
</html>