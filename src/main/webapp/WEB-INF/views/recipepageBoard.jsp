<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
<meta id="_csrf" name="_csrf" content="${_csrf.token}"/> 
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
<div class="my-5" id="submain">
	<h3 class="text-center text-danger">게시판</h3>
	<a id="recipeRegister" class="btn btn-primary" href="recipeRegister">레시피 작성</a>
	<div class="btn-group btn-group-sm" style="float: right;">
		<button type="button" class="btn btn-primary" id="listHits" name="hits">조회순</button>
		<button type="button" class="btn btn-primary" id="listTimes" name="times">최신순</button>
	</div>
	<input type="hidden" value="${search}" id="searchResult">
	<input type="hidden" value="${searchWhat}" id="searchWhatResult">
	<c:forEach var="types" items="${recipeTypes}">
		<input type="hidden" value="${types}" name="recipeTypes">
	</c:forEach>
	<c:forEach var="styles" items="${recipeStyles}">
		<input type="hidden" value="${styles}" name="recipeStyles">
	</c:forEach>
	<c:forEach var="peoples" items="${recipePeoples}">
		<input type="hidden" value="${peoples}" name="recipePeoples">
	</c:forEach>
	<c:forEach var="times" items="${recipeTimes}">
		<input type="hidden" value="${times}" name="recipeTimes">
	</c:forEach>
<table id="recipeList" class="table table-hover text-center">
	<thead>
		<tr>
			<th>No.</th>
			<th>분류</th>
			<th>대표 이미지</th>
			<th>작성자</th>
			<th>제목</th>
			<th>작성일</th>
			<th>조회수</th>
			<th>좋아요 수</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${recipeList}" var="recipe">
			<tr>
				<td class="rNo" style="width: 50px;">${recipe.no}</td>
				<td class="rRecipeType">${recipe.recipeType}</td>
				<td class="rTopImage"><img src="upImage/${recipe.topImage}" alt="이미지 오류" style="max-width: 160px; height: 100px;"></td>
				<td class="rId">${recipe.id}</td>
				<td class="rTitle"><a class="recipeContentView" href="recipeContentView?no=${recipe.no}">${recipe.title}</a></td>
				<td class="rWriteTime">${recipe.writeTime}</td>
				<td class="rHits">${recipe.hits}</td>
				<td>${recipe.likes}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
</div>

<script>
$(document).ready(function() {
	let viewType = $("#viewType").val();
	let search = $("#searchResult").val();
	let searchWhat = $("#searchWhatResult").val();
	let recipeTypes = $("input[name='recipeTypes']");
	let recipeType = new Array();
	for(let i=0; i<recipeTypes.length; i++) {
		recipeType.push(recipeTypes.eq(i).val());
	}
	let recipeStyles = $("input[name='recipeStyles']");
	let recipeStyle = new Array();
	for(let i=0; i<recipeStyles.length; i++) {
		recipeStyle.push(recipeStyles.eq(i).val());
	}
	let recipePeoples = $("input[name='recipePeoples']");
	let recipePeople = new Array();
	for(let i=0; i<recipePeoples.length; i++) {
		recipePeople.push(recipePeoples.eq(i).val());
	}
	let recipeTimes = $("input[name='recipeTimes']");
	let recipeTime = new Array();
	for(let i=0; i<recipeTimes.length; i++) {
		recipeTime.push(recipeTimes.eq(i).val());
	}
	let formData = {
		viewType : viewType,
		search : search,
		searchWhat : searchWhat,
		recipeType : recipeType,
		recipeStyle : recipeStyle,
		recipePeople : recipePeople,
		recipeTime : recipeTime
	}
	
	$("#recipeRegister").click(function(event) {
		event.preventDefault();
		$.ajax({
			url : "recipeRegister",
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
	$("#listHits").click(function(event) {
		event.preventDefault();
		let search = $("#searchResult").val();
		let searchWhat = $("#searchWhatResult").val();
		$.ajax({
			url : "recipeAllView?chose=hits",
			type : "get",
			data : {
				search : search,
				searchWhat : searchWhat
			},
			success : function(data) {
				$("#body").html(data);
			},
			error : function() {
				alert("에러입니다.");
			}
		});
	});
	$("#listTimes").click(function(event) {
		event.preventDefault();
		let search = $("#searchResult").val();
		let searchWhat = $("#searchWhatResult").val();
		$.ajax({
			url : "recipeAllView?chose=times",
			type : "get",
			data : {
				search : search,
				searchWhat : searchWhat
			},
			success : function(data) {
				$("#body").html(data);
			},
			error : function() {
				alert("에러입니다.");
			}
		});
	});
	$("a.recipeContentView").click(function(event) {
		event.preventDefault();
		let search = $("#searchResult").val();
		let searchWhat = $("#searchWhatResult").val();
		let ceo = $(event.target);
		$.ajax({
			url : ceo.attr("href"),
			type : "get",
			data : {
				search : search,
				searchWhat : searchWhat
			},
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