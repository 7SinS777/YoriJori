package com.yorijori.project.command;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.ui.Model;

import com.yorijori.project.constant.YJConstant;
import com.yorijori.project.dao.YJDao;
import com.yorijori.project.dto.YJDto;

public class YJChangePwGoCommand implements YorijoriCommand {

	@Override
	public void execute(HttpServletRequest request, Model model) {
		BCryptPasswordEncoder passwordEncoder = YJConstant.passwordEncoder;
		
		String idF = request.getParameter("idF");
		String phoneF = request.getParameter("phoneF");
		String newPw = request.getParameter("newPw");
		String newPw_org = newPw;
		newPw = passwordEncoder.encode(newPw_org);
		
		YJDao ydao = YJConstant.ydao;
		
		YJDto dto = new YJDto(null, idF, newPw, null, phoneF, null, null);
		
		YJDto ydto = ydao.checkPwGo(dto);
		
		String result = ydao.changePwGo(ydto);
		System.out.println(result);
		request.setAttribute("result", result);
	}
}
