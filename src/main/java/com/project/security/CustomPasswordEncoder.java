package com.project.security;

import org.springframework.security.crypto.password.PasswordEncoder;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomPasswordEncoder implements PasswordEncoder {
	
	// 커스텀 패스워드 인코더 페이지를 만들어서 security-context에 빈으로 등록함
	// 해당 패이지를 통해서 비밀번호 암호화 및 내용 비교가 가능
	public String encode(CharSequence rawPassword) {
		log.warn("인코딩 전 패스워드: "+rawPassword);
		
		return rawPassword.toString();
	}
	
	public boolean matches(CharSequence rawPassword, String encodedPassword) {
		log.warn("인코딩 전: 인코딩 후: "+rawPassword+":"+encodedPassword);
		return rawPassword.toString().equals(encodedPassword);
	}
}
