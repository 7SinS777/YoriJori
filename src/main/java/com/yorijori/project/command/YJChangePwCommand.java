package com.yorijori.project.command;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.yorijori.project.constant.YJConstant;
import com.yorijori.project.dao.YJDao;
import com.yorijori.project.dto.YJDto;

public class YJChangePwCommand implements YorijoriCommand {

	@Override
	public void execute(HttpServletRequest request, Model model) {
		System.out.println("YJChangePwCommand");
		String idF = request.getParameter("idF");
		String phoneF = request.getParameter("phoneF");
		
		YJDao ydao = YJConstant.ydao;
		
		System.out.println(idF + ", " + phoneF);
		YJDto dto = new YJDto(null, idF, null, null, phoneF, null, null);
		
		String result = ydao.changePw(dto);
		System.out.println(result);
		request.setAttribute("result", result);
	}

}
