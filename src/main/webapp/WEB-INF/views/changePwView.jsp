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
<div class="container mt-5">
	<h4>비밀번호 변경하기</h4>
</div>
<div id="changePwbody" class="container mb-5">
	<form action="changePw?${_csrf.parameterName}=${_csrf.token}" method="post" name="changePw" id="changePw">
		<div class="form-group">
			<label for="idF">ID</label>
			<input type="text" class="form-control" id="idF" name="idF" required>
		</div>
		<div class="form-group">
			<label for="phoneF">전화번호</label>
			<input type="text" class="form-control" id="phoneF" name="phoneF" required>
		</div>
		<button type="submit" class="btn btn-primary w-100">비밀번호 찾기</button>
	</form>
</div>
<a class="btn btn-primary d-none" href="changePwGoView" id="changePwGoView">이동</a>
<input id="findIdF" type="hidden" value="">
<input id="findPhoneF" type="hidden" value="">
<script>
$(document).ready(function() {
	$("#changePw").submit(function(event) {
		event.preventDefault();
		$.ajax({
			url : $("#changePw").attr("action"),
			type : $("#changePw").attr("method"),
			data : {
				idF : $("#idF").val(),
				phoneF : $("#phoneF").val()
				},
			success : function(data) {
				if(data.search("changePw-success") > -1) {
					alert("정보가 일치합니다.");
					$("#findIdF").val($("#idF").val());
					$("#findPhoneF").val($("#phoneF").val());
					$("#changePwGoView").trigger("click");
				} else {
					alert("올바르지 않은 정보입니다.");
				}
			},
			error : function() {
				alert("서버에 접속을 실패했습니다.");
			}
		});
	});
	$("#joinView").click(function(event) {
		event.preventDefault();
		$.ajax({
			url : $("#joinView").attr("href"),
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
	$("#changePwGoView").click(function(event) {
		event.preventDefault();
		$.ajax({
			url : $("#changePwGoView").attr("href"),
			type : "get",
			data : "",
			success : function(data) {
				$("#changePwbody").html(data);
			},
			error : function () {
				location.href = "changePwView";
			}
		});
	});
});
</script>
</body>
</html>