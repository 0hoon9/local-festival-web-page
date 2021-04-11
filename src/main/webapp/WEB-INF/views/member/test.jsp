<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
			<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

				<!doctype html>
				<html>

				<head>
					<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
					<title>로그인</title>

					<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
					<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet"
						id="bootstrap-css">
					<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
					<link rel="stylesheet" href="/resources/assets/css/login.css">
					<link rel="stylesheet" href="/resources/assets/css/member.css">
				</head>

				<body class="text-center">

			
												<table class="table table-bordered" id="reply">
													<tr>
														<td>1</td>
														<td>2</td>
													</tr>
													<tr>
														<td>3</td>
														<td>4</td>
													</tr>
												</table>
												<table class="table table-bordered" id="reply_c">
												</table>
												<div style="display: none" id="nowp"></div>
												
												<script>
												function favoriteRead() {
													var userId= $('user_id').val();
													
													console.log(userId);
													console.log("시발");
													
													$.getJSON("/favorite/read?user_id="userId, function (data) {
														console.log("응 아니야2");
													});
												};
												</script>
												
												<script>
													$(document).ready(function () {
														favoriteRead();
													});
												</script>
		
				</body>

				</html>