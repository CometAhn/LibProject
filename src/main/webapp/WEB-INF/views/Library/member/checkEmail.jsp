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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link href="http://localhost/css/loading.css" rel="stylesheet"><script src="https://kit.fontawesome.com/e561738355.js" crossorigin="anonymous"></script>
<link href="http://localhost/css/mailcheck.css" rel="stylesheet">
<title>Login</title>
</head>
<body class="text-center">
<script type="text/javascript">
	function checkForm() {
		if (!document.newMember.emailkey.value) {
			alert("인증번호를 입력하세요.");
			return false;
		}
	 $('#loading').show();
	}
</script>

    <div id="loading"><img id="loading-image" src="/images/loading.gif" alt="Loading..." /></div>
	<jsp:include page="../menu.jsp" />

	<div class="justify-content-center d-flex justify-content-center">
		<div class="w-25 p-3 border border-dark border-opacity-25 rounded d-flex justify-content-center">
				<form name="newMember" class="form-signin" action="/Lib/emailcheck" method="post" onsubmit="return checkForm()" autocomplete="off">
				<h1 class="pb-5 mx-5">이메일 인증</h1>
				<%
				String error;

				if(request.getAttribute("error")!=null){
				    error = (String) request.getAttribute("error");
				}else{
				    error = null;
				}
				if(error != null){
				  if (error == "0") {
                    out.println("<div class='alert alert-danger'>");
                    out.println("메일함을 확인해주세요.");
                        out.println("</div>");
                  }else if (error == "1"){
                    out.println("<div class='alert alert-danger'>");
                    out.println("인증번호가 알맞지 않습니다.");
                        out.println("</div>");

                  }
                }
				%>
				<input type="text" class="form-control" name="id" value="${id}" hidden>
				<div class="form-floating">
					<input type="email" class="form-control" value="${email}" placeholder="mail" disabled>
					<label for="floatingInput">이메일</label>
				</div>
				<div class="form-floating">
						<input type="text" class="form-control" name="emailkey" placeholder="key" required>
					<label for="floatingInput">인증번호</label>
				</div>
					<p class="p-3">
						<button class="btn btn btn-lg btn-success btn-block p-3" type="submit">확인</button>
					</p>
				</form>
		</div>
	</div>
	<jsp:include page="../footer.jsp"/>
</body>
</html>