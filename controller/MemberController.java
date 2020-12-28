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
		
		// 회원 가입 페이지에서 받은 정보를 mv에 담아서 서비스로 전달함
		service.mem_register(mv);
		
		return "redirect:/board/main";
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

}
