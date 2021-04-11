package com.project.service;

import java.util.List;

import com.project.domain.MemberVO;

public interface MemberService {
	
	// 회원 가입을 위한 메서드
	public boolean mem_register(MemberVO mv, String auth);

	// 회원 아이디 확인을 위한 메서드
	public boolean mem_check(String user_id);
	
	//회원 비밀 번호 변경을 위한 메서드
	public String pw_change(String user_pw);
	
	// 회원 비밀번호를 확인하기 위한 메서드
	public boolean memberPwCheck(String user_id, String user_pw);
	
	// 회원 비밀 번호 변경을 위한 메서드
	public boolean mem_passwordModify(MemberVO mv, String new_pw, String new_pw_check);
	
	// 회원 비밀 번호를 찾기 위한 메서드
	public boolean memFindPassword(MemberVO mv);
	
	// 회원 비밀 번호를 변경하기 위한 메서드
	public boolean memChangePassword(MemberVO mv, String new_pw, String new_pw_check);
}
