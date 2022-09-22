package com.yorijori.project.command;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.yorijori.project.constant.YJConstant;
import com.yorijori.project.dao.YJDao;
import com.yorijori.project.dto.YJDto;

public class YJInforModifyCommand implements YorijoriCommand {

	@Override
	public void execute(HttpServletRequest request, Model model) {
		YJDao ydao = YJConstant.ydao;
		
		YJDto dto = (YJDto)request.getAttribute("dto");
		
		String hidden = (String)request.getAttribute("hidden");
		String result = null;
		if(hidden.equals("noChange")) {
			result = ydao.inforModify2(dto);
		} else {
			result = ydao.inforModify1(dto);
		}
		
		request.setAttribute("result", result);
	}

}
