package com.yorijori.project.command;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.yorijori.project.constant.YJConstant;
import com.yorijori.project.dao.YJDao;
import com.yorijori.project.dto.YJRecipeDto;

public class YJRecipeModifyCommand implements YorijoriCommand {

	@Override
	public void execute(HttpServletRequest request, Model model) {
		YJDao ydao = YJConstant.ydao;
		YJRecipeDto dto = (YJRecipeDto)request.getAttribute("rdto");
		String result = ydao.recipeModify(dto);
		model.addAttribute("result", result);
	}
}
