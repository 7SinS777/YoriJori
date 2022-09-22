/**
 * 
 */
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
			url : $("#recipeAllView").attr("href"),
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