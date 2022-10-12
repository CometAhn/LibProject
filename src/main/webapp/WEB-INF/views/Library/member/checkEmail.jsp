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

	<section id="mid">
		<div class="contents">
			<div class="login">
				<h1>이메일 인증</h1>
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
				<form name="newMember" class="form-signin" action="/Lib/emailcheck" method="post" onsubmit="return checkForm()" autocomplete="off">
					<p>
						<input type="text" class="form-control" name="id" value="${id}" hidden>
					</p>
					<h3>이메일</h3>
					<p>
						<input type="text" class="form-control" value="${email}" disabled>
					</p>
					<h3>인증번호</h3>
					<p>
						<input type="text" class="form-control" name="emailkey" required>
					</p>
					<br>
					<p>
						<button class="btn btn btn-lg btn-success btn-block" type="submit">확인</button>
					</p>
				</form>
			</div>
		</div>
	</section>
	<jsp:include page="../footer.jsp"/>
</body>
</html>