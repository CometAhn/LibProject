<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String sessionId = (String) session.getAttribute("sessionId");
String name = (String) session.getAttribute("name");
%>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script>
    Kakao.init("372e9be4c85d8e5f3b182ea4e17070ae");
    function sendLink() {
      Kakao.Link.sendCustom({
        templateId: 83300,
        templateArgs: {
          title: "{{ page.title }}",
          description: "{{ page.excerpt }}",
          url : "{{ page.url }}",
        },
      });
    }
</script>
<div class="container">
  <footer class="d-flex flex-wrap justify-content-between align-items-center py-3 my-4 border-top">
    <div class="col-md-4 d-flex align-items-center">
      <a href="#" class="mb-3 me-2 mb-md-0 text-muted text-decoration-none lh-1">
        <i class="fas fa-book-open fa-2x" width="30" height="24"></i>
      </a>
      <span class="mb-3 mb-md-0 text-muted">&copy; 2022 Company, Inc</span>
    </div>

    <ul class="nav col-md-4 justify-content-end list-unstyled d-flex">
      <li class="ms-3"><a class="text-muted" href="#"><svg class="bi" width="24" height="24"><use xlink:href="#twitter"/></svg></a></li>
      <li class="ms-3"><a class="text-muted" href="#"><svg class="bi" width="24" height="24"><use xlink:href="#instagram"/></svg></a></li>
      <li class="ms-3"><a class="text-muted" href="#"><svg class="bi" width="24" height="24"><use xlink:href="#facebook"/></svg></a></li>
      <li class="ms-3"><a class="text-muted" id="kakao-link-btn" href="javascript:sendLink()"><img src="/images/kakaotalk_sharing_btn_small.png"/></img></a></li>
    </ul>
  </footer>
</div>