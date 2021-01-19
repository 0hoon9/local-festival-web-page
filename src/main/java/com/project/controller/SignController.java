package com.project.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/sign/*")
@Controller
public class SignController {
	// 해당 컨트롤러는 로그인과 관련된 메서드들만 따로 모아둠
	
	// 커스텀 에러 페이지를 위한 메서드
	// 커스텀 에러 페이지로 자동 접속되도록 하는 것은 스프링이 알아서 해줌
	// 물론 수동으로 접속 가능하도록 링크를 달수도 있지만 스프링이 알아서 사용자가 권한에 맞지 않는 행동을 할 경우에 알아서 자동으로 에러 메시지 페이지로 이동시킴
	@GetMapping("/accessError")
	public void accessDenied(Authentication	auth, Model model) {
		model.addAttribute("msg", "Access Denied");
	}
	 
	// 커스텀 로그인 페이지를 위한 메서드
	// 기존 커스텀 로그인 페이지에서 기능이 조금 더 추가됨
	// 로그인 이후 접속 경로에 따른 연결 페이지가 세분화 됨
	// 1. 즐겨찾기를 통해 로그인 페이지를 접속했을 경우는 로그인 후 메인 페이지로 연결됨
	// 2. 사이트 내 링크를 통해서 로그인 페이지를 접속했을 경우 로그인 페이지 접속하기 전 페이지로 자동 연결됨
	// 더 자세한 내용은 CustomLoginSuccessHandler를 참조
	@GetMapping("/customLogin")
	public String loginInput(String error, String logout, Model model, HttpServletRequest request) {
		
		if(error != null) {
			model.addAttribute("error", "에러입니다. 계정을 확인해주세요");
		}
		
		if(logout != null) {
			model.addAttribute("logout", "로그아웃됩니다");
		}
		
		// referer이란 http 요청을 할 때 헤드에 같이 실어지는 정보로서 현재 요청된 페이지의 링크 이전의 웹 페이지 주소를 포함한다.
		// 자세한 내용은 https://developer.mozilla.org/ko/docs/Web/HTTP/Headers/Referer
		// 즐겨찾기를 통해 해당 페이지 접속 시 referer값은 null
		// 사이트 내 특정 버튼을 통해 링크로 들어왔다면 로그인 페이지 접속하기 전 페이지 값이 referer값으로 입력되있다.
		String uri = request.getHeader("Referer");
		
		// 즐겨찾기로 들어왔을 때
		if(uri == null) {
			request.getSession().setAttribute("prevPage", request.getHeader("Referer"));
			return "/sign/customLogin";
		}
		// 사이트 내 링크를 통해서 들어왔을 때
		else if(!uri.contains("/customLogin")) {
			request.getSession().setAttribute("prevPage", request.getHeader("Referer"));
		}
		
	return "/sign/customLogin";
	}
	
	// 커스텀 로그아웃에 관한 메서드
	// 커스텀 로그아웃을 할경우 get방식으로 해당 페이지에 먼저 접속한 뒤에 버튼을 눌러서 
	// post 방식 로그아웃 버튼을 눌러야 로그인이 되는 구조...
	// 즉 일반 사이트처럼 로그아웃 버튼 누르면 그냥 바로 로그아웃이 되지 않고 커스텀 로그아웃 페이지로 연결되고 거기서 로그아웃 버튼을 진짜로 눌러야 로그아웃이 됨...
	// 그래서 get방식으로 해당 페이지에 접속만 하면 로그아웃이 자동으로 되도록 jsp 파일에서 조작을 해줌
	@GetMapping("/customLogout")
	public void logoutGET() {
	}
	
	@PostMapping("/customLogout")
	public void logoutPost() {
	}

}