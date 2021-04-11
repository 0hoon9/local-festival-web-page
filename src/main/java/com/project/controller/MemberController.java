package com.project.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.domain.MemberVO;
import com.project.service.MemberService;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/member/*")
@AllArgsConstructor
public class MemberController {
	// 회원 가입 및 회원 패스워드 수정 등에 관한 컨트롤러
	
	@GetMapping("/test")
	public void test() {
		
	}
	
	MemberService service;
	
	// @PreAuthorize("isAnonymous()") - 어노테이션을 이용해 회원가입 페이지("/join")는 로그인 하지 않은 누구나 접속 가능
	@PreAuthorize("isAnonymous()")
	@GetMapping("/join")
	public void join() {
	};
	
	// get방식으로 접속한 회원 가입 페이지에서 중복 아이디를 확인하는 메서드
	// 해당 메서드는 비동기 방식으로 아이디를 전달 받아서 확인 후 true / false 값을 리턴해 줌
	@ResponseBody
	@GetMapping(value="/membercheck")
	public boolean membercheck(String user_id) {
		// 유저의 id를 받아서 service로 전달해줌
		return service.mem_check(user_id);
	};
	
	// get방식으로 접속한 회원 가입 페이지에서 입력한 정보를 전달 받는 메서드
	@PostMapping("/join")
	public String register(MemberVO mv) {
		
		String auth = "ROLE_MEMBER";
		// 회원 가입 페이지에서 받은 정보를 mv에 담아서 서비스로 전달함
		service.mem_register(mv, auth);
		
		return "redirect:/herethere/main";
	}
	
	
	@GetMapping("/join_admin")
	public void admin_resiter() {
		
	}
	
	@PostMapping("/join_admin")
		public String admin_register(MemberVO mv) {
			
			String auth = "ROLE_ADMIN";
			
			// 회원 가입 페이지에서 받은 정보를 mv에 담아서 서비스로 전달함
			service.mem_register(mv, auth);
			
			return "redirect:/herethere/main";
		}
	
	// 회원 정보 확인(/memberAdmin) 페이지 접속 메서드
	// @PreAuthorize("isAuthenticated()") 어노테이션을 이용해 회원 로그인 된 사람만 접속 가능하도록 만듦
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/memberAdmin")
	public void memberAdmin() {
	}
	
	// 회원 정보 확인 페이지에서 비밀 번호 변경 링크를 누를 경우 비번 변경 페이지("/passwordModify")로 접속하는 메서드 
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/passwordModify")
	public void passwordModify() {
	}
	
	// 비번 변경 페이지에서 입력한 정보를 post 방식으로 전달 받는 메서드
	@ResponseBody
	@PostMapping("/passwordModify")
	public boolean passwordModify(MemberVO mv, String new_pw, String new_pw_check) {
		
		// 비번 변경 페이지에서 받은 정보를 mv와 new_pw, new_pw_check 총 세가지 형태로 받아서 전달해줌
		// 새로운 비밀번호, 확인용 새로운 비밀 번호는 memberVO에 없어서 따로 받아줌
		// 참고로 기존의 id, 기존의 password도 새로운 비밀번호처럼 별도의 파라미터로 받아줄 수 있긴한데
		// 마이바티스는 값을 입력할 때 한 가지 타입의 자료만 입력이 가능함
		// 즉 id, password를 각각 스트링으로 받아서 마이바티스에 입력하면 마이바티스가 제대로 인식을 못함
		// 그래서 xml 파일에 직접 전달되는 id, password 같은 자료는 memberVO와 같은 형태로 묶어서 전달해줘야 함
		// 설명이 이상해서 아래 페이지 참고
		// https://pro-pennek.tistory.com/entry/Spring-MVC-Mybatis-DB%EC%97%90-%EA%B0%92-%EB%84%A3%EA%B8%B0-Mapping-%EC%98%A4%EB%A5%98-%ED%95%B4%EA%B2%B0
		
		// 전달 받은 자료를 서비스로 전달
		return service.mem_passwordModify(mv, new_pw, new_pw_check);
	}
	
	// 비밀번호 찾기 위한 (/findPassword) 접속 메서드
	// 회원 정보가 이름, 비번, 아이디만 있어서 우선 이름, 아이디를 입력해서 둘이 일치할 경우 비밀번호 변경 페이지로 이동하는 메서드
	@PreAuthorize("isAnonymous()")
	@GetMapping("/findPassword")
	public void findPassword() {	
	}
	
	// 비밀번호 찾기 위한 "/findPassword" 페이지에서 ajax 방식으로 전달된 유저 이름과 아이디를 전달받는 post 메서드
	@ResponseBody
	@PostMapping("/findPassword")
	public boolean findPassword(MemberVO mv) {
		// 서비스의 memFindPassword 메서드로 이름과 아이디 전달
		return service.memFindPassword(mv);
	}
	
	// "/findPassword" 페이지에서 인증을 하고 나면 해당 페이지 접속 가능함
	// 인증 후 직접 비밀 번호 변경이 가능한 페이지로 접속을 위한 get 메서드
	@PreAuthorize("isAnonymous()")
	@GetMapping("/changePassword")
	public void chagePasswrod(MemberVO mv, String new_pw, String new_pw_check) {
	}
	
	// 다시 한번 ajax 방식으로 전달된 유저 아이디, 이름, 패스워드 등을 전달 받음 
	@ResponseBody
	@PostMapping("/changePassword")
	// 전달 받은 정보를 service의 memChangePassword 메서드로 이름과 아이디 전달
	public boolean changePassword(MemberVO mv, String new_pw, String new_pw_check) {
		return service.memChangePassword(mv, new_pw, new_pw_check);
	}

}
