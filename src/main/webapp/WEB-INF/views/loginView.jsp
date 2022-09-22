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

<div class="container my-5">
	<form action="login" method="post" name="login">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		<h2 class="modal-title w-100">로그인</h2>
		<div class="form-group">
			<label for="inputId">ID</label>
			<input type="text" class="form-control" id="id" name="id" required>
		</div>
		<div class="form-group">
			<label for="inpuPassword">PW</label>
			<input type="password" class="form-control" id="pw" name="pw" required>
		</div>
		<div class="form-group form-check">
			<input type="checkbox" class="form-check-input" id="rememberMe" name="remember-me" checked>
			<label class="form-check-label" for="rememberMe" aria-describedby="rememberMeHelp">remember-me</label>
			<!-- aria-describedby는 스크린리더에서 설명할 내용 -->
		</div>
		<button type="submit" class="btn btn-primary w-100">로그인</button>
		<a id="findId" class="d-inline-block p-3" href="findIdView">아이디 찾기</a>
		<a id="changePw" class="d-inline-block p-3" href="changePwView">비밀번호 변경하기</a>
	</form>
</div>
<script>
$(document).ready(function() {
	$("#findId").click(function(event) {
		event.preventDefault();
		$.ajax({
			url : $("#findId").attr("href"),
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
	$("#changePw").click(function(event) {
		event.preventDefault();
		$.ajax({
			url : $("#changePw").attr("href"),
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