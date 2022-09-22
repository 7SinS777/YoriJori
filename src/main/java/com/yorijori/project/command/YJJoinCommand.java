package com.yorijori.project.command;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.ui.Model;

import com.yorijori.project.constant.YJConstant;
import com.yorijori.project.dao.YJDao;
import com.yorijori.project.dto.YJDto;

public class YJJoinCommand implements YorijoriCommand {

	@Override
	public void execute(HttpServletRequest request, Model model) {
		BCryptPasswordEncoder passwordEncoder = YJConstant.passwordEncoder;
		
		String name = request.getParameter("name");
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String gender = request.getParameter("gender");
		
		String pw_org = pw;
		pw = passwordEncoder.encode(pw_org);
		
		YJDto dto = new YJDto(name, id, pw, email, phone, gender, null);
		
		YJDao ydao = YJConstant.ydao;
		
		String result = ydao.join(dto);
		
		request.setAttribute("result", result);
	}

}
