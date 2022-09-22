package com.yorijori.project.command;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.yorijori.project.constant.YJConstant;
import com.yorijori.project.dao.YJDao;

public class YJIdCheckCommand implements YorijoriCommand {

	@Override
	public void execute(HttpServletRequest request, Model model) {
		String id = request.getParameter("id");
		
		YJDao ydao = YJConstant.ydao;
		
		String result = ydao.idCheck(id);
		
		request.setAttribute("result", result);
	}

}
