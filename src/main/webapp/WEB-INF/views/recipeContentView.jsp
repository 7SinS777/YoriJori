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
<!-- jquery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- bootstrap -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">

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
	<sec:authentication property="principal.password" var="user_pw"/>
</sec:authorize>
<input type="hidden" value="${user_id}" id="loginUser">
<input type="hidden" value="${viewType}" id="viewType">
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
<h2><b>레시피 정보</b></h2>
<form action="recipeModifyView" method="post" id="recipeModifyView" name="recipeModifyView">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	<div class="form-group">
		<label for="no">번호 : </label>
		<input type="text" id="no" name="no" class="form-control" value="${recipeContent.no}" readonly>
	</div>
	<div class="form-group">
		<label for="id">작성자 : </label>
		<input type="text" id="id" name="id" class="form-control" value="${recipeContent.id}" readonly>
	</div>
	<div class="form-group">
		<label for="recipeType">종류 : </label>
		<input type="text" id="recipeType" name="recipeType" class="form-control" value="${recipeContent.recipeType}" readonly>
	</div>
	<div class="form-group">
		<label for="recipeStyle">상황 : </label>
		<input type="text" id="recipeStyle" name="recipeStyle" class="form-control" value="${recipeContent.recipeStyle}" readonly>
	</div>
	<div class="form-group">
		<label for="recipePeople">인분 : </label>
		<input type="text" id="recipePeople" name="recipePeople" class="form-control" value="${recipeContent.recipePeople}" readonly>
	</div>
	<div class="form-group">
		<label for="recipeTime">소요시간 : </label>
		<input type="text" id="recipeTime" name="recipeTime" class="form-control" value="${recipeContent.recipeTime}" readonly>
	</div>
	<div class="form-group">
		<label for="title">제목 : </label>
		<input type="text" id="title" name="title" class="form-control" value="${recipeContent.title}" readonly>
	</div>
	<div class="form-group">
		<label for="recipeIntro">소개 : </label>
		<textarea id="recipeIntro" name="recipeIntro" class="form-control" readonly>${recipeContent.recipeIntro}</textarea>
	</div>
	<div class="form-group">
		<label for="writeTime">작성시간 : </label>
		<input type="text" id="writeTime" name="writeTime" class="form-control" value="${recipeContent.writeTime}" readonly>
	</div>
	<div class="form-group">
		<label for="comments">댓글 수 : </label>
		<input type="text" id="comments" name="comments" class="form-control" value="${recipeContent.comments}" readonly>
	</div>
	<div class="form-group">
		<label for="hits">조회 수 : </label>
		<input type="text" id="hits" name="hits" class="form-control" value="${recipeContent.hits}" readonly>
	</div>
	<div class="form-group">
		<label for="likes">좋아요 수 : </label>
		<input type="text" id="likes" name="likes" class="form-control" value="${recipeContent.likes}" readonly>
	</div>
	<div class="form-group">
		<label for="topImage">대표 이미지 </label>
		<img id="topImage" src="upImage/${recipeContent.topImage}" alt="이미지 오류" style="max-width: 320px; height: 200px;">
		<input type="hidden" name="topImage" value="${recipeContent.topImage}">
	</div>
	내용<br>
	<c:forEach var="recipeWrite" items="${recipeWriteContent}" varStatus="status">
		<div class="form-inline">
			<label for="${status.count}">
				요리방법 ${status.count}
				<img src="upImage/${recipeWrite.recipeImage}" style="width: 400px; height: 300px;">
				<input type="hidden" name="recipeImage" value="${recipeWrite.recipeImage}">
			</label>
			<textarea id="${status.count}" class="form-control" name="recipeContent" rows="10" readonly>${recipeWrite.recipeContent}</textarea>
		</div>
	</c:forEach>
	<br>
	<div id="modifyButton" style="display: inline-block;">
		<button type="submit" class="btn btn-primary" id="recipeModify">레시피 수정하기</button>&nbsp;&nbsp;
		<button type="submit" class="btn btn-primary" id="recipeDelete">레시피 삭제하기</button>&nbsp;&nbsp;
	</div>
	<div id="recipeAllButton" style="display: inline-block;">
		<a id="goRecipeAllView" class="btn btn-primary">레시피 목록으로</a>
	</div>
</form>
<hr>
<form action="recipeComment" method="post" id="recipeComment" name="recipeComment">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	<input type="hidden" id="recipeNo" name="recipeNo" class="form-control" value="${recipeContent.no}" readonly>
	<input type="hidden" id="id" name="id" class="form-control" value="${user_id}">
	<div class="form-group">
		<label for="commentary">댓글작성</label>
		<textarea rows="3" class="form-control" name="commentary" id="commentary" placeholder="댓글을 작성하세요."></textarea>
	</div>
	<button type="submit" class="btn btn-primary" id="submits">작성하기</button>
