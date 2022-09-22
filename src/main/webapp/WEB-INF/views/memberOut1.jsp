<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<!-- RWD -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- MS -->
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8,IE=EmulateIE9"/>
<meta id="_csrf" name="_csrf" content="${_csrf.token}"/> <!-- 페이지 위조요청 방지를 위한 태그 -->
<title>JSP</title>
<!-- bootstrap -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<!-- jquery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- propper jquery -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<!-- latest javascript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<!--fontawesome icon-->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" 
	integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
<!--google icon -->
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.username" var="user_id"/>
</sec:authorize>
<div class="container mt-3">
	<form action="memberOutCheck" method="post" id="memberOutCheck" name="memberOutCheck">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<input type="hidden" id="id" name="id" value="${user_id}">
		<h2 class="text-center">회원 탈퇴</h2>
		<div class="form-group">
			<h5>전화번호 인증</h5>
			<input type="text" class="form-control" id="phoneC" name="phoneC">
		</div>
		<input type="submit" class="btn btn-primary" value="확인">
		<a class="d-none" href="memberOut2" id="memberOut2">2</a>
	</form>
</div>

<script>
$(document).ready(function() {
	$("#memberOutCheck").submit(function(event) {
		event.preventDefault();
		$.ajax({
			url : $("#memberOutCheck").attr("action"),
			type : $("#memberOutCheck").attr("method"),
			data : $("#memberOutCheck").serialize(),
			success : function(data) {
				if(data.search("phone-equals") > -1) {
					alert("정보가 확인되었습니다.");
					$("#memberOut2").trigger("click");
				} else {
					alert("정보가 일치하지 않습니다.");
					$("#phoneC").focus();
					return false;
				}
			},
			error : function() {
				alert("에러입니다.");
			}
		});
	});
	$("#memberOut2").click(function(event) {
		event.preventDefault();
		$.ajax({
			url : $("#memberOut2").attr("href"),
			type : "get",
			data : "",
			success : function(data) {
				$("#body").html(data);
			},
			error : function() {
				alert("에러입니다.");
			}
		});
	});
});
</script>
</body>
</html>