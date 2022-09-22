package com.yorijori.project.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.yorijori.project.command.YJChangePwCommand;
import com.yorijori.project.command.YJChangePwGoCommand;
import com.yorijori.project.command.YJCommentModifyCommand;
import com.yorijori.project.command.YJFindIdCommand;
import com.yorijori.project.command.YJIdCheckCommand;
import com.yorijori.project.command.YJInforModifyCommand;
import com.yorijori.project.command.YJJoinCommand;
import com.yorijori.project.command.YJMemberOutCommand;
import com.yorijori.project.command.YJMypageCommand;
import com.yorijori.project.command.YJPageListCommand;
import com.yorijori.project.command.YJPhoneCheckCommand;
import com.yorijori.project.command.YJRecipeAllViewCommand;
import com.yorijori.project.command.YJRecipeCommand;
import com.yorijori.project.command.YJRecipeCommentCommand;
import com.yorijori.project.command.YJRecipeContentViewCommand;
import com.yorijori.project.command.YJRecipeDeleteCommand;
import com.yorijori.project.command.YJRecipeModifyCommand;
import com.yorijori.project.command.YJRecipeModifyViewCommand;
import com.yorijori.project.command.YJRecipeWriteCommand;
import com.yorijori.project.command.YJRecipeWriteModifyCommand;
import com.yorijori.project.command.YJmemberOutCheckCommand;
import com.yorijori.project.command.YorijoriCommand;
import com.yorijori.project.constant.YJConstant;
import com.yorijori.project.dao.YJDao;
import com.yorijori.project.dto.YJDto;
import com.yorijori.project.dto.YJRecipeDto;
import com.yorijori.project.dto.YJRecipeWriteDto;

