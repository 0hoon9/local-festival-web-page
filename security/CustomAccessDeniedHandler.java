package com.project.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomAccessDeniedHandler implements AccessDeniedHandler{
	
	// 커스텀 접근 제한 페이지
	// 해당 페이지는 보통 스프링이 알아서 관리한다
	// security-context.xml을 확인하면 해당 페이지가 빈으로 등록된 것을 확인 가능하다
	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response, AccessDeniedException accessException) throws IOException, ServletException{
		log.error("접근이 제한되었습니다.");
		log.error("접근 제한 핸들러");
		log.error("리다이렉트 됩니다.");
		response.sendRedirect("/sign/accessError");
	}
}
