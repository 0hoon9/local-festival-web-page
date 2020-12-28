package com.project.controller;

import org.springframework.security.access.annotation.Secured;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/grade/*")
@Controller
public class GradeController {
	
	// 테스트용 클래스
	// url 주소에 따른 멤버 권한 부여
	// 신경쓰지마세요
	
	@GetMapping("/guest")
	public void guest() {
		log.info("공용접속");
	}
	
	@GetMapping("/member")
	public void member() {
		log.info("멤버 로그인");
	}
	
	@GetMapping("/admin")
	public void admin() {
		log.info("관리자 로그인");
	}
	
	@PreAuthorize("hasAnyRole('MEMBER', 'ADMIN')")
	@GetMapping("/signMebmer")
	public void member2() {
		log.info("어노테이션으로 접속한 멤버");
	}
	
	@Secured({"ADMIN"})
	@GetMapping("/signAdmin")
	public void admin2(){
		log.info("어노테이션으로 접속한 어드민");
	}
	
}
