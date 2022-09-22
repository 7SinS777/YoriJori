package com.yorijori.project.command;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.yorijori.project.constant.YJConstant;
import com.yorijori.project.dao.YJDao;
import com.yorijori.project.dto.YJRecipeWriteDto;

public class YJRecipeWriteModifyCommand implements YorijoriCommand {

	@Override
	public void execute(HttpServletRequest request, Model model) {
		YJDao ydao = YJConstant.ydao;
		int recipeGroup = Integer.parseInt(request.getParameter("no"));
		ArrayList<YJRecipeWriteDto> rwdtos = (ArrayList)request.getAttribute("rwdtos");
		ydao.deleteWrite(recipeGroup);
		int i;
		for(i=0; i<rwdtos.size(); i++) {
			YJRecipeWriteDto rwdto = rwdtos.get(i);
			ydao.recipeWriteModify(rwdto);
		}
		model.addAttribute("rwResult", "success");
	}

}
