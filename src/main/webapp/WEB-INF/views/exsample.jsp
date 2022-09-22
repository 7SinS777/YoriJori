<%@page import="java.util.ArrayList"%>
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
<!-- http://ielselog.blogspot.com/2013/10/css-color-keywords.html -->
<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>

<!-- 로그인 id 반환 var값 user_id를 EL로 사용 -->
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.username" var="user_id"/>
	<sec:authentication property="principal.password" var="user_pw"/>
</sec:authorize>

<div class="yj">
	<div class="yj-top-wrap">
		<div class="yj-top">
			<h1 class="yj-top-logo">
				<a href="exsample">
					<img src="image/요리조리 로고3.png" alt="YORIJORI">
				</a>
			</h1>
			<div class="yj-top-search">
				<form action="recipeAllView?${_csrf.parameterName}=${_csrf.token}" method="get" id="recipeSearch" name="recipeSearch">
					<input type="hidden" value="search" name="viewType">
					<div class="input-group d-inline-block">
						<input hidden="hidden" value="sTitle" id="searchWhat" name="searchWhat">
						<input hidden="hidden" value="times" id="chose" name="chose">
						<div class="input-group-prepend d-inline">
							<div class="dropdown d-inline">
								<button type="button" class="btn btn-primary dropdown-toggle search" data-toggle="dropdown" style="display: inline-block; width: 120px;">제목</button>
								<div class="dropdown-menu">
									<a class="dropdown-item search" id="sTitle" style="display: none;">제목</a>
									<a class="dropdown-item search" id="sTitleAndContent">제목+내용</a>
									<a class="dropdown-item search" id="sContent">내용</a>
									<a class="dropdown-item search" id="sWriter">작성자</a>
								</div>
							</div>
						</div>
						<input type="text" placeholder="제육" class="form-control" style="width: 260px;" id="search" name="search">
						<div class="input-group-append d-inline">
							<span class="input-group-btn">
								<button type="submit" class="btn btn-info" id="searchSubmit">검색</button>
							</span>
						</div>
					</div>
				</form>
			</div>
			<div id="profile" class="yj-top-profile">
				<sec:authorize access="isAnonymous()">
					<a class="btn btn-black" id="joinView" href="joinView">회원가입</a>
					<a class="btn btn-black" id="loginView" href="loginView">로그인</a>
				</sec:authorize>
				<sec:authorize access="isAuthenticated()"> <!-- 로그인한 상태에서 로그아웃 버튼 표시 -->
					<span id="userId">${user_id}</span>님 안녕하세요<br>
					<a class="btn btn-black" id="mypageView" href="mypageView">마이페이지</a>
					<a class="btn btn-black" id="logoutView" href="logoutView">로그아웃</a>
				</sec:authorize>
			</div>
		</div>
	</div>
	<!-- 마이페이지, 프로필 -->
	<nav class="navbar navbar-expand-md yj-top-nav" style="color:black; font-weight:bold;" onMouseover="this.style.color='yellowgreen';" onMouseout="this.style.color='black';">
		<div class="container">
			<ul class="navbar-nav w-100">
				<li class="nav-item col text-center">
					<a id="recipeAllView" class="nav-link" href="recipeAllView">레시피 전체보기</a>
				</li>
				<li class="nav-item col text-center">
				 	<a id="recipeConditionView" class="nav-link" href="recipeConditionView">레시피 조건보기</a>
				</li>
				<li class="nav-item col text-center">
				 	<a class="nav-link" href="#">재료로 레시피 찾기</a>
				</li>			
			</ul>
		</div>
	</nav>
</div>

