package com.yorijori.project.command;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.yorijori.project.constant.YJConstant;
import com.yorijori.project.dao.YJDao;
import com.yorijori.project.dto.YJRecipeDto;

public class YJRecipeAllViewCommand implements YorijoriCommand {

	@Override
	public void execute(HttpServletRequest request, Model model) {
		YJDao ydao = YJConstant.ydao;
		
		String chose = request.getParameter("chose");
		String viewType = request.getParameter("viewType");
		String search = request.getParameter("search");
		String searchWhat = request.getParameter("searchWhat");
		System.out.println(chose+", "+search+", "+searchWhat+", "+viewType);
		ArrayList<YJRecipeDto> dto = new ArrayList<YJRecipeDto>();
		String[] recipeTypes = request.getParameterValues("recipeType[]");
		String[] recipeStyles = request.getParameterValues("recipeStyle[]");
		String[] recipePeoples = request.getParameterValues("recipePeople[]");
		String[] recipeTimes = request.getParameterValues("recipeTime[]");
		if(viewType.equals("condition")) {
			
			dto = ydao.recipeCondition(recipeTypes, recipeStyles, recipePeoples, recipeTimes, chose);
			
		} else {
			if(search == null || search == "") {
				if(chose.equals("times")) {
					dto = ydao.recipeAllViewTimes();
				} else if(chose.equals("hits")) {
					dto = ydao.recipeAllViewHits();
				}
			} else {
				dto = ydao.recipeSearch(chose, search, searchWhat);
			}
		}
		request.setAttribute("recipeList", dto);
		request.setAttribute("viewType", viewType);
		request.setAttribute("search", search);
		request.setAttribute("searchWhat", searchWhat);
		request.setAttribute("recipeTypes", recipeTypes);
		request.setAttribute("recipeStyles", recipeStyles);
		request.setAttribute("recipePeoples", recipePeoples);
		request.setAttribute("recipeTimes", recipeTimes);
	}

}
