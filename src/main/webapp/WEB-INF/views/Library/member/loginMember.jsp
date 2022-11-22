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

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link href="/css/loading.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script src="https://kit.fontawesome.com/e561738355.js" crossorigin="anonymous"></script>
<link href="/css/signin.css" rel="stylesheet">
<title>Login</title>
</head>
<body class="text-center">
	<div id="loading">
		<img id="loading-image" src="/images/loading.gif" alt="Loading..." />
	</div>
	<script src="https://www.google.com/recaptcha/api.js" async defer></script>
	<script>
		function onSubmit() {
			if (grecaptcha.getResponse().length == 0) {
				alert('reCAPTCHA 동의 후 다시 로그인 해주세요.');
				return false;
			}

			$('#loading').show();
			return true;
		}
	</script>

	<jsp:include page="../menu.jsp" />

	<div class="justify-content-center d-flex justify-content-center">
		<div class="w-25 p-3 border border-dark border-opacity-25 rounded d-flex justify-content-center">
		<form class="form-signin" action="/Lib/login" method="post" onsubmit="return onSubmit();">


		<h1 class="p-3">Login</h1>
				<%
        		String msg = request.getParameter("msg");

        		if (msg != null) {
        			if (msg.equals("0")) {
        		%>
        		<script>
        			alert('회원가입이 완료되었습니다.');
        		</script>
        		<%
        		}

        		}
        		%>

        		<%
        		String error;

        		if (request.getAttribute("error") != null) {
        			error = (String) request.getAttribute("error");
        		} else {
        			error = null;
        		}
        		if (error != null) {
        			if (error == "0") {
        				out.println("<div class='alert alert-success'>");
        				out.println("계정 생성이 완료되었습니다.");
        				out.println("</div>");
        			} else if (error == "1") {
        				out.println("<div class='alert alert-danger'>");
        				out.println("아이디 또는 비밀번호가 일치하지 않습니다.");
        				out.println("</div>");
        			} else if (error == "2") {
        				out.println("<div class='alert alert-danger'>");
        				out.println("탈퇴한 계정입니다.");
        				out.println("</div>");
        			} else if (error == "3") {
                        session.invalidate();
        				out.println("<div class='alert alert-success'>");
        				out.println("회원 정보가 변경되었습니다.");
        				out.println("</div>");
        			} else if (error == "4") {
        				session.invalidate();
        				out.println("<div class='alert alert-danger'>");
        				out.println("회원 탈퇴가 완료되었습니다.");
        				out.println("</div>");
        			} else if (error == "5") {
        				out.println("<div class='alert alert-danger'>");
        				out.println("reCAPTCHA 동의 후 다시 로그인해주세요.");
        				out.println("</div>");
        			} else if (error == "6") {
        				out.println("<div class='alert alert-success'>");
        				out.println("이메일로 임시비밀번호를 전송했습니다.");
        				out.println("</div>");
        			} else if (error == "7") {
        				out.println("<div class='alert alert-success'>");
        				out.println("비밀번호가 변경되었습니다.");
        				out.println("</div>");
        			}
        		}
        		%>
			<div class="form-floating">
				<input type="text" class="form-control" placeholder="ID" name="id" value="${id}" required autofocus> <label for="floatingInput">아이디</label>
			</div>
			<div class="form-floating">
				<input type="password" class="form-control" placeholder="Password" name="password" value="${pw}" required> <label for="floatingPassword">비밀번호</label>
			</div>
            <div class="d-flex justify-content-center">
			<div class="g-recaptcha" data-sitekey="6LctdVYiAAAAANSXZSeaohuJzWh5SCH6mvjrd-o9"></div>
			</div>
			<button class="w-100 btn btn-lg btn-primary" type="submit">로그인</button>
			<p class="p-3">
				<a href="/Lib/findid">아이디 </a> / <a href="/Lib/findpw">비밀번호 찾기</a>
			</p>
			<p>
				<a class=o"d-flex justify-cntent-center" href="https://kauth.kakao.com/oauth/authorize?client_id=e6f60f053eb85f6437f9f7e99973580c&redirect_uri=http://localhost/Lib/kakao&response_type=code"><img src="/images/kakao_login_large_narrow.png" alt=""></a>
			</p>
			</div>
			</div>
		</form>

	</div>
	</div>
	<jsp:include page="../footer.jsp" />
</body>
</html>