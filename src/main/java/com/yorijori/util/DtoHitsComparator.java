package com.yorijori.util;

import java.util.Comparator;

import com.yorijori.project.dto.YJRecipeDto;

public class DtoHitsComparator implements Comparator<YJRecipeDto> {
	@Override
	public int compare(YJRecipeDto dto1, YJRecipeDto dto2) {
		if(dto1.getHits() > dto2.getHits()) {
			return 1;
		} else if(dto1.getHits() < dto2.getHits()) {
			return -1;
		}
		return 0;
	}
}