</form>
<a id="goRecipeContentView" href="recipeContentView?no=${recipeContent.no}" style="display: none"></a>
<c:forEach var="recipeComments" items="${recipeComments}">
	<hr>
	<form action="recipeCommentModify" method="post" id="recipeCommentModify" class="recipeCommentModify" name="recipeCommentModify">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<input type="hidden" name="commentNo" id="commentNo" value="${recipeComments.commentNo}">
		<p class="commentWriter">${recipeComments.id}</p>
		<p class="commentTime">${recipeComments.commentTime}</p>
		<div style="display: block;">${recipeComments.commentary}</div>
		<div class="cModifyButton" style="display: block;">
			<button type="button" class="btn btn-primary commentModify">수정</button>&nbsp;
			<button type="submit" class="btn btn-primary commentDelete">삭제</button>
		</div>
		<div style="display: none;">
			<textarea rows="3" class="form-control" name="commentary" id="commentary" placeholder="댓글을 작성하세요.">${recipeComments.commentary}</textarea><br>
			<button type="submit" class="btn btn-primary commentCheck">확인</button>&nbsp;
			<button type="button" class="btn btn-primary commentCancel">취소</button>
		</div>
	</form>
</c:forEach>
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
	let loginUser = $("#loginUser").val();
	let writer = $("#id").val();
	let commentWriter = $("p.commentWriter");
	if(loginUser == writer) {
		$("#modifyButton").attr("style", "display: inline-block;");
	} else {
		$("#modifyButton").attr("style", "display: none;");
	}
	for(let i=0; i<commentWriter.length; i++) {
		if(loginUser == commentWriter.eq(i).text()) {
			$("div.cModifyButton").eq(i).attr("style", "display: block;");
		} else {
			$("div.cModifyButton").eq(i).attr("style", "display: none;");
		}
	}
	$("#goRecipeAllView").click(function(event) {
		event.preventDefault();
		$.ajax({
			url : "recipeAllView?chose=times",
			type : "get",
			data : formData,
			success : function(data) {
				$("#body").html(data);
			},
			error : function() {
				alert("에러입니다.");
			}
		});
	});
	$("#recipeModify").on("click", function() {
		$("#recipeModifyView").attr("action", "recipeModifyView");
		return true;
	});
	$("#recipeDelete").on("click", function() {
		if(confirm("삭제하시겠습니까?")) {
			$("#recipeModifyView").attr("action", "recipeDelete");
			return true;
		} else {
			return false;
		}
	});
	$("#recipeModifyView").submit(function() {
		event.preventDefault();
		$.ajax({
			url : $("#recipeModifyView").attr("action"),
			type : $("#recipeModifyView").attr("method"),
			data : $("#recipeModifyView").serialize(),
			success : function(data) {
				if($("#recipeModifyView").attr("action") == "recipeDelete") {
					if(data.search("delete-success") > -1) {
						alert("삭제되었습니다.");
						$("#goRecipeAllView").trigger("click");
					} else {
						alert("삭제하지 못했습니다.");
					}
				} else {
					$("#body").html(data);
				}
			},
			error : function() {
				alert("에러입니다.");
			}
		});
	});
	$("#submits").on("click", function() {
		if($("#commentary").val() == "") {
			alert("댓글 내용을 작성해 주세요.");
			return false;
		}
		return true;
	});
	$("#recipeComment").submit(function(event) {
		event.preventDefault();
		$.ajax({
			url : $("#recipeComment").attr("action"),
			type : $("#recipeComment").attr("method"),
			data : $("#recipeComment").serialize(),
			success : function(data) {
				if(data.search("comment-success") > -1) {
					alert("댓글을 작성했습니다.");
					$("#goRecipeContentView").trigger("click");
				} else {
					alert("댓글 작성을 실패했습니다.");
				}
			},
			error : function() {
				alert("에러입니다.");
			}
		});
	});
	$("#goRecipeContentView").click(function(event) {
		event.preventDefault();
		$.ajax({
			url : $("#goRecipeContentView").attr("href"),
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
	$("button.commentModify").on("click", function(event) {
		let div = $(event.target).parent();
		div.attr("style", "display: none;");
		div.prev().attr("style", "display: none;");
		div.next().attr("style", "display: block;");
	});
	$("button.commentCancel").on("click", function(event) {
		let div = $(event.target).parent();
		div.attr("style", "display: none;");
		div.prev().attr("style", "display: block;");
		div.prev().prev().attr("style", "display: block;");
	});
	$("button.commentDelete").on("click", function(event) {
		$(event.target).parent().parent().attr("action", "recipeCommentModify?type=delete");
		return true;
	});
	$("button.commentCheck").on("click", function(event) {
		let textarea = $(event.target).prev().prev();
		if(textarea.val() == "") {
			alert("댓글 내용을 작성해 주세요.");
			return false;
		}
		$(event.target).parent().parent().attr("action", "recipeCommentModify?type=modify");
		return true;
	});
	$(".recipeCommentModify").on("submit", function(event) {
		let form = $(event.target);
		event.preventDefault();
		$.ajax({
			url : form.attr("action"),
			type : form.attr("method"),
			data : form.serialize(),
			success : function(data) {
				if(data.search("delete-success") > -1) {
					alert("댓글을 삭제했습니다.");
					$("#goRecipeContentView").trigger("click");
				} else if(data.search("delete-failed") > -1) {
					alert("댓글 삭제를 실패했습니다.");
				} else if(data.search("modify-success") > -1) {
					alert("댓글을 변경했습니다.");
					$("#goRecipeContentView").trigger("click");
				} else {
					alert("댓글 변경을 실패했습니다.");
				}
			},
			error : function() {
				alert("에러입니다.");
			}
		});
	});
});
function fileSelect(event) {
	var reader = new FileReader();
	let img = $(event.target).next();
	
	reader.onload = function(event){
		img.attr("src", event.target.result);
	};
	
	reader.readAsDataURL(event.target.files[0]);
}
</script>
</body>
</html>