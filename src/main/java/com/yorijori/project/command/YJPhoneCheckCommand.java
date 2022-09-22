package com.yorijori.project.command;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.yorijori.project.constant.YJConstant;
import com.yorijori.project.dao.YJDao;

public class YJPhoneCheckCommand implements YorijoriCommand {

	@Override
	public void execute(HttpServletRequest request, Model model) {
		String phone = request.getParameter("phone");
		
		YJDao ydao = YJConstant.ydao;
		
		String result = ydao.phoneCheck(phone);
		
		request.setAttribute("result", result);
	}

}
