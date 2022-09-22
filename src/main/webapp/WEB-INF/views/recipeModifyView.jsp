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
<h2><b>레시피 수정</b></h2>
<form action="recipeModify?${_csrf.parameterName}=${_csrf.token}" method="post" id="recipeModify" name="recipeModify" enctype="multipart/form-data">
	<input type="hidden" name="no" value="${recipeContent.no}">
	<input type="hidden" name="id" value="${user_id}">
	<div class="container" style="background-color:white; margin-top:50px; height: 300px;" >
		<div id="image_container" style="float:right; margin-right:200px;">
		 	<input type="file" id="files" name="topImage" style="display: none;">
		 	<img id="image" style="width: 400px; height: 300px;" src="upImage/${recipeContent.topImage}">
		</div>
		레시피 제목 :&nbsp;&nbsp;<input type="text" id="title" style="width:250;" placeholder="예)소고기미역국 끓이기" name="title" value="${recipeContent.title}"><br/><br/>
		<p style="display:inline-block; vertical-align:top;">요리 소개 :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
		<textarea name="recipeIntro" id="recipeIntro" style="height:100px; width:350px; resize:none;" placeholder="레시피 소개">${recipeContent.recipeIntro}</textarea><br/><br/>
		<p style="display:inline-block;">카테고리 :</p>
		<c:set var="type" value='<%=new String[] {"메인반찬", "밑반찬", "국/탕/찌개", "디저트", "밥", "양념", "샐러드", "음료/술", "기타"}%>'/>
		<select name="recipeType" id="recipeType">
			<option>종류별</option>
			<c:forEach var="types" items="${type}">
				<c:choose>
					<c:when test="${recipeContent.recipeType eq types}">
						<option selected>${types}</option>
					</c:when>
					<c:otherwise>
						<option>${types}</option>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</select>
		<c:set var="style" value='<%=new String[] {"일상", "간편", "다이어트", "술안주", "야식", "해장", "영양식", "손님접대", "기타"}%>'/>
		<select name="recipeStyle" id="recipeStyle">
			<option>상황별</option>
			<c:forEach var="styles" items="${style}">
				<c:choose>
					<c:when test="${recipeContent.recipeStyle eq styles}">
						<option selected>${styles}</option>
					</c:when>
					<c:otherwise>
						<option>${styles}</option>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</select><br/><br/>
		<p style="display:inline-block;">요리 정보 :</p>
		<c:set var="men" value='<%=new String[] {"1인분", "2인분", "3인분", "4인분", "5인분 이상"}%>'/>
		<select name="recipePeople" id="recipePeople">
			<option>인원</option>
			<c:forEach var="mens" items="${men}">
				<c:choose>
					<c:when test="${recipeContent.recipePeople eq mens}">
						<option selected>${mens}</option>
					</c:when>
					<c:otherwise>
						<option>${mens}</option>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</select>
		<c:set var="time" value='<%=new String[] {"3분 이하", "5분 이하", "10분 이하", "30분 이하", "1시간 이하", "1시간 이상"}%>'/>
		<select name="recipeTime" id="recipeTime">
			<option>시간</option>
			<c:forEach var="times" items="${time}">
				<c:choose>
					<c:when test="${recipeContent.recipeTime eq times}">
						<option selected>${times}</option>
					</c:when>
					<c:otherwise>
						<option>${times}</option>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</select>
	</div>
	<div class="content" style="background-color: white; margin-top: 20px; margin-left: 130px; margin-right: 130px;">
		<div id="recycle">
			<c:forEach var="recipeWrite" items="${recipeWriteContent}" varStatus="status">
				<div id="Item${status.count}" class="step" style="display: inline-block;"> 
					<button type="button" style="display: inline-block; float: right;" class="btn btn-primary delete">삭제</button>
					<p style="display: inline-block; vertical-align: top; font-size: 25px; color: Yellowgreen;" class="title">요리방법${status.count}</p>
					<div id="Text${status.count}">
						<textarea name="recipeContent" id="${status.count}" class="form-control recipeContent" placeholder="예) 제육볶음" style="height: 160px;
						width: 430px; resize: none; display: inline-block;" name="recipeContent">${recipeWrite.recipeContent}</textarea>&nbsp;
						<img src="upImage/${recipeWrite.recipeImage}" class="imgs" style="width: 200px; height: 150px;">
						<input type="file" name="recipeImage" id="file1" class="imgFile" onchange="fileSelect(event)" style="display: none;"/>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
	<button id="rBtn" type="button" style="margin-left:20%;">순서 추가</button>
	<br/><br/>	
	<button type="submit" class="btn btn-primary" id="submit">레시피 수정하기</button>&nbsp;&nbsp;
	<a id="goRecipeAllView" class="btn btn-primary">레시피 목록으로</a>&nbsp;&nbsp;
	<a id="goRecipeContentView" class="btn btn-primary">취소</a>
