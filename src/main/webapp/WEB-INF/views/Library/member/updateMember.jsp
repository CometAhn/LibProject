<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
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
<link href="/css/loading.css" rel="stylesheet">
<script src="https://kit.fontawesome.com/e561738355.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>

<title>회원 수정</title>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                //document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;
                //document.getElementById("sample4_jibunAddress").value = data.jibunAddress;

                /*// 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("sample4_extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
                */
                $("#addressDetail").val('');
                $("#addressDetail").focus();
            }
        }).open();
    }
</script>
</head>
<div id="loading"><img id="loading-image" src="/images/loading.gif" alt="Loading..." /></div>
<%

String msg = (String) request.getAttribute("msg");
    if (msg != null) {
    	if (msg.equals("0")) {
        %>
        <script>
        	alert('반납하지 않은 책이 존재합니다.\n확인 후 다시 시도해주세요.');
        </script>
        <%
        } else if (msg.equals("1")) {
        %>
        <script>
        	alert('reCAPTCHA 동의 후 다시 시도 해주세요.');
        </script>
        <%
        }
    }
%>
<body onload="init()">
<script src="https://www.google.com/recaptcha/api.js" async defer></script>
	<jsp:include page="../menu.jsp" />
<main>
	<div class="justify-content-center d-flex justify-content-center">
		<div class="w-25 p-3 border border-dark border-opacity-25 rounded">
				<h1 class="p-3">회원 정보 수정</h1>
					<form name="editMember" class="form-horizontal" action="/Lib/update" method="post" onsubmit="return checkForm()" autocomplete="off">
						<input name="lid" type="text" class="form-control" placeholder="id" hidden="" value="${login.lid}">
						<h3>비밀번호</h3>
						<p>
							<input name="password" type="password" class="form-control" placeholder="password" value="" minlength="6" maxlength="16" required>
						</p>
						<h3>비밀번호 확인</h3>
						<p>
							<input name="password_confirm" type="password" class="form-control" placeholder="password_confirm" required>
						</p>
						<h3>이름</h3>
						<p>
							<input name="name" type="text" class="form-control" placeholder="name" value="${login.name}" minlength="2" required>
						</p>
						<h3>생년월일</h3>
				<div class="row g-3">
					<div class="col-sm-4">
						<p>
							<input type="text" class="form-control" name="birthyy" maxlength="4" placeholder="년(4자)" size="6" value="${birthyy}" required>
					</div>
					<div class="col-sm-4">
					<select name="birthmm" id="birthmm" class="form-select">
								<option value="">월</option>
								<option value="01">1</option>
								<option value="02">2</option>
								<option value="03">3</option>
								<option value="04">4</option>
								<option value="05">5</option>
								<option value="06">6</option>
								<option value="07">7</option>
								<option value="08">8</option>
								<option value="09">9</option>
								<option value="10">10</option>
								<option value="11">11</option>
								<option value="12">12</option>
							</select>
					</div>
					<div class="col-sm-4">
					<input type="text" class="form-control" name="birthdd" maxlength="2" placeholder="일" size="4" value="${birthdd}" required>
						</p>
					</div>
						<h3>성별</h3>
						<p>
							<c:set var="gender" value="${row.gender}" />
							<input name="gender" type="radio" value="남" <c:if test="${login.gender.equals('남')}"> <c:out value="checked" /> </c:if>>남 <input name="gender" type="radio" value="여" <c:if test="${login.gender.equals('여')}"> <c:out value="checked" /> </c:if>>여
						</p>
						<h3>연락처</h3>
						<p>
							<input name="phone" type="tel" class="form-control" placeholder="01000000000" value="${login.phone}" minlength="11" maxlength="11" required>
						</p>

						<h3>E-mail</h3>
						<p>
							<input type="email" name="email" class="form-control" value="${login.email}" required>
						</p>
						<h3>주소</h3>
						<p>
                            <input name="address" type="text" id="sample4_roadAddress" onclick="sample4_execDaumPostcode()" class="form-control" placeholder="address" value="${login.address}" required tabindex="-1">
                            <input name="addressDetail" type="text" id="addressDetail" class="form-control" placeholder="상세주소" value="${login.addressDetail}" required>
						</p>
						<center>
                            <div class="g-recaptcha" data-sitekey="6LctdVYiAAAAANSXZSeaohuJzWh5SCH6mvjrd-o9"></div>
                        </center>
						<input type="submit" class="btn btn-primary col-sm-3" value="회원수정 ">
					</form>
					<form name="newMember1" class="form-horizontal" action="/Lib/delete" method="post">
						<input name="id" type="text" class="form-control" placeholder="id" hidden="" value="${login.lid}"> <input type="submit" class="btn btn-danger col-sm-3" value="회원탈퇴 ">
					</form>
		</div>
	</div>
</main>
	<jsp:include page="../footer.jsp" />
</body>
</html>
<script type="text/javascript">
	function init() {
		setComboBirthValue("${birthmm}");
	}
	function setComboBirthValue(val) {
		var selectBirth = document.getElementById('birthmm');
		for (i = 0, j = selectBirth.length; i < j; i++) {
			if (selectBirth.options[i].value == val) {
				selectBirth.options[i].selected = true;
				break;
			}
		}
	}
	function checkForm() {
		if (grecaptcha.getResponse().length == 0) {
        	alert('reCAPTCHA를 확인해 주세요.');
        	return false;
        }
		if (!document.editMember.password.value) {
			alert("비밀번호를 입력하세요.");
			return false;
		}
		if (document.editMember.password.value != document.editMember.password_confirm.value) {
			alert("비밀번호를 동일하게 입력하세요.");
			return false;
		}

	$('#loading').show();
	}
</script>