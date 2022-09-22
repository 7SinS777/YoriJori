package com.yorijori.project.dto;

import java.security.Timestamp;

public class YJRecipeDto {
	private int no;
	private String id;
	private String title;
	private String recipeIntro;
	private String writeTime;
	private int hits;
	private int comments;
	private int likes;
	private String topImage;
	private String recipeType;
	private String recipeStyle;
	private String recipePeople;
	private String recipeTime;
	
	public YJRecipeDto() {
		super();
	}
	
	public YJRecipeDto(int no, String id, String title, String recipeIntro, String writeTime, int hits, int comments,
			int likes, String topImage, String recipeType, String recipeStyle, String recipePeople, String recipeTime) {
		super();
		this.no = no;
		this.id = id;
		this.title = title;
		this.recipeIntro = recipeIntro;
		this.writeTime = writeTime;
		this.hits = hits;
		this.comments = comments;
		this.likes = likes;
		this.topImage = topImage;
		this.recipeType = recipeType;
		this.recipeStyle = recipeStyle;
		this.recipePeople = recipePeople;
		this.recipeTime = recipeTime;
	}

	public YJRecipeDto(int no, String title, String recipeIntro, String topImage, String recipeType,
			String recipeStyle, String recipePeople, String recipeTime) {
		super();
		this.no = no;
		this.title = title;
		this.recipeIntro = recipeIntro;
		this.topImage = topImage;
		this.recipeType = recipeType;
		this.recipeStyle = recipeStyle;
		this.recipePeople = recipePeople;
		this.recipeTime = recipeTime;
	}
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getRecipeIntro() {
		return recipeIntro;
	}
	public void setRecipeIntro(String recipeIntro) {
		this.recipeIntro = recipeIntro;
	}
	public String getWriteTime() {
		return writeTime;
	}
	public void setWriteTime(String writeTime) {
		this.writeTime = writeTime;
	}
	public int getHits() {
		return hits;
	}
	public void setHits(int hits) {
		this.hits = hits;
	}
	public int getComments() {
		return comments;
	}
	public void setComments(int comments) {
		this.comments = comments;
	}
	public int getLikes() {
		return likes;
	}
	public void setLikes(int likes) {
		this.likes = likes;
	}
	public String getTopImage() {
		return topImage;
	}
	public void setTopImage(String topImage) {
		this.topImage = topImage;
	}
	public String getRecipeType() {
		return recipeType;
	}
	public void setRecipeType(String recipeType) {
		this.recipeType = recipeType;
	}
	public String getRecipeStyle() {
		return recipeStyle;
	}
	public void setRecipeStyle(String recipeStyle) {
		this.recipeStyle = recipeStyle;
	}
	public String getRecipePeople() {
		return recipePeople;
	}
	public void setRecipePeople(String recipePeople) {
		this.recipePeople = recipePeople;
	}
	public String getRecipeTime() {
		return recipeTime;
	}
	public void setRecipeTime(String recipeTime) {
		this.recipeTime = recipeTime;
	}
}
