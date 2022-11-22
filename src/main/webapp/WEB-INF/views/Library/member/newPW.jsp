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
<link href="/css/loading.css" rel="stylesheet">
<script src="https://kit.fontawesome.com/e561738355.js" crossorigin="anonymous"></script>
<link href="/css/newpw.css" rel="stylesheet">
<script src="https://www.google.com/recaptcha/api.js" async defer></script>
<title>비밀번호 변경</title>
</head>
<body class="text-center">
	<script type="text/javascript">
		function checkForm() {
			if (grecaptcha.getResponse().length == 0) {
				alert('reCAPTCHA 동의 후 다시 로그인 해주세요.');
				return false;
			}
			if (!document.newMember.password.value) {
				alert("비밀번호를 입력하세요.");
				return false;
			}
			if (document.newMember.password.value != document.newMember.password_confirm.value) {
				alert("비밀번호를 동일하게 입력하세요.");
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
			<form name="newMember" class="form-signin" action="/Lib/newpw" method="post" onsubmit="return checkForm()" autocomplete="off">
				<h1 class="pb-5">비밀번호 변경</h1>
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
						out.println("계정 정보를 불러올 수 없습니다.<br>비밀번호 찾기 재시도해주세요.");
						out.println("</div>");
					} else if (error == "2") {
						out.println("<div class='alert alert-success'>");
						out.println("비밀번호를 변경해 주세요.");
						out.println("</div>");
					}
				}
				%>
				<input name="lid" type="text" class="form-control" value="${id}" hidden>

				<div class="form-floating">
					<input name="password" id="password" type="password" class="form-control" placeholder=" " value="${pw}" minlength="6" maxlength="16"> <label for="floatingInput">새 비밀번호</label>
				</div>
				<div class="form-floating">
					<input name="password_confirm" id="password_confirm" type="password" class="form-control" placeholder=" " value="${pw}"> <label for="floatingInput">비밀번호 확인</label>
				</div>

				<div class="p-3 d-flex justify-content-center">
					<div class="g-recaptcha" data-sitekey="6LctdVYiAAAAANSXZSeaohuJzWh5SCH6mvjrd-o9"></div>
				</div>
				<p>
					<button class="btn btn btn-lg btn-success btn-block" type="submit">비밀번호 변경</button>
				</p>
			</form>
		</div>
	</div>
	<jsp:include page="../footer.jsp" />
</body>
</html>