package com.yorijori.project.command;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.yorijori.project.constant.YJConstant;
import com.yorijori.project.dao.YJDao;
import com.yorijori.project.dto.YJRecipeDto;

public class YJPageListCommand implements YorijoriCommand {

	@Override
	public void execute(HttpServletRequest request, Model model) {

		YJDao ydao = YJConstant.ydao;
		String pageNo = request.getParameter("pageNo");
		ArrayList<YJRecipeDto> recipe = ydao.pageList(pageNo);
		
		model.addAttribute("recipeList",recipe);
		
	}

}
