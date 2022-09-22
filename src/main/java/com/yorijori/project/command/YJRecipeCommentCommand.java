package com.yorijori.project.command;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.yorijori.project.constant.YJConstant;
import com.yorijori.project.dao.YJDao;
import com.yorijori.project.dto.YJRecipeCommentsDto;

public class YJRecipeCommentCommand implements YorijoriCommand {

	@Override
	public void execute(HttpServletRequest request, Model model) {
		YJDao ydao = YJConstant.ydao;
		
		String id = request.getParameter("id");
		String comments = request.getParameter("commentary");
		Date date = new Date();
		SimpleDateFormat nt = new SimpleDateFormat("yyyy/MM/dd hh:mm:ss");
		String commentTime = nt.format(date);
		int commentGroup = Integer.parseInt(request.getParameter("recipeNo"));
		
		YJRecipeCommentsDto dto = new YJRecipeCommentsDto(id, comments, commentTime, 0, 0, commentGroup, 0);
		
		String result = ydao.writeComment(dto);
		
		request.setAttribute("result", result);
	}
}
