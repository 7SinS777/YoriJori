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
<link rel="stylesheet" type="text/css" href="css/main.css">

</head>
<body>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.username" var="user_id"/>
</sec:authorize>
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

<h2 style="margin-top:50px"><b>레시피 등록</b></h2>
<form action="YJRecipeWrite?${_csrf.parameterName}=${_csrf.token}" id="recipeWrite" method="post" enctype="multipart/form-data">
	<input type="hidden" name="id" value="${user_id}">
	<div class="container" style="background-color:white; margin-top:50px; height: 300px;" >
		<div id="image_container" style="float:right; margin-right:200px;">
		 	<input type="file" id="files" name="topImage" style="display: none;">
		 	<img src="https://recipe1.ezmember.co.kr/img/pic_none4.gif" id="image" style="width: 200px; height: 150px;">
		</div>
		레시피 제목 :&nbsp;&nbsp;<input type="text" id="title" style="width:250;" placeholder="예)소고기미역국 끓이기" name="title"><br/><br/>
		<p style="float:left;">요리 소개 :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
			<textarea name="recipeIntro" id="recipeIntro" style="height:100px; width:350px; resize:none; float:left;" placeholder="요리 소개글 작성"></textarea><br/><br/><br/><br/><br/>
		<br/><p style="float:left;">카테 고리 :&nbsp;</p>
		<c:set var="type" value='<%=new String[] {"메인반찬", "밑반찬", "국/탕/찌개", "디저트", "밥", "양념", "샐러드", "음료/술", "기타"}%>'/>
		<select name="recipeType" id="recipeType">
			<option>종류별</option>
			<c:forEach var="types" items="${type}">
				<option>${types}</option>
			</c:forEach>
		</select>
		<c:set var="style" value='<%=new String[] {"일상", "간편", "다이어트", "술안주", "야식", "해장", "영양식", "손님접대", "기타"}%>'/>
		<select name="recipeStyle" id="recipeStyle">
			<option>상황별</option>
			<c:forEach var="styles" items="${style}">
				<option>${styles}</option>
			</c:forEach>
		</select><br/><br/>
		<p style="display:inline-block;">요리 정보 :</p>
		<c:set var="men" value='<%=new String[] {"1인분", "2인분", "3인분", "4인분", "5인분 이상"}%>'/>
		<select name="recipePeople" id="recipePeople">
			<option>인원</option>
			<c:forEach var="mens" items="${men}">
				<option>${mens}</option>
			</c:forEach>
		</select>
		<c:set var="time" value='<%=new String[] {"3분 이하", "5분 이하", "10분 이하", "30분 이하", "1시간 이하", "1시간 이상"}%>'/>
		<select name="recipeTime" id="recipeTime">
			<option>시간</option>
			<c:forEach var="times" items="${time}">
				<option>${times}</option>
			</c:forEach>
		</select>
	</div>
	<div class="content" style="background-color: white; margin-top: 20px;  margin-right: 130px;">
		<div id="recycle">
			<div id="Item1" class="step" style="display: inline-block;">
				<button type="button" class="btn btn-black delete" style="float:right;">삭제</button>
				<p style="display: inline-block; vertical-align: top; font-size: 25px; color: Yellowgreen;" class="title">요리방법1</p>
				<div id="Text1">
					<textarea name="recipeContent" id="1" class="form-control recipeContent" placeholder="예) 제육볶음" style="height: 160px;
					width: 430px; resize: none; float:left;" name="recipeContent"></textarea>&nbsp;
					<img src="https://recipe1.ezmember.co.kr/img/pic_none2.gif" class="imgs" style="width: 200px; height: 150px;">
					<input type="file" name="recipeImage" id="file1" class="imgFile" onchange="fileSelect(event)" style="display: none;"/><br/><br/>
				</div>
			</div>
		</div>
	</div>
	<button id="rBtn" type="button" style="margin-left:20%;">순서 추가</button>&nbsp;&nbsp;
	<br/><br/>	
	<div style="text-align:center">
		<button type="submit" class="btn btn-success" id="submit">등  록</button>&nbsp;&nbsp;
		<a id="goRecipeAllView" href="recipeAllView" class="btn btn-info">목록보기</a>
		<a id="goRecipeAllViewTwo" href="recipeAllViewTwo" class="btn btn-info" style="display: none;">목록보기</a>
	</div>
</form>
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
			  "<button type='button' class='btn btn-black delete' style='float:right;'>삭제</button>"
			+ "<p style='display:inline-block; vertical-align:top; font-size:25px; color:Yellowgreen;' class='title'>요리방법"+steps+"</p>&nbsp;"
			+ "<div id='Text"+steps+"'>"
			+ "<textarea name='recipeContent' id='"+steps+"' class='form-control recipeContent' placeholder='예) 제육볶음' style='height: 160px; width: 430px; resize: none; float:left;'></textarea>&nbsp;&nbsp;"
			+ "<img src='https://recipe1.ezmember.co.kr/img/pic_none2.gif' class='imgs' style='width: 200px; height: 150px;'>"
			+ "<input type='file' name='recipeImage' id='file"+steps+"' class='imgFile' onchange='fileSelect(event)' style='display: none;'/><br/><br/>"
			+ "</div>";
		$("#recycle").append(newDiv);
	});
	$(document).on("click", "img.imgs", function(event) {
		let imgFiles = $(event.target).next();
		imgFiles.trigger("click");
	});
	
	$("#submit").on("click", function() {
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
	
	$("#recipeWrite").submit(function(event) {
		let form = new FormData($('#recipeWrite')[0]);
		event.preventDefault();
		$.ajax({
			url : $("#recipeWrite").attr("action"),
			type : $("#recipeWrite").attr("method"),
			data : form,
			processData : false,
			contentType : false,
			success : function(data) {
				if(data.search("write-success") > -1) {
					alert("레시피를 작성했습니다.");
					$("#goRecipeAllView").trigger("click");
				} else {
					alert("레시피를 작성하지 못했습니다.");
				}
			},
			error : function() {
				alert("에러입니다.");
			}
		});
	});
	
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