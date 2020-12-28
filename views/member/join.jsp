<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> 가입 화면 </title>
</head>
<body>
	<form role="form" action="/member/join" method="post">
		아이디: <input id="user_id" type="text" name="user_id"><button type="button" id="checkbutton">아이디 중복체크</button><br>
		이름: <input type="text" name="user_Name"><br>
		비밀번호: <input type="password" name="user_pw"><br>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<button type="submit">가입하기</button><br>
	</form>
</body>

<script type="text/javascript">

var checkbtn = $("#checkbutton");

// ajax를 이용한 회원 아이디 중복 체크
$(checkbtn).on("click", function(e){
	$.ajax({
		url: '/member/membercheck',
		type: 'Get',
		dataType: "json",
		data: {"user_id":$("#user_id").val()},
		success: function(data){
			console.log(data);
			if(data==true){
				alert("아이디가 중복입니다");
				} else {
					alert("중복된 아이디가 없습니다");
					}
			}
	}); //ajax 종료
}); // 스크립트 끝


</script>
</html>