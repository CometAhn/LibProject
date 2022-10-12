<%@ page contentType="text/html; charset=utf-8"%>
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
<script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>
<script src="/js/loading.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link href="http://localhost/css/style.css" rel="stylesheet">
<script src="https://kit.fontawesome.com/e561738355.js" crossorigin="anonymous"></script>
<title>Login</title>
</head>
<body>
<div id="loading"><img id="loading-image" src="/images/loading.gif" alt="Loading..." /></div>
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

	<section id="mid">
		<div class="contents">
			<div class="login">
				<h1>로그인</h1>
	            <br>
				<%
				String error;

				if(request.getAttribute("error")!=null){
				    error = (String) request.getAttribute("error");
				}else{
				    error = null;
				}
				if(error != null){
				  if (error == "0") {
                    out.println("<div class='alert alert-success'>");
                    out.println("계정 생성이 완료되었습니다.");
                        out.println("</div>");
                    } else if (error == "1") {
				    	out.println("<div class='alert alert-danger'>");
				    	out.println("아이디와 비밀번호를 확인해 주세요");
				    	out.println("</div>");
				    } else if(error == "2"){
				    	out.println("<div class='alert alert-danger'>");
				    	out.println("탈퇴한 계정입니다.");
				    	out.println("</div>");
				    } else if(error == "3"){
                     	out.println("<div class='alert alert-success'>");
                     	out.println("회원 정보가 변경되었습니다.");
                     	out.println("</div>");
                    } else if(error == "4"){
						session.invalidate();
                     	out.println("<div class='alert alert-danger'>");
                     	out.println("회원 탈퇴가 완료되었습니다.");
                     	out.println("</div>");
                    } else if(error == "5"){
                        out.println("<div class='alert alert-danger'>");
                        out.println("reCAPTCHA 동의 후 다시 로그인 해주세요.");
                        out.println("</div>");
                    } else if(error == "6"){
                        out.println("<div class='alert alert-success'>");
                        out.println("이메일로 임시 비밀번호를 전송했습니다.");
                        out.println("</div>");
                    } else if(error == "7"){
                        out.println("<div class='alert alert-success'>");
                        out.println("비밀번호가 변경되었습니다.");
                        out.println("</div>");
                    }
                }
				%>
				<form class="form-signin" action="/Lib/login" method="post" onsubmit="return onSubmit();">
					<h3>아이디</h3>
					<p>
						<input type="text" class="form-control" placeholder="ID" name="id" value="${id}" required autofocus>
					</p>
					<h3>비밀번호</h3>
					<p>
						<input type="password" class="form-control" placeholder="Password" name="password" value="${pw}" required>
					</p>
					<br>
					<center>
                        <div class="g-recaptcha" data-sitekey="6LctdVYiAAAAANSXZSeaohuJzWh5SCH6mvjrd-o9"></div>
                        <br>
                    </center>
					<p>
						<button class="btn btn btn-lg btn-success btn-block" type="submit">로그인</button>
					</p>
				</form>
				<p>
				<a href="/Lib/findid">아이디 </a> / <a href="/Lib/findpw">비밀번호 찾기</a>
				</p>
			</div>
			<center>
				<p>
				    <a href="https://kauth.kakao.com/oauth/authorize?client_id=e6f60f053eb85f6437f9f7e99973580c&redirect_uri=http://localhost/Lib/kakao&response_type=code"><img src="/images/kakao_login_large_narrow.png" alt=""></a>
				</p>
			</center>
		</div>

	</section>
	<jsp:include page="../footer.jsp"/>
</body>
</html>