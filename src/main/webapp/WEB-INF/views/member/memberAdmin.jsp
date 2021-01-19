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

					<div class="container">
						<div class="row">
							<div class="col-md-6 col-md-offset-3">
								<div class="panel panel-login">
									<div class="panel-heading">
										<div class="row">
											<div class="col-xs-6">
												<p id="p-head">
													<sec:authentication property="principal.member.user_Name" />님 회원정보
												</p>
											</div>
										</div>
										<hr>
									</div>
									<div class="panel-body">
										<div class="row">
											<div class="col-lg-12">
												<div class="form-group">
													<span>ID</span><input type="text" tabindex="1" class="form-control" readonly
														value=<sec:authentication property="principal.member.user_id" /> >
												</div>
												<div class="form-group">
													<span>이름</span><input type="text" tabindex="2" class="form-control" readonly
														value=<sec:authentication property="principal.member.user_Name" />>
												</div>
												<div class="form-group">
													<div class="row">
														<div class="col-sm-6 col-sm-offset-3">
															<a href="/member/passwordModify">비밀번호 변경하기</a>
															<br>
															<a href="/herethere/main">메인화면으로 돌아가기</a>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

				</body>

				</html>