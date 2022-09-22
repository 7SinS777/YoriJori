package com.yorijori.project.command;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.yorijori.project.constant.YJConstant;
import com.yorijori.project.dao.YJDao;
import com.yorijori.project.dto.YJRecipeCommentsDto;
import com.yorijori.project.dto.YJRecipeDto;
import com.yorijori.project.dto.YJRecipeWriteDto;

public class YJRecipeContentViewCommand implements YorijoriCommand {

	@Override
	public void execute(HttpServletRequest request, Model model) {
		YJDao ydao = YJConstant.ydao;
		
		String no1 = request.getParameter("no");
		int no = Integer.parseInt(no1);
		
		YJRecipeDto dto = ydao.recipeContentView(no);
		
		request.setAttribute("recipeContent", dto);
		
		ArrayList<YJRecipeWriteDto> rwdto = ydao.recipeWriteContent(no);
		
		request.setAttribute("recipeWriteContent", rwdto);
		
		ArrayList<YJRecipeCommentsDto> cdto = ydao.recipeComments(no);
		
		request.setAttribute("recipeComments", cdto);
		
		
	}

}
