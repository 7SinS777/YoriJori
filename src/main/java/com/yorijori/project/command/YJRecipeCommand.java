package com.yorijori.project.command;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.yorijori.project.constant.YJConstant;
import com.yorijori.project.dao.YJDao;
import com.yorijori.project.dto.YJRecipeDto;
import com.yorijori.project.dto.YJRecipeWriteDto;

public class YJRecipeCommand implements YorijoriCommand {

	@Override
	public void execute(HttpServletRequest request, Model model) {
		YJDao ydao = YJConstant.ydao;
		YJRecipeDto dto = (YJRecipeDto)request.getAttribute("rdto");
		String result = ydao.recipe(dto);
		model.addAttribute("result",result);
		int no = ydao.recipeNo(dto);
		model.addAttribute("no",no);
	}

}
