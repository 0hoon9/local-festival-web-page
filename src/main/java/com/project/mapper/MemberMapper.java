package com.project.mapper;

import org.springframework.transaction.annotation.Transactional;

import com.project.domain.FavoriteVO;
import com.project.domain.MemberVO;

public interface MemberMapper {
	
	// 아이디를 전달받아 해당 아디의 회원 정보 및 권한을 전달하는 메서드
	public MemberVO call(String user_id);
	
	// 회원 가입을 위한 메서드
	public void memberRegister(MemberVO mv);
	
	// 회원 권한 입력을 위한 메서드(여기서는 xml 파일을 참고하면 알겠지만 기본 사이트 내 회원 가입시 ROLE_MEMBER를 주도록 기본 설정함)
	public void memberAuthResister(String user_id);
	
	public void adminAuthResister(String user_id);
	
	// 회원 아이디 중복 체크를 위한 메서드
	public boolean memberCheck(String user_id);
	
	// 회원 비밀 번호를 가져오기 위한 메서드
	public String memberPwCheck(String user_id);
	
	// 회원 비밀번호 변경을 위한 메서드
	public void memberPwChange(MemberVO mv);
	
	// 비밀번호를 찾아주기 위한 인증 메서드
	public boolean memberFindPassword(MemberVO mv);
	
}
