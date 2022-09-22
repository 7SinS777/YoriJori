package com.yorijori.util;

import java.util.Comparator;

import com.yorijori.project.dto.YJRecipeDto;

public class DtoNoComparator implements Comparator<YJRecipeDto> {

	@Override
	public int compare(YJRecipeDto dto1, YJRecipeDto dto2) {
		if(dto1.getNo() > dto2.getNo()) {
			return 1;
		} else if(dto1.getNo() < dto2.getNo()) {
			return -1;
		}
		return 0;
	}
}
