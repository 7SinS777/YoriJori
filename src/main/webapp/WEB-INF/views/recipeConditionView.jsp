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
<link rel="stylesheet" type="text/css" href="css/recipeCondition.css">
</head>
<body>
<div class="container">
	<form action="recipeAllView?chose=times&${_csrf.parameterName}=${_csrf.token}" method="post" id="recipeCondition">
		<p>카테고리</p>
		<div class="my-3">
			<c:set var="type" value='<%=new String[] {"메인반찬", "밑반찬", "국/탕/찌개", "디저트", "밥", "양념", "샐러드", "음료/술", "기타"}%>'/>
			종류별<br>
			<c:forEach var="types" items="${type}" varStatus="status">
				<button type="button" class="nonSelected" id="type${status.index}" name="recipeType" value="${types}">${types}</button>
			</c:forEach>
		</div>
		<div class="my-3">
			<c:set var="style" value='<%=new String[] {"일상", "간편", "다이어트", "술안주", "야식", "해장", "영양식", "손님접대", "기타"}%>'/>
			상황별<br>
			<c:forEach var="styles" items="${style}" varStatus="status">
				<button type="button" class="nonSelected" id="style${status.index}" name="recipeStyle" value="${styles}">${styles}</button>
			</c:forEach>
		</div>
		<br>
		<p>요리정보</p>
		<div class="my-3">
			<c:set var="men" value='<%=new String[] {"1인분", "2인분", "3인분", "4인분", "5인분 이상"}%>'/>
			인원<br>
			<c:forEach var="mens" items="${men}" varStatus="status">
				<button type="button" class="nonSelected" id="people${status.index}" name="recipePeople" value="${mens}">${mens}</button>
			</c:forEach>
		</div>
		<div class="my-3">
			<c:set var="time" value='<%=new String[] {"3분 이하", "5분 이하", "10분 이하", "30분 이하", "1시간 이하", "1시간 이상"}%>'/>
			시간<br>
			<c:forEach var="times" items="${time}" varStatus="status">
				<button type="button" class="nonSelected" id="time${status.index}" name="recipeTime" value="${times}">${times}</button>
			</c:forEach>
		</div>
		<button type="submit" id="sbm">확인</button>
	</form>
</div>
<script>
$(document).ready(function() {
	$("#recipeCondition").on("submit", function(e) {
		e.preventDefault();
		let recipeTypes = $("button[name='recipeType'].selected");
		let recipeType = new Array();
		for(let i=0; i<recipeTypes.length; i++) {
			recipeType.push(recipeTypes.eq(i).val());
		}
		let recipeStyles = $("button[name='recipeStyle'].selected");
		let recipeStyle = new Array();
		for(let i=0; i<recipeStyles.length; i++) {
			recipeStyle.push(recipeStyles.eq(i).val());
		}
		let recipePeoples = $("button[name='recipePeople'].selected");
		let recipePeople = new Array();
		for(let i=0; i<recipePeoples.length; i++) {
			recipePeople.push(recipePeoples.eq(i).val());
		}
		let recipeTimes = $("button[name='recipeTime'].selected");
		let recipeTime = new Array();
		for(let i=0; i<recipeTimes.length; i++) {
			recipeTime.push(recipeTimes.eq(i).val());
		}
		let formData = {
			recipeType : recipeType,
			recipeStyle : recipeStyle,
			recipePeople : recipePeople,
			recipeTime : recipeTime,
			viewType : "condition"
		}
		$.ajax({
			url : $("#recipeCondition").attr("action"),
			type : $("#recipeCondition").attr("method"),
			data : formData,
			success : function(data) {
				$("#body").html(data);
			},
			error : function() {
				alert("에러입니다.");
			}
		});
	});
	$(".nonSelected, .selected").on("click", function(event) {
		let button = $(event.target);
		if(button.attr("class") == "nonSelected") {
			button.attr("class", "selected");
		} else if(button.attr("class") == "selected") {
			button.attr("class", "nonSelected");
		}
	});
});
</script>
</body>
</html>