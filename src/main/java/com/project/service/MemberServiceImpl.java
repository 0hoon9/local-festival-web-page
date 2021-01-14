package com.project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.domain.MemberVO;
import com.project.mapper.MemberMapper;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MemberServiceImpl implements MemberService{

	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder pwencoder;
	
	// 회원 가입 관련 메서드
	// 회원 가입 메서드는 안에서 총 3가지 기능을 수행 하게 됨
	// 1. 전달 받은 비밀 번호를 암호화한 후 mv에 다시 저장
	// 2. 암호화 한 비밀번호가 입력된 회원 정보가 DB 내 tbl_member에 저장되도록 memberRegister 메서드 실행
	// 3. 회원 정보가 입력된 후 해당 회원에 대해 권한을 주기 위한 memberAuthResister 메서드 실행. 이때 회원 권한은 memberAuthResister 테이블에 저장됨.
	// 회원 가입 과정 시 위 3개의 과정 중 하나라도 빠지면 회원 가입에 문제가 생기므로 @Transactional를 이용해서 3개 중 하나만 실패해도 3개 과정 모두 실패하도록 만들었다. 
	@Transactional
	@Override
	public boolean mem_register(MemberVO mv) {
		
		// 1. 전달 받은 비밀 번호 암호화 후 mv에 다시 저장하는 과정
		// 회원 가입 페이지에서 받은 비밀 번호는 암호화를 거쳐야 한다. 그렇지 않다면 개인 정보 노출의 위험이 커진다
		// 스프링에서는 전달받은 정보를 암호화할 수 있는 인터페이스와 메서드를 제공한다.
		// 여기서는 PasswordEncoder 인터페이스와 거기서 제공되는 encode 메서드를 이용한다.
		// 참고로 한번 암호화 된 비밀 번호는 복호화 즉 다시 스트링으로 변환이 불가능하다. 즉 스프링은 단방향 암호화만 제공한다.
		String rawPassword = pw_change(mv.getUser_pw());
		
		mv.setUser_pw(rawPassword);
		
		// 2. 암호화된 비밀 번호가 입력된 mv를 전달하여 회원 가입을 하는 메서드
		mapper.memberRegister(mv);
		
		// 3. 회원 정보가 입력된 후 해당 회원 정보와 연동된 memberAuthResister 테이블에 member회원 권한을 부여하는 메서드
		mapper.memberAuthResister(mv.getUser_id());
		
		return true;
	}
	
	// 회원 비밀 번호 수정 메서드
	// 전달받은 mv, 새로운 비밀 번호, 확인용 새로운 비밀 번호를 전달받아서 회원 비밀 번호를 갱신한다.
	// 1. 기존 회원의 비밀 번호와 비밀 번호 변경 페이지에서 사용자가 입력한 비밀 번호가 동일한지 확인
	// 2. 만약 동일하다면 새로 입력한 비밀번호와 확인용으로 새로 입력한 비밀번호가 동일한지 확인
	// 3. 만약 앞의 두 과정이 true라면 새로 입력한 비밀 번호는 암호화를 거친 후 mv에 저장되고 mv를 memberPwChange 메서드에 전달하여 비밀 번호를 변경한다.
	@Transactional
	@Override
	public boolean mem_passwordModify(MemberVO mv, String new_pw, String new_pw_check) {
		
		// 1번 과정
		boolean result = memberPwCheck(mv.getUser_id(), mv.getUser_pw());
		if(result == false) {
			return false;
		}
		
		// 2번 과정
		if(new_pw.equals(new_pw_check)) {
			// 3번 과정
			// 3번 과정은 회원 가입 메서드에서 이뤄지는 비밀 번호 암호화와 거의 비슷한 과정을 거친다.
			String changedpassword = pw_change(new_pw);
			
			mv.setUser_pw(changedpassword);
			
			mapper.memberPwChange(mv);
			
			return true;
			
		} else {
			// 만약 새로운 비밀 번호와 확인용 새로운 비밀 번호가 맞지 않으면 여기로 온다.
			return false;
		}
	}
	
	/* ========================================================================================== */
	/* ==================== 아래의 메서드들은 위의 회원 가입 및 회원 비밀번호 수정용으로 만든 메서드다.==================== */
	/* ==================== 가급적이면 기능별 로직을 구분하고 중복 사용하는 메서드를 따로 분리하려고 했다 ================== */
	/* ========================================================================================= */
	
	// 회원 id 체크 메서드
	@Override
	public boolean mem_check(String user_id) {
		// 회원 아이디를 전달 받아서 id 중복 여부를 체크한다.
		return mapper.memberCheck(user_id);
	}
	
	// 회원 패스워드 암호화 메서드
	@Override
	public String pw_change(String user_pw) {
		// 회원 비밀 번호를 전달 받아서 암호화한다.
		return pwencoder.encode(user_pw);
	}

	// 회원 id와 패스워드 일치 여부 확인
	// 회원의 아이디와 비밀 번호를 전달 받아서 현재 해당 회원 아이디로 입력된 비밀 번호와 사용자가 입력한 비밀 번호가 맞는지 확인하는 메서드
	@Override
	public boolean memberPwCheck(String user_id, String user_pw) {
		
		// 해당 메서드에서 굉장히 중요한 메서드 중 하나가 바로 matches()다.
		// 위에서 말했듯 스프링은 암호화 단방향으로만 제공한다.
		// 즉 한번 암호화 된 비밀번호는 그 스트링데이터만으로는 복호화가 불가능하다. 해커가 해킹을 해서 DB의 비밀번호를 훔쳐가도 암호화만 해놨으면 원래 모습을 알 수 없다.
		// 그러면 사용자가 입력한 비밀번호는 어떻게 기존 암호화된 비밀 번호와 비교할까?
		// 사용자가 직접 복호화가 불가능하다는 것은 기존 암호화된 비밀 번호와 새 비밀 번호를 비교할 수 없다는 말이다.
		// 그래서 스프링은 matches()메서드를 통해서 이를 해결하게 돕는다.
		// PasswordEncoder 인터페이스가 제공하는 해당 메서드는 matches(회원이 입력한 비밀번호, DB에 저장된 해당 회원의 복호화된 비밀번호) 형태로 입력하면 true, false로 결과를 알려준다.
		if(pwencoder.matches(user_pw, mapper.memberPwCheck(user_id))){
			log.warn("비밀번호 일치");
			return true;
		} else {
			log.warn("비밀번호 불일치");
			return false;
		}
	}

	
	// 유저 이름과 아이디를 전달 받아서 DB에 전달해주는 메서드
	@Override
	public boolean memFindPassword(MemberVO mv) {
		// 전달된 정보가 DB가 있다면 true 전달, 없다면 false 전달
		Boolean result = mapper.memberFindPassword(mv);
		if(result == true) {
			return true;
		} else {
			return false;
		}
	}

	// 유저 이름, 아이디, 새로운 패스워드를 전달 받아 DB를 업데이트 하는 메서드
	@Override
	public boolean memChangePassword(MemberVO mv, String new_pw, String new_pw_check) {
		// 우선 새 패스워드와 확인용 패스워드가 일치하지 않으면 false, 일치한다면 true
		if(new_pw.equals(new_pw_check)) {
			
			// 패스워드가 true일 때, 다시 한번 회원 이름, 비번을 확인함
			// 이름, 비번이 DB에 존재할 경우 true, DB에 없다면 false
			if(mapper.memberFindPassword(mv) == true) {
				// 비밀번호 변경을 위한 새로운 비번 인코딩
				String password = pw_change(new_pw);
				
				// DB에 전달된 mv에 새로 인코딩 된 패스워드 세팅
				mv.setUser_pw(password);	
				
				// 기존에 있었던 패스워드 변경 메서드를 이용해서 해당 계정의 비밀 번호 변경
				mapper.memberPwChange(mv);
				return true;
				}
			return false;
			}
		return false;
		}
	}