@Controller
public class YJController {
	private YorijoriCommand com;
	private BCryptPasswordEncoder passwordEncoder;
	@Autowired
	public void setPasswordEncoder(BCryptPasswordEncoder passwordEncoder) {
		this.passwordEncoder = passwordEncoder;
		YJConstant.passwordEncoder = passwordEncoder;
	}
	private YJDao ydao;
	@Autowired
	public void setYdao(YJDao ydao) {
		this.ydao = ydao;
		YJConstant.ydao = ydao;
	}
	@RequestMapping("/loginView")
	public String loginView() {
		System.out.println("loginView");
		return "loginView";
	}
	@RequestMapping("/logoutView")
	public String logoutView() {
		System.out.println("logoutView");
		return "logoutView";
	}
	@RequestMapping("/exsample")
	public String exsample() {
		System.out.println("exsample");
		return "exsample";
	}
	@RequestMapping("/main")
	public String main(HttpServletRequest request, Model model, Authentication authentication) {
		System.out.println("main");
		getUsers(authentication, request);
		String username = (String)request.getAttribute("username");
		String password = (String)request.getAttribute("password");
		String auth = (String)request.getAttribute("auth");
		return "main";
	}
	private void getUsers(Authentication authentication, HttpServletRequest request) {
		UserDetails userDetails = (UserDetails)authentication.getPrincipal();
		String username = userDetails.getUsername();
		String password = userDetails.getPassword();
		System.out.println(userDetails.getUsername()); // 로그인한 아이디
		Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
		String auth = authorities.toString();
		System.out.println(auth);
		request.setAttribute("username", username);
		request.setAttribute("password", password);
		request.setAttribute("auth", auth);
	}
	@RequestMapping("/joinView")
	public String joinView() {
		System.out.println("joinView");
		return "joinView";
	}
	@RequestMapping(value="/join", produces="application/text; charset=UTF-8")
	@ResponseBody
	public String join(HttpServletRequest request, HttpServletResponse response, Model model) {
		System.out.println("join");
		com = new YJJoinCommand();
		com.execute(request, model);
		String result = (String)request.getAttribute("result");
		System.out.println(result);
		if(result.equals("success")) {
			return "join-success";
		} else {
			return "join-failed";
		}
	}
	@RequestMapping("/joinResultView")
	public String joinResult_view() {
		System.out.println("joinResult_view");
		return "joinResultView";
	}
	@RequestMapping(value="/idCheck", produces="application/text; charset=UTF-8")
	@ResponseBody
	public String idCheck(HttpServletRequest request, HttpServletResponse response, Model model) {
		System.out.println("idCheck");
		com = new YJIdCheckCommand();
		com.execute(request, model);
		String result = (String)request.getAttribute("result");
		if(result.equals("success")) {
			return "alreadyId";
		} else {
			return "noneId";
		}
	}
	@RequestMapping(value="/phoneCheck", produces="application/text; charset=UTF-8")
	@ResponseBody
	public String phoneCheck(HttpServletRequest request, HttpServletResponse response, Model model) {
		System.out.println("phoneCheck");
		com = new YJPhoneCheckCommand();
		com.execute(request, model);
		String result = (String)request.getAttribute("result");
		if(result.equals("success")) {
			return "alreadyPhone";
		} else {
			return "nonePhone";
		}
	}
	@RequestMapping("/processLogin")
	public ModelAndView processLogin(
			@RequestParam(value="log", required = false) String log,
			@RequestParam(value="error", required = false) String error,
			@RequestParam(value="logout", required = false) String logout,
			HttpSession session, Model pmodel) {
		System.out.println("processLogin");
		ModelAndView model = new ModelAndView();
		if(log != null && log != "") {
			model.addObject("log", "before login!");
		}
		if(error != null && error != "") { // 로그인 실패시 시큐리티에서 processLogin?error=1
			model.addObject("error", "Invalid username or password!");
		}
		if(logout != null && logout!= "") { // processLogin?logout=1
			model.addObject("logout", "You've been logged out successfully.");
		}
		model.setViewName("exsample");
		return model;
	}
	@RequestMapping("/mypageView")
	public String mypageView(HttpServletRequest request, Model model) {
		System.out.println("mypageView");
		com = new YJMypageCommand();
		com.execute(request, model);
		return "mypageView";
	}
	@RequestMapping("/findIdView")
	public String findIdView() {
		System.out.println("findIdView");
		return "findIdView";
	}
	@RequestMapping("/findId")
	@ResponseBody
	public String findId(HttpServletRequest request, Model model) {
		System.out.println("findId");
		com = new YJFindIdCommand();
		com.execute(request, model);
		String findId = (String)request.getAttribute("findId");
		System.out.println(findId);
		return findId;
	}
	@RequestMapping("/changePwView")
	public String findPwView() {
		System.out.println("changePwView");
		return "changePwView";
	}
	@RequestMapping("/changePw")
	@ResponseBody
	public String changePw(HttpServletRequest request, Model model) {
		System.out.println("changePw");
		com = new YJChangePwCommand();
		com.execute(request, model);
		String result = (String)request.getAttribute("result");
		request.setAttribute("result", result);
		if(result.equals("success")) {
			return "changePw-success";
		} else {
			return "changePw-failed";
		}
	}
	@RequestMapping("/changePwGoView")
	public String findPwGoView() {
		System.out.println("changePwGoView");
		return "changePwGoView";
	}
	@RequestMapping("/changePwGo")
	@ResponseBody
	public String changePwGo(HttpServletRequest request, Model model) {
		System.out.println("changePwGo");
		com = new YJChangePwGoCommand();
		com.execute(request, model);
		String result = (String)request.getAttribute("result");
		if(result.equals("success")) {
			return "change-success";
		} else {
			return "change-failed";
		}
	}
	@RequestMapping("/recipeAllView")
	public String recipeAllView(HttpServletRequest request, Model model) {
		System.out.println("recipeAllView");
		com = new YJRecipeAllViewCommand();
		com.execute(request, model);
		return "recipeAllView";
	}
	
	@RequestMapping("/plist")
	public String purl(HttpServletRequest request, Model model) {
		System.out.println("plist요청");
		System.out.println(request.getParameter("pageNo"));
		com = new YJPageListCommand();
		com.execute(request, model);
		requestSetAttr(request);
		return "recipepageBoard";
	}
	
