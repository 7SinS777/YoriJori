package com.yorijori.project.command;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.yorijori.project.constant.YJConstant;
import com.yorijori.project.dao.YJDao;
import com.yorijori.project.dto.YJRecipeDto;
import com.yorijori.project.dto.YJRecipeWriteDto;

public class YJRecipeModifyViewCommand implements YorijoriCommand {

	@Override
	public void execute(HttpServletRequest request, Model model) {
		YJDao ydao = YJConstant.ydao;
		
		int no = Integer.parseInt(request.getParameter("no"));
		
		YJRecipeDto dto = ydao.recipeSelectContent(no);
		
		request.setAttribute("recipeContent", dto);
		
		ArrayList<YJRecipeWriteDto> rwdtos = ydao.recipeWriteContent(no);
		
		request.setAttribute("recipeWriteContent", rwdtos);
	}

}
