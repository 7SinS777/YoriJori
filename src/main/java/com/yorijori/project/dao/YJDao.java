package com.yorijori.project.dao;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.yorijori.project.dto.YJDto;
import com.yorijori.project.dto.YJRecipeCommentsDto;
import com.yorijori.project.dto.YJRecipeDto;
import com.yorijori.project.dto.YJRecipeWriteDto;
import com.yorijori.util.DtoHitsComparator;
import com.yorijori.util.DtoNoComparator;

public class YJDao implements IYJDao {
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public String join(YJDto dto) {
		String result = null;
		System.out.println(dto.getName() + ", " + dto.getId() + ", " + dto.getPw() + ", " + dto.getEmail() + ", " + dto.getPhone() + ", " + dto.getGender());
		try {
			System.out.println(dto.toString());
			int res = sqlSession.insert("join", dto);
			System.out.println(res);
			if(res > 0) {
				result = "success";
			} else {
				result = "failed";
			}
		} catch (Exception e) {
			e.printStackTrace();
			result = "failed";
		}
		return result;
	}
	@Override
	public String idCheck(String id) {
		String result = null;
		try {
			YJDto dto = sqlSession.selectOne("idCheck", id);
			if(dto == null) {
				result = "failed";
			} else {
				result = "success";
			}
		} catch (Exception e) {
			e.printStackTrace();
			result = "failed";
		}
		return result;
	}
	@Override
	public String phoneCheck(String phone) {
		String result = null;
		try {
			YJDto dto = sqlSession.selectOne("phoneCheck", phone);
			if(dto == null) {
				result = "failed";
			} else {
				result = "success";
			}
		} catch (Exception e) {
			e.printStackTrace();
			result = "failed";
		}
		return result;
	}
	@Override
	public YJDto login(String username) {
		YJDto result = sqlSession.selectOne("login", username);
		
		return result;
	}
	@Override
	public YJDto mypage(String userId) {
		YJDto dto = null;
		try {
			dto = sqlSession.selectOne("mypage", userId);
			if(dto == null) {
				return null;
			} else {
				return dto;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	@Override
	public String findId(String phoneF) {
		try {
			String findId = sqlSession.selectOne("findId", phoneF);
			if(findId == null) {
				System.out.println("findId is null");
				return "";
			} else {
				System.out.println(findId);
				return findId;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "";
		}
	}
	@Override
	public String changePw(YJDto dto) {
		System.out.println(dto.getId());
		System.out.println(dto.getPhone());
		try {
			String phone = sqlSession.selectOne("changePw", dto);
			System.out.println(phone);
			if(phone == null) {
				return "failed";
			}
			if(phone.equals(dto.getPhone())) {
				System.out.println("정보 일치");
				return "success";
			} else {
				System.out.println("정보 불일치");
				return "failed";
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "failed";
		}
	}
	@Override
	public YJDto checkPwGo(YJDto dto) {
		try {
			YJDto ydto = sqlSession.selectOne("checkPwGo", dto);
			System.out.println(ydto.getPw() + ", " + dto.getPw());
			if(ydto.getPw().equals(dto.getPw())) {
				return null;
			} else {
				return dto;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	@Override
	public String changePwGo(YJDto ydto) {
		int result = 0;
		try {
			result = sqlSession.update("changePwGo", ydto);
			if(result > 0) {
				return "success";
			} else {
				return "failed";
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("오류");
			return "failed";
		}
	}
	
	@Override
	public ArrayList<YJRecipeDto> pageList(String pageNo) {
		System.out.println("pageList");
		int page = Integer.parseInt(pageNo);
		int startNo = (page-1) * 10 + 1;
		System.out.println("startNo : " + startNo);
		ArrayList<YJRecipeDto> result = (ArrayList)sqlSession.selectList("pageList",startNo);
		System.out.println(result);
		return result;
	}
	
	@Override
	public ArrayList<YJRecipeDto> recipeAllViewTimes() {
		ArrayList<YJRecipeDto> dto = (ArrayList)sqlSession.selectList("recipeAllViewTimes");
		return dto;
	}
	public ArrayList<YJRecipeDto> recipeAllViewHits() {
		ArrayList<YJRecipeDto> dto = (ArrayList)sqlSession.selectList("recipeAllViewHits");
		return dto;
	}
	@Override
	public YJRecipeDto recipeContentView(int no) {
		upHit(no);
		YJRecipeDto dto = sqlSession.selectOne("recipeContentView", no);
		return dto;
	}
	@Override
	public void upHit(int no) {
		sqlSession.update("upHit", no);
	}
	@Override
	public ArrayList<YJRecipeWriteDto> recipeWriteContent(int no) {
		ArrayList<YJRecipeWriteDto> dto = (ArrayList)sqlSession.selectList("recipeWriteContent", no);
		return dto;
	}
	@Override
	public String memberOutCheck(String id, String phoneC) {
		YJDto dto = sqlSession.selectOne("memberOutCheck", id);
		if(dto == null) {
			return "not-equals";
		} else {
			String phone = dto.getPhone();
			if(phoneC.equals(phone)) {
				return "equals";
			} else {
				return "not-equals";
			}
		}
	}
	@Override
	public void memberOut(String id) {
		sqlSession.delete("memberOut", id);
	}
	/* recipe에서 recipe등록 */
	@Override
	public String recipe(YJRecipeDto dto) {
		String result;
		int res = sqlSession.insert("recipe", dto);
		if(res > 0) {
			result = "success";
		}
		else {
			result = "failed";
		}
		return result;
	}
	@Override
	public int recipeNo(YJRecipeDto dto) {
		return sqlSession.selectOne("recipeNo", dto);
	}
	@Override
	public void recipeWrite(YJRecipeWriteDto rwdto) {
		sqlSession.insert("recipeWrite", rwdto);
	}
	@Override
	public YJRecipeDto recipeSelectContent(int no) {
		YJRecipeDto dto = sqlSession.selectOne("recipeSelectContent", no);
		return dto;
	}
	@Override
	public String recipeModify(YJRecipeDto dto) {
		String result;
		int res = sqlSession.update("recipeModify", dto);
		if(res > 0) {
			result = "success";
		}
		else {
			result = "failed";
		}
		return result;
	}
	@Override
	public void recipeWriteModify(YJRecipeWriteDto rwdto) {
		sqlSession.insert("recipeWrite", rwdto);
	}
	@Override
	public void deleteWrite(int recipeGroup) {
		sqlSession.delete("deleteWrite", recipeGroup);
	}
	@Override
	public String writeComment(YJRecipeCommentsDto dto) {
		String result;
		int res = sqlSession.insert("writeComment", dto);
		if(res > 0) {
			result = "success";
		}
		else {
			result = "failed";
		}
		return result;
	}
	@Override
	public ArrayList<YJRecipeCommentsDto> recipeComments(int no) {
		ArrayList<YJRecipeCommentsDto> dto = (ArrayList)sqlSession.selectList("recipeComments", no);
		return dto;
	}
	@Override
	public String commentDelete(int commentNo) {
		String result;
		int res = sqlSession.delete("commentDelete", commentNo);
		if(res > 0) {
			result = "delete-success";
		}
		else {
			result = "delete-failed";
		}
		return result;
	}
	@Override
	public String commentModify(int commentNo, String commentary) {
		String result;
		YJRecipeCommentsDto dto = new YJRecipeCommentsDto(commentNo, commentary);
		int res = sqlSession.update("commentModify", dto);
		if(res > 0) {
			result = "modify-success";
		}
		else {
			result = "modify-failed";
		}
		return result;
	}
	@Override
	public String inforModify1(YJDto dto) {
		String result;
		int res = sqlSession.update("inforModify1", dto);
		if(res > 0) {
			result = "inforModify-success";
		}
		else {
			result = "inforModify-failed";
		}
		return result;
	}
	@Override
	public String inforModify2(YJDto dto) {
		String result;
		int res = sqlSession.update("inforModify2", dto);
		if(res > 0) {
			result = "inforModify-success";
		}
		else {
			result = "inforModify-failed";
		}
		return result;
	}
	@Override
	public ArrayList<YJRecipeDto> recipeSearch(String chose, String search, String searchWhat) {
		ArrayList<YJRecipeDto> dto = new ArrayList<YJRecipeDto>();
		if(searchWhat.equals("sTitle")) {
			if(chose.equals("times")) {
				dto = (ArrayList)sqlSession.selectList("searchTitleT", search);
			} else {
				dto = (ArrayList)sqlSession.selectList("searchTitleH", search);
			}
		} else if(searchWhat.equals("sTitleAndContent")) {
			List<Integer> noC = sqlSession.selectList("sContent", search);
			List<Integer> noT = sqlSession.selectList("sTitle", search);
			noT.addAll(noC);
			Set<Integer> set = new HashSet<Integer>(noT);
			List<Integer> nos = new ArrayList<Integer>(set);
			nos.sort(Comparator.reverseOrder());
			for(int i=0; i<nos.size(); i++) {
				int no = nos.get(i);
				dto.add(sqlSession.selectOne("searchTitleAndContent", no));
			}
			if(chose.equals("times")) {
				Collections.sort(dto, new DtoNoComparator().reversed());
			} else {
				Collections.sort(dto, new DtoHitsComparator().reversed());
			}
		} else if(searchWhat.equals("sContent")) {
			List<Integer> noC = sqlSession.selectList("sContent", search);
			noC.sort(Comparator.reverseOrder());
			for(int i=0; i<noC.size(); i++) {
				int no = noC.get(i);
				dto.add(sqlSession.selectOne("searchContent", no));
			}
			if(chose.equals("times")) {
				Collections.sort(dto, new DtoNoComparator().reversed());
			} else {
				Collections.sort(dto, new DtoHitsComparator().reversed());
			}
		} else {
			if(searchWhat.equals("times")) {
				dto = (ArrayList)sqlSession.selectList("searchWriterT", search);
			} else {
				dto = (ArrayList)sqlSession.selectList("searchWriterH", search);
			}
		}
		return dto;
	}
	@Override
	public String deleteRecipe(int no) {
		String result;
		int res1 = sqlSession.delete("deleteRecipe", no);
		int res2 = sqlSession.delete("deleteRecipeWrite", no);
		if(res1 > 0 && res2 > 0) {
			result = "delete-success";
		}
		else {
			result = "delete-failed";
		}
		return result;
	}
	@Override
	public ArrayList<YJRecipeDto> recipeCondition(String[] recipeTypes, String[] recipeStyles, String[] recipePeoples,
			String[] recipeTimes, String chose) {
		List<Integer> types = new ArrayList<Integer>();
		List<Integer> styles = new ArrayList<Integer>();
		List<Integer> peoples = new ArrayList<Integer>();
		List<Integer> times = new ArrayList<Integer>();
		List<Integer> all = new ArrayList<Integer>();
		if(recipeTypes != null) {
			System.out.println("playTypes");
			for(int i=0; i<recipeTypes.length; i++) {
				String type = recipeTypes[i];
				List<Integer> list = sqlSession.selectList("recipeTypes", type);
				types.addAll(list);
				System.out.println(types.toString());
			}
			all.addAll(types);
		}
		System.out.println("all : "+all.toString());
		if(recipeStyles != null) {
			System.out.println("playStyles");
			for(int i=0; i<recipeStyles.length; i++) {
				String style = recipeStyles[i];
				List<Integer> list = sqlSession.selectList("recipeStyles", style);
				styles.addAll(list);
				System.out.println(styles.toString());
			}
			if(recipeTypes != null) {
				all.retainAll(styles);
			} else {
				all.addAll(styles);
			}
		}
		System.out.println("all : "+all.toString());
		if(recipePeoples != null) {
			System.out.println("playPeoples");
			for(int i=0; i<recipePeoples.length; i++) {
				String people = recipePeoples[i];
				List<Integer> list = sqlSession.selectList("recipePeoples", people);
				peoples.addAll(list);
				System.out.println(peoples.toString());
			}
			if(recipeTypes != null || recipeStyles != null) {
				all.retainAll(peoples);
			} else {
				all.addAll(peoples);
			}
		}
		System.out.println("all : "+all.toString());
		if(recipeTimes != null) {
			System.out.println("playTimes");
			for(int i=0; i<recipeTimes.length; i++) {
				String time = recipeTimes[i];
				List<Integer> list = sqlSession.selectList("recipeTimes", time);
				times.addAll(list);
				System.out.println(times.toString());
			}
			if(recipeTypes != null || recipeStyles != null || recipePeoples != null) {
				all.retainAll(times);
			} else {
				all.addAll(times);
			}
		}
		System.out.println("all : "+all.toString());
		Set<Integer> set = new HashSet<Integer>(all);
		List<Integer> allSearch = new ArrayList<Integer>(set);
		Collections.sort(allSearch, Collections.reverseOrder());
		ArrayList<YJRecipeDto> dto = new ArrayList<YJRecipeDto>();
		System.out.println(allSearch.toString());
		for(int i=0; i<allSearch.size(); i++) {
			int no = allSearch.get(i);
			dto.add(sqlSession.selectOne("allSearch", no));
			System.out.println(dto.get(i).getNo());
		}
		if(chose.equals("times")) {
			Collections.sort(dto, new DtoNoComparator().reversed());
		} else {
			Collections.sort(dto, new DtoHitsComparator().reversed());
		}
		return dto;
	}
}
