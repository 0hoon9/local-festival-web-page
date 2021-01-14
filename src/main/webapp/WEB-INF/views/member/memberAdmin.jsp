<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!DOCTYPE html>
<html lang="en">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> 회원 정보 관리 </title>
</head>

<body>

<h1> 회원 정보 관리 </h1>
	<P><sec:authentication property="principal.member.user_Name" />님 계정 정보</P>
	<P>멤버 아이디 : <sec:authentication property="principal.member.user_id" /></P>
	<P>멤버 이름 : <sec:authentication property="principal.member.user_Name" /></P>
	<a href="/member/passwordModify">비밀번호 변경하기</a>
	<a href="/herethere/main">메인화면으로 돌아가기</a>
</body>

</html>