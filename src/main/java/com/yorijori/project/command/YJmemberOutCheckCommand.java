package com.yorijori.project.command;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.yorijori.project.constant.YJConstant;
import com.yorijori.project.dao.YJDao;

public class YJmemberOutCheckCommand implements YorijoriCommand {

	@Override
	public void execute(HttpServletRequest request, Model model) {
		YJDao ydao = YJConstant.ydao;
		
		String id = request.getParameter("id");
		String phoneC = request.getParameter("phoneC");
		String result = ydao.memberOutCheck(id, phoneC);
		
		request.setAttribute("result", result);
	}

}
