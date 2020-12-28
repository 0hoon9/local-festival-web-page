package com.project.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.project.domain.CustomUser;
import com.project.domain.MemberVO;
import com.project.mapper.MemberMapper;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class CustomUserDetailsService implements UserDetailsService{
	
	// security-context.xml 파일 참조
	// 스프링이 로그인 처리 시 DB에서 자료를 불러올 수 있도록 도와주는 역할을 함
		
	@Setter(onMethod_ = { @Autowired })
	private MemberMapper memberMapper;
	
	@Override
	public UserDetails loadUserByUsername(String user_id) throws UsernameNotFoundException{
		log.warn("loadUser 메서드 시작");
		log.warn("유저네임 : "+user_id);
		
		// 해당 메서드가 call()이 아이디를 입력하면 해당 아이디에 맞는 회원 정보를 불러옴
		MemberVO vo = memberMapper.call(user_id);
		
		log.warn("멤버매퍼"+vo);
		
		// call메서드를 통해서 불러온 자료를 MemberVo에 담고 그것으로 CustomUser라는 객체를 만들어서 돌려줌
		// 해당 과정은 커스텀 로그인을 할 경우 거쳐야 하는 과정으로 security-context에서 해당 파일을 불러서 사용하게 된다
		return vo == null? null : new CustomUser(vo);
	}
}
