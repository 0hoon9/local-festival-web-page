package com.project.security;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler{
	
		// 로그인이 성공했을 경우 해당 핸들러가 처리하도록 함

		// 해당 핸들러에선 총 3가지 종류를 가정하고 로그인 성공 후 URI를 포워드 혹 리다이렉트 할 예정
		// sign 컨트롤러와도 연결됨
	
		@Override
		public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
				Authentication auth) throws IOException, ServletException {
			
			// IP, 세션 ID
			WebAuthenticationDetails web = (WebAuthenticationDetails) auth.getDetails();
			System.out.println("IP : " + web.getRemoteAddress());
			System.out.println("Session ID : " + web.getSessionId());
			
			// 인증 ID
			System.out.println("name : " + auth.getName());
			
			// 권한 리스트
			List<GrantedAuthority> authList = (List<GrantedAuthority>) auth.getAuthorities();
			System.out.print("권한 : ");
			for(int i = 0; i< authList.size(); i++) {
				System.out.print(authList.get(i).getAuthority() + " ");
			}
			System.out.println();
			
			// 기본 URI
			String uri = "/herethere/main";
			
			// 접근 권한이 없는 페이지에 들어왔을 때 페이지에 대한 요청을 가로채기 위해 데이터 저장
			RequestCache requestCache = new HttpSessionRequestCache();
			SavedRequest savedResRequest = requestCache.getRequest(request, response);
			
			// 로그인 버튼을 눌러서 특정 페이지에 대한 요청을 했을 때 해당 페이지에 대한 요청 저장
			// 해당 요청은 컨트롤러에서 전달 받음
			String prevPage = (String) request.getSession().getAttribute("prevPage");
			log.info(prevPage);
			
			// 만약 버튼을 눌러서 null이 아니면 바로 세션을 삭제 후 원래 요청했던 페이지로 접속
			if(prevPage != null) {
				log.info("로그인 버튼 눌러서 들어올 때");
				request.getSession().removeAttribute("prevPage");
			}
			
			// 만약 prevpage가 null이고 savedResRequest가 null이 아니라면 접근 권한 없는 페이지에 대한 접근했다는 것
			// 즉 이때는 savedResRequest에 있는 URL값으로 리다이렉트
			if(savedResRequest != null) {
				log.info("접근 권한 없는 페이지에 접근했을 때");
				uri = savedResRequest.getRedirectUrl();
				
				// 세션에 저장되있던 URI 정보를 가진 객체는 메모리 관리를 위해 삭제
				requestCache.removeRequest(request, response);
			}
			
			// 만약 prevPage가 ""가 아니라면 이는 바로 즐겨찾기 등으로 들어왔다는 이야기
			// 그래서 컨트롤러에서 받은 prevPage를 통해 데이터 전달받아서 리다이렉트
			else if(prevPage != null && !prevPage.equals("")){
				log.info("기타 등");
				uri = prevPage;
			}
			
			response.sendRedirect(uri);
		}
}