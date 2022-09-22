package com.yorijori.project.dao;

import java.util.ArrayList;

import com.yorijori.project.dto.YJDto;
import com.yorijori.project.dto.YJRecipeCommentsDto;
import com.yorijori.project.dto.YJRecipeDto;
import com.yorijori.project.dto.YJRecipeWriteDto;

public interface IYJDao {
	String join(YJDto dto);
	String idCheck(String id);
	String phoneCheck(String phone);
	YJDto login(String username);
	YJDto mypage(String userId);
	String findId(String phoneF);
	String changePw(YJDto dto);
	YJDto checkPwGo(YJDto dto);
	String changePwGo(YJDto ydto);
	ArrayList<YJRecipeDto> pageList(String pageNo); 
	ArrayList<YJRecipeDto> recipeAllViewTimes();
	ArrayList<YJRecipeDto> recipeAllViewHits();
	YJRecipeDto recipeContentView(int no);
	String memberOutCheck(String id, String phoneC);
	void memberOut(String id);
	String recipe(YJRecipeDto dto);
	int recipeNo(YJRecipeDto dto);
	void recipeWrite(YJRecipeWriteDto rwdto);
	ArrayList<YJRecipeWriteDto> recipeWriteContent(int no);
	void upHit(int no);
	YJRecipeDto recipeSelectContent(int no);
	String recipeModify(YJRecipeDto dto);
	void recipeWriteModify(YJRecipeWriteDto rwdto);
	void deleteWrite(int recipeGroup);
	String writeComment(YJRecipeCommentsDto dto);
	ArrayList<YJRecipeCommentsDto> recipeComments(int no);
	String commentDelete(int commentNo);
	String commentModify(int commentNo, String commentary);
	String inforModify1(YJDto dto);
	String inforModify2(YJDto dto);
	ArrayList<YJRecipeDto> recipeSearch(String chose, String search, String searchWhat);
	String deleteRecipe(int no);
	ArrayList<YJRecipeDto> recipeCondition(String[] recipeTypes, String[] recipeStyles, String[] recipePeoples,	String[] recipeTimes, String chose);
}
