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
	<form action="join" id="joining" method="post" name="joining">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<h2 class="w-100">회원가입</h2>
		<div class="input-group">
			<span class="input-group-text">성명</span>
			<input type="text" class="form-control" id="name" name="name" placeholder="-띄어쓰기 없이-">
		</div>
		<hr>
		<div class="input-group">
			<span class="input-group-text">ID</span>
			<input type="text" class="form-control" id="id" name="id" placeholder="영문,숫자 포함 8~16글자 사이">
			<div class="input-group-append">
				<button type="button" id="idCheck" class="input-group-button btn btn-primary">중복체크</button>
			</div>
			<input type="hidden" id="nonId" value="idUnCheck">
		</div>
		<hr>
		<div class="input-group">
			<span class="input-group-text">PW</span>
			<input type="password" class="form-control" id="pw" name="pw" placeholder="대문자,소문자,숫자,특수문자 포함 8~16글자 사이">
		</div>
		<hr>
		<div class="input-group">
			<div class="input-group">
				<span class="input-group-text">이메일</span>
				<input type="text" class="form-control" name="email" id="email">
			</div>
		</div>
		<hr>
		<div class="input-group">
			<span class="input-group-text">전화번호</span>
			<input type="text" class="form-control" id="phone" name="phone" placeholder=" - 없이">
			<div class="input-group-append">
				<button type="button" id="phoneCheck" class="input-group-button btn btn-primary">인증하기</button>
			</div>
			<input type="hidden" id="nonPhone" value="phoneUnCheck">
		</div>
		<hr>
		성별
		<div class="input-group my-3">
			<div class="form-check">
				<label class="form-check-label">
					<input type="radio" id="man" class="form-check-input" name="gender" value="man">남자
				</label>
			</div>
			<div class="form-check">
				<label class="form-check-label">
					<input type="radio" id="woman" class="form-check-input" name="gender" value="woman">여자
				</label>
			</div>
		</div>
		<hr>
		<div class="input-group my-3">
			<iframe src="text/agree.html" style="width: 100%; height: 400px;"></iframe>
			<div class="form-check">
				<label class="form-check-label">
					<input type="checkbox" class="form-check-input" id="agreeFirst" name="agreeFirst">동의 1트
				</label>
			</div>
			<iframe src="text/agree.html" style="width: 100%; height: 400px;"></iframe>
			<div class="form-check">
				<label class="form-check-label">
					<input type="checkbox" class="form-check-input" id="agreeSecond" name="agreeSecond">동의 2트
				</label>
			</div>
		</div>
		<button type="submit" class="btn btn-primary d-inline-block mr-auto w-25" id="sub">확인</button>&nbsp;&nbsp;
		<button type="reset" class="btn btn-outline-secondary d-inline-block w-25">취소</button>
	</form>
</div>
<a class="d-none" href="loginView" id="goLogin">메인으로</a>

<script>
$(document).ready(function() {
	$("#sub").click(function() {
		var name = $("#name").val().length;
		var id = $("#id").val().length;
		var pw = $("#pw").val().length;
		var email = $("#email").val().length;
		var phone = $("#phone").val().length;
		var man = $("#man").is(":checked");
		var woman = $("#woman").is(":checked");
		var aF = $("#agreeFirst").is(":checked");
		var aS = $("#agreeSecond").is(":checked");
		if(name == 0) {
			alert("이름을 바르게 입력해 주세요.");
			$("#name").focus();
			return false;
		} else if(id == 0 || (id < 8 || id > 16)) {
			alert("ID를 8~16자 사이로 입력해주세요.");
			$("#id").focus();
			return false;
		} else if($("#nonId").val() == "idUnCheck") {
			alert("ID중복체크를 해주세요");
			return false;
		} else if(pw == 0 || (pw < 8 || pw > 16)) {
			alert("PW를 8~16자 사이로 입력해주세요.");
			$("#pw").focus();
			return false;
		} else if(email == 0 || !$("#email").val().match("@")) {
			alert("이메일을 양식에 맞게 입력해주세요.");
			$("#email").focus();
			return false;
		} else if(phone == 0 || (phone < 9 || phone > 11) || $("#phone").val().match("-")) {
			alert("전화번호를 양식에 맞게 입력해주세요.");
			$("#phone").focus();
			return false;
		} else if($("#nonPhone").val() == "phoneUnCheck") {
			alert("전화번호 인증을 해주세요");
			return false;
		} else if(!man && !woman) {
			alert("성별을 선택해주세요.");
			$("#man").focus();
			return false;
		} else if(!aF) {
			alert("개인정보 1트에 동의해 주세요.");
			$("#agreeFirst").focus();
			return false;
		} else if(!aS) {
			alert("개인정보 2트에 동의해 주세요.");
			$("#agreeSecond").focus();
			return false;
		} else {
			return true;
		}
	});
	$("#joining").submit(function(event) {
		event.preventDefault();
		$.ajax({
			url : $("#joining").attr("action"),
			type : $("#joining").attr("method"),
			data : $("#joining").serialize(),
			success : function(data) {
				if(data.search("join-success") > -1) {
					alert("가입을 축하합니다.");
					$("#goLogin").trigger("click");
				} else {
					alert("가입을 실패했습니다.");
				}
			},
			error : function() {
				alert("서버에 접속을 실패했습니다.");
			}
		});
	});
	$("#idCheck").click(function(event) {
		var id = $("#id").val().length;
		if(id == 0 || (id < 8 || id > 16)) {
			alert("ID를 8~16자 사이로 입력해주세요.");
			$("#id").focus();
			return false;
		}
		event.preventDefault();
		$.ajax({
			url : "idCheck",
			type : "get",
			data : {id:$("#id").val()},
			success : function(data) {
				if(data.search("alreadyId") > -1) {
					alert("이미 사용중인 아이디입니다.");
					$("#id").focus();
				} else {
					alert("사용가능한 아이디 입니다.");
					$("#nonId").val("idCheck");
					$("#id").attr("readonly", "readonly");
				}
			},
			error : function() {
				alert("오류가 발생했습니다.");
			}
		});
	});
	$("#phoneCheck").click(function(event) {
		var phone = $("#phone").val().length;
		if(phone == 0 || (phone < 9 || phone > 11) || $("#phone").val().match("-")) {
			alert("전화번호를 양식에 맞게 입력해주세요.");
			$("#phone").focus();
			return false;
		}
		event.preventDefault();
		$.ajax({
			url : "phoneCheck",
			type : "get",
			data : {phone:$("#phone").val()},
			success : function(data) {
				if(data.search("alreadyPhone") > -1) {
					alert("이미 사용중인 전화번호입니다.");
					$("#phone").focus();
				} else {
					alert("인증이 완료되었습니다.");
					$("#nonPhone").val("phoneCheck");
					$("#phone").attr("readonly", "readonly");
				}
			},
			error : function() {
				alert("오류가 발생했습니다.");
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