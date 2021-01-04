<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "httpL//www.w3.org/TR/html4/loose.dtd>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> 로그인 페이지입니다. </title>
</head>
<body>
<h1> 로그인 페이지 </h1>
<h2><c:out value="${error}"/></h2>
<h2><c:out value="${logout}"/></h2>

<form role="form" method='post' action="/login">
	<fieldset>
		<input name="user_id" type="text" value="아이디"><br>
		<input name="user_pw" type="password" value="패스워드"><br>
		<label> <input name="remember-me" type="checkbox">자동 로그인</label><br>
	</fieldset>
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	<input type="submit"><br>
</form>
<P>혹시 비밀번호가 기억나지 않으세요? <a href="/member/findPassword">비밀번호 찾으러 가기</a> </P>

<script>
</script>

</html>