<div id="body" class="container p-0" style="width: 1000px;">
	<div id="eventslide" class="carousel slide p-0" data-ride="carousel" style="width: 100%; height: 100%; margin-left: auto; margin-right: auto;">
		<!-- 슬라이드의 위치를 표시하는 마커 엘리먼트는 ul을 이용,class="carousel-indicators"를 사용-->
		<!--data-target은 마커 위치,data-slide-to는 슬라이드 번호  -->
		<ul class="carousel-indicators">
			<li data-target="#eventslide" data-slide-to="0" class="active"></li>
			<li data-target="#eventslide" data-slide-to="1" ></li>
			<li data-target="#eventslide" data-slide-to="2" ></li>			
		</ul>
		<div class="carousel-inner">
			<div class="carousel-item active">
				 <img src="image/default.png" alt="event1" class="img-fluid"/>
				 <div class="carousel-caption">
			        <h3>Event1</h3>
			     </div>
			</div>
			<div class="carousel-item">
				 <img src="image/default.png" alt="event2" class="img-fluid"/>
				 <div class="carousel-caption">
			        <h3>Event2</h3>
			     </div>
			</div>
			<div class="carousel-item">
				 <img src="image/default.png" alt="event3" class="img-fluid"/>
				 <div class="carousel-caption">
			        <h3>Event3</h3>
			     </div>
			</div>
		</div>
		<a class="carousel-control-prev" href="#eventslide" data-slide="prev"> <!-- 앞전 -->
			<span class="carousel-control-prev-icon"></span> <!-- 아이콘처리 -->
		</a>
		<a class="carousel-control-next" href="#eventslide" data-slide="next"> <!-- 뒤 -->
			<span class="carousel-control-next-icon"></span> <!-- 아이콘처리 -->
		</a>
	</div>
	<div class="row mt-5">
		<div class="col-md-4">
			<h2>About Me</h2>
			<h5>Photo of me:</h5>
			<div class="fakeimg">
				<img src="image/strawberry.png" style="width: 100%; height: 100%;">
			</div>
			<p>Some text about me in culpa qui officia deserunt mollit anim..</p>
			<h3>Some Links</h3>
			<p>수직메뉴 만들기</p>
			<ul class="nav nav-pills flex-column">
				<li class="nav-item">
					<a class="nav-link active" href="#">Active</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="#">Link</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="#">Link</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="#">Link</a>
				</li>
			</ul>
		</div>
		<div class="col-md-8">
			<h2>TITLE HEADING</h2>
			<h5>Title description, Dec 7, 2017</h5>
			<div class="fakeimg">
				<img src="image/beach.png" alt="beach" class="w-100 h-100">
			</div>
			<p>Some text..</p>
			<p>Some text.. Some text.. Some text..</p>
			<br>
			<h2>TITLE HEADING</h2>
			<h5>Title description, Dec 7, 2017</h5>
			<div class="fakeimg">
				<img src="image/Desert.png" alt="desert" class="w-100 h-100">
			</div>
			<p>Some text..</p>
			<p>Some text.. Some text.. Some text..</p>
			<br>
		</div>
	</div>
</div>

<script>
$(document).ready(function() {
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
	$("#loginView").click(function(event) {
		event.preventDefault();
		$.ajax({
			url : $("#loginView").attr("href"),
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
	$("#mypageView").click(function(event) {
		event.preventDefault();
		$.ajax({
			url : $("#mypageView").attr("href"),
			type : "get",
			data : {userId:$("#userId").text()},
			success : function(data) {
				$("#body").html(data);
			},
			error : function() {
				alert("에러입니다.");
			}
		});
	});
	$("#recipeAllView").click(function(event) {
		event.preventDefault();
		$.ajax({
			url : "recipeAllView?chose=times",
			type : "get",
			data : {
				viewType : "all"
			},
			success : function(data) {
				$("#body").html(data);
			},
			error : function() {
				alert("에러입니다.");
			}
		});
	});
	$("#recipeConditionView").click(function(event) {
		event.preventDefault();
		$.ajax({
			url : "recipeConditionView",
			type : "get",
			data : {
				viewType : "condition"
			},
			success : function(data) {
				$("#body").html(data);
			},
			error : function() {
				alert("에러입니다.");
			}
		});
	});
	$("a.search").on("click", function(event) {
		$("a.search").attr("style", "display: inline;");
		$("button.search").text($(event.target).text());
		$("#searchWhat").attr("value", $(event.target).attr("id"));
		$(event.target).attr("style", "display: none;");
	});
	$("#searchSubmit").on("click", function() {
		let search = $("search").val();
		if(search == "") {
			alert("검색어를 입력해 주세요.");
			return false;
		}
		return true;
	});
	$("#recipeSearch").on("submit", function(event) {
		event.preventDefault();
		$.ajax({
			url : $("#recipeSearch").attr("action"),
			type : $("#recipeSearch").attr("method"),
			data : $("#recipeSearch").serialize(),
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