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
<h2 align="center">회원 탈퇴</h2>
<h4>회원 탈퇴하시는 이유가 무엇인가요?</h4>
<input type="checkbox" name="why" value="1">유익하지 않아서<br/>	
<input type="checkbox" name="why" value="2">다른 계정을 이용하려고<br/>	
<input type="checkbox" name="why" value="3">요리에 흥미가 떨어져서<br/>
<form action="memberOutLast" id="check" name="memberOutLast" method="post">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	<input type="hidden" id="id" name="id" value="${user_id}">
	<button type="submit" class="btn btn-primary">확인</button>
</form>
<script>
$(document).ready(function() {
	$("#check").click(function(event) {
		event.preventDefault();	
		let checked = $('input[name="why"]:checked');
		if(!checked.length) {
			alert("탈퇴 이유를 1가지 이상 선택해주세요");
			return false;
		}
		$.ajax({
			url : $("#check").attr("action"),
			type : $("#check").attr("method"),
			data : $("#check").serialize(),
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