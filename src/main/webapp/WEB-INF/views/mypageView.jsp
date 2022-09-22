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
	<div style="display: block;" id="profileAll">
		<p>프로필사진</p><p><img src="upImage/${mypage.profileImage}" alt="이미지 없음" style="width: 400px; height: 300px;" class="image"></p><br>
		<p>이름</p><p>${mypage.name}</p><br>
		<p>아이디</p><p>${mypage.id}</p><br>
		<p>닉네임</p><p>${mypage.nickName}</p><br>
		<p>생년월일</p><p>${mypage.birthday}</p><br>
		<p>이메일</p><p>${mypage.email}</p><br>
		<p>전화번호</p><p>${mypage.phone}</p><br>
		<p>성별</p><p>${mypage.gender}</p><br>
		<button type="button" id="goModify" class="btn btn-primary">수정</button>&nbsp;&nbsp;
		<a id="backHome" href="exsample" class="btn btn-primary">메인으로</a>&nbsp;&nbsp;
		<a id="memberOut1" href="memberOut1" class="btn btn-primary">회원탈되</a>
	</div>
	<div style="display: none;" id="modifyProfile">
		<form action="inforModify?${_csrf.parameterName}=${_csrf.token}" method="post" enctype="multipart/form-data" id="inforModify" name="inforModify">
			<div class="form-group">
				<label for="profileImage">프로필사진</label>
				<input type="file" class="form-control" id="profileImage" name="profileImage" style="display: none;">
				<br>
				<img src="upImage/${mypage.profileImage}" alt="이미지 없음" id="image" class="image" style="width: 400px; height: 300px;">
				<input type="hidden" value="noChange" id="hidden" name="hidden"><br><br>
				<button type="button" class="btn btn-primary" id="default">기본 사진으로 설정</button>
			</div>
			<div class="form-group">
				<label for="name">이름</label>
				<input type="text" class="form-control" id="name" name="name" value="${mypage.name}" readonly>
			</div>
			<div class="form-group">
				<label for="id">아이디</label>
				<input type="text" class="form-control" id="id" name="id" value="${mypage.id}" readonly>
			</div>
			<div class="form-group">
				<label for="nickName">닉네임</label>
				<input type="text" class="form-control" id="nickName" name="nickName" value="${mypage.nickName}">
			</div>
			<div class="form-group">
				<label for="birthday">생년월일</label>
				<input type="date" class="form-control p-4 bg-light w-25" id="birthday" name="birthday" value="${mypage.birthday}" required>
			</div>
			<div class="form-group">
				<label for="email">이메일</label>
				<input type="text" class="form-control" id="email" name="email" value="${mypage.email}" readonly>
			</div>
			<div class="form-group">
				<label for="phone">전화번호</label>
				<input type="text" class="form-control" id="phone" name="phone" value="${mypage.phone}" readonly>
			</div>
			<div class="form-group">
				성별
				<c:choose>
					<c:when test="${mypage.gender eq 'man'}">
						<div class="form-check">
							<label class="form-check-label">
								<input type="radio" id="man" class="form-check-input" name="gender" value="man" checked>남자
							</label>
						</div>
						<div class="form-check">
							<label class="form-check-label">
								<input type="radio" id="woman" class="form-check-input" name="gender" value="woman" disabled>여자
							</label>
						</div>
					</c:when>
					<c:otherwise>
						<div class="form-check">
							<label class="form-check-label">
								<input type="radio" id="man" class="form-check-input" name="gender" value="man" disabled>남자
							</label>
						</div>
						<div class="form-check">
							<label class="form-check-label">
								<input type="radio" id="woman" class="form-check-input" name="gender" value="woman" checked>여자
							</label>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		 	<button type="submit" class="btn btn-primary" id="sub">확인</button>&nbsp;&nbsp;
		 	<button type="button" class="btn btn-primary" id="modifyCancel">취소</button>&nbsp;&nbsp;
		 	<button type="reset" style="display: none;" id="reset">리셋</button>
		 	<a id="backHome" href="exsample" class="btn btn-primary">메인으로</a>&nbsp;&nbsp;
			<a id="memberOut1" href="memberOut1" class="btn btn-primary">회원탈되</a>
		</form>
	</div>
</div>
<script>
$(document).ready(function() {
	if($("img.image").attr("src") == "" || $("img.image").attr("src") == "upImage/") {
		$("img.image").attr("src", "upImage/default.png");
	}
	$("#memberOut1").click(function(event) {
		event.preventDefault();
		$.ajax({
			url : $("#memberOut1").attr("href"),
			type : "get",
			data : "",
			success : function(data) {
				$("#body").html(data);
			},
			error : function() {
				alert("에러입니다.");
			},
		});
	});
	$("#goModify").on("click", function() {
		$("#profileAll").attr("style", "display: none;");
		$("#modifyProfile").attr("style", "display: block;");
	});
	$("#modifyCancel").on("click", function() {
		$("#reset").trigger("click");
		$("#image").attr("src", "upImage/${mypage.profileImage}");
		if($("#image").attr("src") == "" || $("#image").attr("src") == "upImage/") {
			$("#image").attr("src", "upImage/default.png");
		}
		$("#modifyProfile").attr("style", "display: none;");
		$("#profileAll").attr("style", "display: block;");
	});
	$("#image").click(function() {
		$("input#profileImage").val("");
		$("#profileImage").trigger("click");
	});
	
	document.getElementById("profileImage").onchange = function () {
	    var reader = new FileReader();
	
	    reader.onload = function (e) {
	        document.getElementById("image").src = e.target.result;
	    };
	
	    reader.readAsDataURL(this.files[0]);
	    
	    $("#hidden").val("change");
	};
	$("#sub").click(function() {
		var birthday = $("#birthday").val();
		var profileImage = $("#profileImage").val();
		var nickName = $("#nickName").val().length;
		if(profileImage == "") {
			if(!confirm("프로필사진을 설정하지 않으시겠습니까?")) {
				return false;
			}
		}
		if(birthday == "") {
			alert("생년월일을 설정해주세요.");
			$("#birthday").focus();
			return false;
		}
		if(nickName < 2 || nickName > 16) {
			alert("닉네임을 2~16자 이내로 입력해주세요.");
			$("#nickName").focus();
			return false;
		} else {
			return true;
		}
	});
	$("#inforModify").on("submit", function(event) {
		let form = new FormData($('#inforModify')[0]);
		event.preventDefault();
		$.ajax({
			url : $("#inforModify").attr("action"),
			type : $("#inforModify").attr("method"),
			data : form,
			processData : false,
			contentType : false,
			success : function(data) {
				if(data.search("inforModify-success") > -1) {
					alert("정보를 수정했습니다.");
				} else {
					alert("정보를 수정하지 못했습니다.");
				}
			},
			complete : function() {
				location.reload();
			},
			error : function() {
				alert("에러입니다.");
			}
		});
	});
	$("#default").on("click", function() {
		$("#hidden").val("change");
		$("#image").attr("src", "upImage/default.png");
	});
});
</script>
</body>
</html>