package com.yorijori.project.command;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

public interface YorijoriCommand {
	// 추상메서드
	public void execute(HttpServletRequest request, Model model);
}
