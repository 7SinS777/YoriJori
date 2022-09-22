package com.yorijori.project.dto;

public class YJRecipeCommentsDto {
	private String id;
	private String commentary;
	private String commentTime;
	private int relation;
	private int commentOrder;
	private int commentGroup;
	private int commentNo;
	
	public YJRecipeCommentsDto() {
		super();
	}

	public YJRecipeCommentsDto(String id, String commentary, String commentTime, int relation, int commentOrder,
			int commentGroup, int commentNo) {
		super();
		this.id = id;
		this.commentary = commentary;
		this.commentTime = commentTime;
		this.relation = relation;
		this.commentOrder = commentOrder;
		this.commentGroup = commentGroup;
		this.commentNo = commentNo;
	}

	public YJRecipeCommentsDto(int commentNo, String commentary) {
		this.commentNo = commentNo;
		this.commentary = commentary;
	}

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getCommentary() {
		return commentary;
	}
	public void setCommentary(String commentary) {
		this.commentary = commentary;
	}
	public String getCommentTime() {
		return commentTime;
	}
	public void setCommentTime(String commentTime) {
		this.commentTime = commentTime;
	}
	public int getRelation() {
		return relation;
	}
	public void setRelation(int relation) {
		this.relation = relation;
	}
	public int getCommentOrder() {
		return commentOrder;
	}
	public void setCommentOrder(int commentOrder) {
		this.commentOrder = commentOrder;
	}
	public int getCommentGroup() {
		return commentGroup;
	}

	public void setCommentGroup(int commentGroup) {
		this.commentGroup = commentGroup;
	}
	public int getCommentNo() {
		return commentNo;
	}
	public void setCommentNo(int commentNo) {
		this.commentNo = commentNo;
	}
}
