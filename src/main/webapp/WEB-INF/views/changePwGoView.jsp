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
<form action="changePwGo?${_csrf.parameterName}=${_csrf.token}" method="post" id="changePwGo" name="changePwGo">
	<div class="form-group">
		<label for="newPw">새 비밀번호</label>
		<input type="password" id="newPw" name="newPw" class="form-control" placeholder="8~16자 이내에 기존과 다른 패스워드">
	</div>
	<div class="form-group">
		<label for="newPwCheck">새 비밀번호 확인</label>
		<input type="password" id="newPwCheck" name="newPwCheck" class="form-control" placeholder="새 비밀번호와 동일하게 작성">
	</div>
	<button id="changeBtn" type="submit" class="btn btn-primary">비밀번호 변경하기</button>&nbsp;&nbsp;
	<button id="goLogin" type="button" class="btn btn-primary d-none">로그인 하러가기</button>
</form>
<script>
$(document).ready(function() {
	$("#changeBtn").click(function() {
		var newPw = $("#newPw").val();
		var newPwCheck = $("#newPwCheck").val();
		if(newPw.length == 0 || (newPw.length < 8 || newPw.length > 16)) {
			alert("새 비밀번호를 8~16자 사이로 입력해주세요.");
			$("#newPw").focus();
			return false;
		} else if(newPw != newPwCheck) {
			alert("새 비밀번호 확인을 새 비밀번호와 동일하게 입력해주세요.");
			$("#newPwCheck").focus();
			return false;
		}
		return true;
	});
	$("#changePwGo").submit(function(event) {
		event.preventDefault();
		$.ajax({
			url : $("#changePwGo").attr("action"),
			type : $("#changePwGo").attr("method"),
			data : {
				idF : $("#findIdF").val(),
				phoneF : $("#findPhoneF").val(),
				newPw : $("#newPw").val()
			},
			success : function(data) {
				if(data.search("change-success") > -1) {
					alert("비밀번호가 변경되었습니다.");
					$("#goLogin").trigger("click");
				} else {
					alert("기존에 사용하던 비밀번호로 변경할 수 없습니다. 다시 입력해 주세요.");
					$("#newPw").focus();
				}
			},
			error : function() {
				alert("서버 접속에 실패했습니다.");
			}
		});
	});
	$("#goLogin").click(function(event) {
		event.preventDefault();
		$.ajax({
			url : "loginView",
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