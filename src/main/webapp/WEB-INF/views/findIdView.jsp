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
<link rel="stylesheet" type="text/css" href="./css/main.css">
</head>
<body>

<div class="container my-5">
	<form action="findId" method="get" id="findId" name="findId">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		<h4>아이디 찾기</h4>
		<div class="form-group">
			<label for="phoneF">전화번호</label>
			<input type="text" class="form-control" id="phoneF" name="phoneF" required>
		</div>
		<button type="submit" class="btn btn-primary">아이디 찾기</button>&nbsp;&nbsp;
		<a id="changePw" href="changePwView" class="btn btn-primary">비밀번호 변경하기</a>
	</form>
</div>
<script>
$(document).ready(function() {
	$("#findId").submit(function(event) {
		event.preventDefault();
		$.ajax({
			url : $("#findId").attr("action"),
			type : $("#findId").attr("method"),
			data : {phoneF : $("#phoneF").val()},
			success : function(data) {
				if(data == "") {
					alert("아이디를 찾을 수 없습니다.");
				} else {
					alert("아이디는 " + data + "입니다.");
				}
			},
			error : function() {
				alert("서버에 접속을 실패했습니다.");
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