<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>	
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> 관리자 로그인 화면 </title>
</head>
<body>
	<P><sec:authentication property="principal.member.user_Name" />님 환영합니다.</P>
	
	<sec:authorize access="isAnonymous()">
		<a href="/sign/customLogin">로그인</a>
	</sec:authorize>
	
	<sec:authorize access="isAuthenticated()">
		<a href="/sign/customLogout">로그아웃</a>
	</sec:authorize>
</body>
</html>