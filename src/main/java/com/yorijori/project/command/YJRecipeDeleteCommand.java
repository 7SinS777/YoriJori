package com.yorijori.project.command;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.yorijori.project.constant.YJConstant;
import com.yorijori.project.dao.YJDao;

public class YJRecipeDeleteCommand implements YorijoriCommand {

	@Override
	public void execute(HttpServletRequest request, Model model) {
		YJDao ydao = YJConstant.ydao;
		
		int no = Integer.parseInt(request.getParameter("no"));
		
		String result = ydao.deleteRecipe(no);
		
		request.setAttribute("result", result);
	}

}
