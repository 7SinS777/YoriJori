package com.yorijori.project.command;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.yorijori.project.constant.YJConstant;
import com.yorijori.project.dao.YJDao;
import com.yorijori.project.dto.YJRecipeWriteDto;

public class YJRecipeWriteCommand implements YorijoriCommand {

	@Override
	public void execute(HttpServletRequest request, Model model) {
		YJDao ydao = YJConstant.ydao;
		ArrayList<YJRecipeWriteDto> rwdtos = (ArrayList)request.getAttribute("rwdtos");
		int i;
		for(i=0; i<rwdtos.size(); i++) {
			YJRecipeWriteDto rwdto = rwdtos.get(i);
			ydao.recipeWrite(rwdto);
		}
		model.addAttribute("rwResult", "success");
	}

}
