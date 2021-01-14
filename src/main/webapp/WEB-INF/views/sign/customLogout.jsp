<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!DOCTYPE html>
<html lang="en">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> 로그아웃 </title>
</head>

<body>
	<form role="form" method='post' action="/sign/customLogout">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<button id="btn"></button><br>
	</form>
</body>

<script type="text/javascript">

	// 해당 메서드는 커스텀 로그아웃 페이지 접속 시 별도로 post 방식으로 정보를 보낼 필요없이 자동으로 클릭되어서 get방식으로
	// 해당 페이지에 접속하면 바로 로그아웃되도록 만든 메서드
	window.onload = function(){
			let btn = document.getElementById('btn').click();
	}
	
</script>

</html>