	@RequestMapping("/recipeConditionView")
	public String recipeConditionView(HttpServletRequest request, Model model) {
		System.out.println("recipeConditionView");
		String viewType = request.getParameter("viewType");
		request.setAttribute("viewType", viewType);
		return "recipeConditionView";
	}
	@RequestMapping("/recipeContentView")
	public String recipeContentView(HttpServletRequest request, Model model) {
		System.out.println("recipeContentView");
		com = new YJRecipeContentViewCommand();
		com.execute(request, model);
		requestSetAttr(request);
		return "recipeContentView";
	}
	@RequestMapping("/recipeComment")
	@ResponseBody
	public String recipeComment(HttpServletRequest request, Model model) {
		System.out.println("recipeComment");
		com = new YJRecipeCommentCommand();
		com.execute(request, model);
		String result = (String)request.getAttribute("result");
		if(result.equals("success")) {
			return "comment-success";
		} else {
			return "comment-failed";
		}
	}
	@RequestMapping("/memberOut1")
	public String memberOut1(HttpServletRequest request, Model model) {
		System.out.println("memberOut1");
		return "memberOut1";
	}
	@RequestMapping("/memberOutCheck")
	@ResponseBody
	public String memberOutCheck(HttpServletRequest request, Model model) {
		System.out.println("memberOutCheck");
		com = new YJmemberOutCheckCommand();
		com.execute(request, model);
		String result = (String)request.getAttribute("result");
		if(result.equals("equals")) {
			return "phone-equals";
		} else {
			return "phone-none-equals";
		}
	}
	@RequestMapping("/memberOut2")
	public String memberOut2() {
		System.out.println("memberOut2");
		return "memberOut2";
	}
	@RequestMapping("/memberOut3")
	public String memberOut3() {
		System.out.println("memberOut3");
		return "memberOut3";
	}
	@RequestMapping("/memberOutLast")
	public String memberOutLast(HttpServletRequest request, Model model) {
		System.out.println("memberOutLast");
		com = new YJMemberOutCommand();
		com.execute(request, model);
		return "memberOutLast";
	}
	
	//레시피 등록창
	@RequestMapping("/recipeRegister")
	public String recipeintro1(HttpServletRequest request, Model model) {
		System.out.println("recipeRegister");
		requestSetAttr(request);
		return "recipeRegister";
	}
	
