package com.yorijori.project.command;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.yorijori.project.constant.YJConstant;
import com.yorijori.project.dao.YJDao;
import com.yorijori.project.dto.YJDto;

public class YJFindIdCommand implements YorijoriCommand {

	@Override
	public void execute(HttpServletRequest request, Model model) {
		String phoneF = request.getParameter("phoneF");
		
		YJDao ydao = YJConstant.ydao;
		
		String findId = ydao.findId(phoneF);
		
		request.setAttribute("findId", findId);
	}

}
