package com.yorijori.project.command;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.yorijori.project.constant.YJConstant;
import com.yorijori.project.dao.YJDao;

public class YJCommentModifyCommand implements YorijoriCommand {

	@Override
	public void execute(HttpServletRequest request, Model model) {
		YJDao ydao = YJConstant.ydao;
		
		int commentNo = Integer.parseInt(request.getParameter("commentNo"));
		String commentary = request.getParameter("commentary");
		String type = request.getParameter("type");
		String result = null;
		if(type.equals("delete")) {
			result = ydao.commentDelete(commentNo);
		} else {
			result = ydao.commentModify(commentNo, commentary);
		}
		
		request.setAttribute("result", result);
	}

}
