<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<!-- RWD -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- MS -->
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8,IE=EmulateIE9"/> 
<title>JSP</title>
<!--bootstrap-->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<!--jquery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!--propper jquery -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<!--latest javascript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<!--fontawesome icon-->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" 
	integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
<!--google icon -->
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
</head>
<body>
<h3 class="text">내정보 수정</h3>
<form action="InforView?${_csrf.parameterName}=${_csrf.token}" method="post" enctype="multipart/form-data">
	<div class="form-group">
		<label for="photo">프로필사진</label>
		<input type="file" class="form-control" id="photo" placeholder="프로필 사진" name="rPhoto" required>
	</div>
			
	<div class="form-group">
		<label for="uEmail">이메일</label>
		<input type="text" class="form-control" id="email" placeholder="이메일" name="email" required>
	</div>

	<div class="form-group">
		<label for="uNickname">닉네임</label>
		<input type="text" class="form-control" id="nickName" placeholder="닉네임" name="nickName" required>
	</div>
	
	<div class="form-group">
		<div class="form-group">
			<label for="Birth">생년월일</label>
			<input type="date" class="form-control p-4 bg-light w-25" id="date" name="date" required>
		</div>		
	</div>
	
	<div class="form-group">
		<label for="gender">성별</label>
		<input type="radio" name="gender" id="gender" >남성  
		<input type="radio" name="gender" id="gender" >여성
	</div>
	
 	<button type="submit" class="btn btn-primary">수정</button>
 	<button type="button" class="btn btn-primary" id="cancel">취소</button>
</form>
</body>
<script>
$("#cancel").click(function(){
	$.ajax({
		url : "exsample",
		type : "get",
		data : "",
		success : function(data) {
			alert("취소되었습니다.");
		};
		error : function() {
			alert("에러입니다.");
		}			
	});		
});
</script>
</html>