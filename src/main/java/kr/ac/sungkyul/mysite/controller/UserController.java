package kr.ac.sungkyul.mysite.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.ac.sungkyul.mysite.service.UserService;
import kr.ac.sungkyul.mysite.vo.UserVo;

@Controller
@RequestMapping("/user")
public class UserController {
	@Autowired
	UserService userService;

	@RequestMapping("/joinform")
	public String joinForm() {
		return "/user/joinform";
	}

	@RequestMapping(value = "/join", method =RequestMethod.POST)
	public String join(@ModelAttribute UserVo vo) {
		userService.join(vo);
		return "redirect:/user/joinsuccess";
	}

	@RequestMapping("/joinsuccess")
	public String joinSucess() {
		return "/user/joinsuccess";
	}

	@RequestMapping("/loginform")
	public String loginForm() {
		return "/user/loginform";
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(
			HttpSession session,
			@RequestParam(value = "email", required = false, defaultValue = "") String email,
			@RequestParam(value = "password", required = false, defaultValue = "") String password) {
		UserVo authUser = userService.login(email, password);
		if (authUser == null) {
			return "redirect:/user/loginform";
		}
		
		//인증 성공
		session.setAttribute("authUser", authUser);
		return "redirect:/main";
	}
	@RequestMapping("/logout")
	public String logout( HttpSession session){
		session.removeAttribute("authUser");
		session.invalidate();
		return "redirect:/main";
	}
	
	
	@RequestMapping("/modifyform")
	public String modifyform(HttpSession session,Model model){
		UserVo authUser =(UserVo)session.getAttribute("authUser");
		Long userNo = authUser.getNo();
		UserVo uservo = userService.get(userNo);
		
		model.addAttribute("userVo", uservo);
		
		return "/user/modifyform";
	}
	
	@RequestMapping(value = "/modify", method =RequestMethod.POST)
	public String modify(@ModelAttribute UserVo vo ,HttpSession session){
		UserVo authUser =(UserVo)session.getAttribute("authUser");
		Long userNo=authUser.getNo();
		vo.setNo(userNo);
		System.out.println(vo);
		userService.update(vo);
		authUser.setName(vo.getName());
		
		return "redirect:/main";
	}
	
	
	
	

}