	//레시피 DB에 등록
	@RequestMapping(value="/YJRecipeWrite", produces="application/text; charset=UTF-8")
	@ResponseBody
	public String YJrecipeWrite(MultipartHttpServletRequest mh, Model model,
			@RequestParam("recipeImage") MultipartFile[] files) {
		System.out.println("YJRecipeWrite");
		Date nowTime = new Date();
		SimpleDateFormat nt = new SimpleDateFormat("yyyy/MM/dd hh:mm:ss");
		String id = mh.getParameter("id");
		String title = mh.getParameter("title");
		String writeTime = nt.format(nowTime);
		String recipeIntro = mh.getParameter("recipeIntro");
		String recipeType = mh.getParameter("recipeType");
		String recipeStyle = mh.getParameter("recipeStyle");
		String recipePeople = mh.getParameter("recipePeople");
		String recipeTime = mh.getParameter("recipeTime");
		String topImage = null;
		MultipartFile mfti = mh.getFile("topImage");
		
		//String path = "C:/ojh/workspace/ProjectYJ/ProjectYJ/src/main/webapp/resources/upImage/";
		String path = "D:/jun/workSpace/ProjectYJ/src/main/webapp/resources/upImage/";
		
		String originFileName = mfti.getOriginalFilename();
		long prename = System.currentTimeMillis();
		long fileSize = mfti.getSize();
		System.out.println("originFileName : " + originFileName);
		System.out.println("fileSize : " + fileSize);
		String safeFile = path + prename + originFileName;
		topImage = prename + originFileName;
		YJRecipeDto rdto = new YJRecipeDto(0, id, title, recipeIntro, writeTime, 0, 0, 0, topImage, recipeType, recipeStyle, recipePeople, recipeTime);
		mh.setAttribute("rdto", rdto);
		com = new YJRecipeCommand();
		com.execute(mh, model);
		
		Map<String, Object>map = model.asMap();
		String res = (String)map.get("result");
		System.out.println("res : " + res);
		if(res.equals("success")) {
			try {
				mfti.transferTo(new File(safeFile));
			}
			catch(Exception e) {
				e.printStackTrace();
			}
			String[] recipeContents = mh.getParameterValues("recipeContent");
			int no = (int)map.get("no");
			System.out.println(files.length);
			ArrayList<YJRecipeWriteDto> rwdtos = new ArrayList<YJRecipeWriteDto>();
			ArrayList<String> safeFiles = new ArrayList<String>();
			for(int i=0; i<recipeContents.length; i++) {
				String originImageName = files[i].getOriginalFilename();
				long rwPrename = System.currentTimeMillis();
				long rwFileSize = files[i].getSize();
				System.out.println("originImageName"+i+" : " + originImageName);
				System.out.println("fileSize"+i+" : " + rwFileSize);
				String rwSafeFile = path + rwPrename + originImageName;
				String recipeImage = rwPrename + originImageName;
				YJRecipeWriteDto rwdto = new YJRecipeWriteDto(recipeContents[i], recipeImage, i, no);
				rwdtos.add(rwdto);
				safeFiles.add(rwSafeFile);
			}
			mh.setAttribute("rwdtos", rwdtos);
			com = new YJRecipeWriteCommand();
			com.execute(mh, model);
			String rwResult = (String)map.get("rwResult");
			if(rwResult.equals("success")) {
				for(int i=0; i<recipeContents.length; i++) {
					try {
						files[i].transferTo(new File(safeFiles.get(i)));
					}
					catch(Exception e) {
						e.printStackTrace();
					}
				}
			}
			return "write-success";
		}
		else {
			return "write-failed";
		}
	}
	@RequestMapping("/recipeDelete")
	@ResponseBody
	public String recipeDelete(HttpServletRequest request, Model model) {
		System.out.println("recipeDelete");
		com = new YJRecipeDeleteCommand();
		com.execute(request, model);
		String result = (String)request.getAttribute("result");
		return result;
	}
	@RequestMapping("/recipeModifyView")
	public String recipeModify(HttpServletRequest request, Model model) {
		System.out.println("recipeModifyView");
		com = new YJRecipeModifyViewCommand();
		com.execute(request, model);
		return "recipeModifyView";
	}
	@RequestMapping(value="/recipeModify", produces="application/text; charset=UTF-8")
	@ResponseBody
	public String recipeModify(MultipartHttpServletRequest mh, Model model,
			@RequestParam("recipeImage") MultipartFile[] files) {
		System.out.println("YJRecipeWrite");
		int no = Integer.parseInt(mh.getParameter("no"));
		String title = mh.getParameter("title");
		String recipeIntro = mh.getParameter("recipeIntro");
		String recipeType = mh.getParameter("recipeType");
		String recipeStyle = mh.getParameter("recipeStyle");
		String recipePeople = mh.getParameter("recipePeople");
		String recipeTime = mh.getParameter("recipeTime");
		String topImage = null;
		MultipartFile mfti = mh.getFile("topImage");
		
		//String path = "C:/ojh/workspace/ProjectYJ/ProjectYJ/src/main/webapp/resources/upImage/";
		String path = "D:/jun/workSpace/ProjectYJ/src/main/webapp/resources/upImage/";
		
		String originFileName = mfti.getOriginalFilename();
		long prename = System.currentTimeMillis();
		long fileSize = mfti.getSize();
		System.out.println("originFileName : " + originFileName);
		System.out.println("fileSize : " + fileSize);
		String safeFile = path + prename + originFileName;
		topImage = prename + originFileName;
		YJRecipeDto rdto = new YJRecipeDto(no, title, recipeIntro, topImage, recipeType, recipeStyle, recipePeople, recipeTime);
		mh.setAttribute("rdto", rdto);
		com = new YJRecipeModifyCommand();
		com.execute(mh, model);
		
		Map<String, Object>map = model.asMap();
		String res = (String)map.get("result");
		System.out.println("res : " + res);
		if(res.equals("success")) {
			try {
				mfti.transferTo(new File(safeFile));
			}
			catch(Exception e) {
				e.printStackTrace();
			}
			String[] recipeContents = mh.getParameterValues("recipeContent");
			System.out.println(files.length);
			ArrayList<YJRecipeWriteDto> rwdtos = new ArrayList<YJRecipeWriteDto>();
			ArrayList<String> safeFiles = new ArrayList<String>();
			for(int i=0; i<recipeContents.length; i++) {
				String originImageName = files[i].getOriginalFilename();
				long rwPrename = System.currentTimeMillis();
				long rwFileSize = files[i].getSize();
				System.out.println("originImageName"+i+" : " + originImageName);
				System.out.println("fileSize"+i+" : " + rwFileSize);
				String rwSafeFile = path + rwPrename + originImageName;
				String recipeImage = rwPrename + originImageName;
				YJRecipeWriteDto rwdto = new YJRecipeWriteDto(recipeContents[i], recipeImage, i, no);
				rwdtos.add(rwdto);
				safeFiles.add(rwSafeFile);
			}
			mh.setAttribute("rwdtos", rwdtos);
			com = new YJRecipeWriteModifyCommand();
			com.execute(mh, model);
			String rwResult = (String)map.get("rwResult");
			if(rwResult.equals("success")) {
				for(int i=0; i<recipeContents.length; i++) {
					try {
						files[i].transferTo(new File(safeFiles.get(i)));
					}
					catch(Exception e) {
						e.printStackTrace();
					}
				}
			}
			return "write-success";
		}
		else {
			return "write-failed";
		}
	}
	@RequestMapping("/recipeCommentModify")
	@ResponseBody
	public String recipeCommentModify(HttpServletRequest request, Model model) {
		System.out.println("recipeCommentModify");
		com = new YJCommentModifyCommand();
		com.execute(request, model);
		String result = (String)request.getAttribute("result");
		return result;
	}
	@RequestMapping(value="/inforModify", produces="application/text; charset=UTF-8")
	@ResponseBody
	public String inforModify(MultipartHttpServletRequest mh, Model model) {
		String defaultFile = "default.png";
		System.out.println("inforModify");
		String hidden = mh.getParameter("hidden");
		String id = mh.getParameter("id");
		String nickName = mh.getParameter("nickName");
		String birthday = mh.getParameter("birthday");
		String profileImage = null;
		MultipartFile mfti = mh.getFile("profileImage");
		//String path = "C:/ojh/workspace/ProjectYJ/ProjectYJ/src/main/webapp/resources/upImage/";
		String path = "D:/jun/workSpace/ProjectYJ/src/main/webapp/resources/upImage/";
		String originFileName = mfti.getOriginalFilename();
		String safeFile = null;
		if(originFileName == "") {
			profileImage = defaultFile;
		} else {
			String originFileNamePath = path + originFileName;
			boolean check = checkOriginFileName(originFileNamePath);
			if(check == true) {
				long prename = System.currentTimeMillis();
				long fileSize = mfti.getSize();
				System.out.println("originFileName : " + originFileName);
				System.out.println("fileSize : " + fileSize);
				safeFile = path + prename + originFileName;
				profileImage = prename + originFileName;
			} else {
				profileImage = originFileName;
			}
		}
		System.out.println(profileImage);
		
		YJDto dto = new YJDto(id, profileImage, nickName, birthday);
		mh.setAttribute("dto", dto);
		mh.setAttribute("hidden", hidden);
		com = new YJInforModifyCommand();
		com.execute(mh, model);
		String result = (String)mh.getAttribute("result");
		if(result.equals("inforModify-success") && safeFile != null) {
			try {
				mfti.transferTo(new File(safeFile));
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	public boolean checkOriginFileName(String originFileNamePath) {
		File file = new File(originFileNamePath);
		System.out.println(!file.exists());
		if(!file.exists()) {
			return true;
		}
		return false;
	}
	public void requestSetAttr(HttpServletRequest request) {
		request.setAttribute("viewType", request.getParameter("viewType"));
		request.setAttribute("search", request.getParameter("search"));
		request.setAttribute("searchWhat", request.getParameter("searchWhat"));
		String[] recipeTypes = request.getParameterValues("recipeType[]");
		String[] recipeStyles = request.getParameterValues("recipeStyle[]");
		String[] recipePeoples = request.getParameterValues("recipePeople[]");
		String[] recipeTimes = request.getParameterValues("recipeTime[]");
		request.setAttribute("recipeTypes", recipeTypes);
		request.setAttribute("recipeStyles", recipeStyles);
		request.setAttribute("recipePeoples", recipePeoples);
		request.setAttribute("recipeTimes", recipeTimes);
	}
}