</form>
<script>
$(document).ready(function() {
	$("#image").click(function() {
		$("#files").trigger("click");
	});
	
	document.getElementById("files").onchange = function () {
	    var reader = new FileReader();
	
	    reader.onload = function (e) {
	        document.getElementById("image").src = e.target.result;
	    };
	
	    reader.readAsDataURL(this.files[0]);
	};

 	$("#rBtn").click(function() {
 		let steps = document.getElementsByClassName("step").length+1;
		let newDiv = document.createElement("div");
		newDiv.setAttribute("id", "Item"+steps);
		newDiv.setAttribute("class", "step");
		newDiv.setAttribute("style", "display: inline-block");
		newDiv.innerHTML = 
			"<button type='button' style='display: inline-block; float: right;' class='btn btn-primary delete'>삭제</button>"
			+ "<p style='display:inline-block; vertical-align:top; font-size:25px; color:Yellowgreen;' class='title'>요리방법"+steps+"</p>&nbsp;"
			+ "<div id='Text"+steps+"'>"
			+ "<textarea name='recipeContent' id='"+steps+"' class='form-control recipeContent' placeholder='예) 제육볶음' style='height: 160px; width: 430px; resize: none; display: inline-block;'></textarea>&nbsp;&nbsp;"
			+ "<img src='' class='imgs' style='width: 200px; height: 150px;'>"
			+ "<input type='file' name='recipeImage' id='file"+steps+"' class='imgFile' onchange='fileSelect(event)' style='display: none;'/>"
			+ "</div>";
		$("#recycle").append(newDiv);
	});
	$(document).on("click", "img.imgs", function(event) {
		let imgFiles = $(event.target).next();
		imgFiles.trigger("click");
	});
	
	$(document).on("click", "#submit", function() {
		if($("#files").val() == "") {
			alert("대표 이미지를 넣어주세요.");
			return false;
		} else if($("#title").val() == "") {
			alert("제목을 적어주세요.");
			return false;
		} else if($("#title").val().length < 2 || $("#title").val().length > 100) {
			alert("제목을 2~100자 이내로 적어주세요");
			return false;
		} else if($("#recipeIntro").val() == "") {
			alert("요리소개를 적어주세요.");
			return false;
		} else if($("#recipeType").val() == "종류별") {
			alert("종류를 설정해주세요");
			return false;
		} else if($("#recipeStyle").val() == "상황별") {
			alert("상황을 설정해주세요");
			return false;
		} else if($("#recipePeople").val() == "인원") {
			alert("인원을 설정해주세요");
			return false;
		} else if($("#recipeTime").val() == "시간") {
			alert("시간을 설정해주세요");
			return false;
		}
		let steps = document.getElementsByClassName("step").length;
		let recipeContent = document.getElementsByClassName("recipeContent");
		let imgFile = document.getElementsByClassName("imgFile");
		for(let i=0; i<steps; i++) {
			if(recipeContent[i].value == "") {
				alert("요리방법을 적어주세요.");
				return false;
			} else if(imgFile[i].value == "") {
				alert("요리방법의 이미지를 넣어주세요.");
				return false;
			}
		}
		return true;
	});
	$("#goRecipeAllView").click(function(event) {
		event.preventDefault();
		$.ajax({
			url : "recipeAllView?chose=times",
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
	$("#goRecipeContentView").click(function(event) {
		event.preventDefault();
		$.ajax({
			url : "recipeContentView?no=${recipeContent.no}",
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
	$("#recipeModify").submit(function() {
		let form = new FormData($('#recipeModify')[0]);
		event.preventDefault();
		$.ajax({
			url : $("#recipeModify").attr("action"),
			type : $("#recipeModify").attr("method"),
			data : form,
			processData : false,
			contentType : false,
			success : function(data) {
				alert("레시피를 수정했습니다.");
				$("#goRecipeContentView").trigger("click");
			},
			error : function() {
				alert("에러입니다.");
			}
		});
	});
	
	$(document).on("click", "button.delete", function(event) {
		let steps = document.getElementsByClassName("step").length;
		if(steps < 2) {
			alert("요리 순서는 1개 이상 필요합니다.");
			return;
		}
		let recycle = $(event.target).parent();
		recycle.remove();
		
		steps = document.getElementsByClassName("step").length;
		for(let i=0; i<steps; i++) {
			$("div.step").eq(i).attr("id", "Item"+(i+1));
			let title = $("p.title").eq(i);
			title.text("요리방법"+(i+1));
			title.next().attr("id", "Text"+(i+1));
			title.next().find("textarea").attr("id", (i+1));
			title.next().find("input").attr("id", "file"+(i+1));
		}
	});
});
function fileSelect(event) {
	let reader = new FileReader();
	let img = $(event.target).prev();
	let id = $(event.target).attr("id")-1;
	
	reader.onload = function(event) {
		img.attr("src", event.target.result);
	};
	reader.readAsDataURL(event.target.files[0]);
}
</script>
</body>
</html>