package com.yorijori.project.dto;

public class YJRecipeWriteDto {
	private String recipeContent;
	private String recipeImage;
	private int recipeNo;
	private int recipeGroup;
	public YJRecipeWriteDto() {
		super();
	}
	
	public YJRecipeWriteDto(String recipeContent, String recipeImage, int recipeNo, int recipeGroup) {
		super();
		this.recipeContent = recipeContent;
		this.recipeImage = recipeImage;
		this.recipeNo = recipeNo;
		this.recipeGroup = recipeGroup;
	}
	
	public String getRecipeContent() {
		return recipeContent;
	}
	public void setRecipeContent(String recipeContent) {
		this.recipeContent = recipeContent;
	}
	public String getRecipeImage() {
		return recipeImage;
	}
	public void setRecipeImage(String recipeImage) {
		this.recipeImage = recipeImage;
	}
	public int getRecipeNo() {
		return recipeNo;
	}
	public void setRecipeNo(int recipeNo) {
		this.recipeNo = recipeNo;
	}
	public int getRecipeGroup() {
		return recipeGroup;
	}
	public void setRecipeGroup(int recipeGroup) {
		this.recipeGroup = recipeGroup;
	}
	
}