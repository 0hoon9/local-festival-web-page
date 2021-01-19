<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

		<!doctype html>
		<html>

		<head>
			<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
			<title>로그인</title>

			<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
			<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
			<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
			<link rel="stylesheet" href="/resources/assets/css/login.css">
		</head>

		<body class="text-center">

			<div class="container">
				<div class="row">
					<div class="col-md-6 col-md-offset-3">
						<div class="panel panel-login">
							<div class="panel-heading">
								<div class="row">
									<div class="col-xs-6">
										<a href="#" class="active" id="login-form-link">로그인</a>
									</div>
									<div class="col-xs-6">
										<a href="#" id="register-form-link">회원가입</a>
									</div>
								</div>
								<hr>
							</div>
							<div class="panel-body">
								<div class="row">
									<div class="col-lg-12">
										<form id="login-form" action="/login" method="post" role="form" style="display: block;">
											<div class="form-group">
												<input type="text" name="user_id" id="user_id" tabindex="1" class="form-control"
													placeholder="ID" value="">
											</div>
											<div class="form-group">
												<input type="password" name="user_pw" id="user_pw" tabindex="2" class="form-control"
													placeholder="Password">
											</div>
											<div class="form-group text-center">
												<input type="checkbox" tabindex="3" class="" name="remember" id="remember">
												<label for="remember">자동 로그인</label>
											</div>
											<div class="form-group">
												<div class="row">
													<div class="col-sm-6 col-sm-offset-3">
														<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
														<input type="submit" name="login-submit" id="login-submit" tabindex="4"
															class="form-control btn btn-login" value="로그인">
													</div>
												</div>
											</div>
											<div class="form-group">
												<div class="row">
													<div class="col-lg-12">
														<div class="text-center">
															<a href="/member/findPassword" tabindex="5" class="forgot-password">비밀번호를
																잊어버렸습니까?</a>
														</div>
													</div>
												</div>
											</div>
										</form>
										<form id="register-form" action="/member/join" method="post" role="form" style="display: none;">
											<div class="form-group">
												<input type="text" name="user_id" id="user_idc" tabindex="1" class="form-control"
													placeholder="ID" value="">
												<button type="button" id="checkbtn">아이디 중복체크</button>
											</div>
											<div class="form-group">
												<input type="text" name="user_Name" id="user_Name" tabindex="1" class="form-control"
													placeholder="이름" value="">
											</div>
											<div class="form-group">
												<input type="password" name="user_pw" id="user_pw" tabindex="2" class="form-control"
													placeholder="패스워드">
											</div>
											<div class="form-group">
												<input type="password" name="confirm-password" id="confirm-password" tabindex="2"
													class="form-control" placeholder="비밀번호 재확인">
											</div>
											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
											<div class="form-group">
												<div class="row">
													<div class="col-sm-6 col-sm-offset-3">
														<input type="submit" name="register-submit" id="register-submit" tabindex="4"
															class="form-control btn btn-register" value="회원가입">
													</div>
												</div>
											</div>
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

		</body>

		</html>
		<script>
			$(document).ready(function () {

				$('#login-form-link').click(function (e) {
					$("#login-form").delay(100).fadeIn(100);
					$("#register-form").fadeOut(100);
					$('#register-form-link').removeClass('active');
					$(this).addClass('active');
					e.preventDefault();
				});
				$('#register-form-link').click(function (e) {
					$("#register-form").delay(100).fadeIn(100);
					$("#login-form").fadeOut(100);
					$('#login-form-link').removeClass('active');
					$(this).addClass('active');
					e.preventDefault();
				});

			});
			var checkbtn = $("#checkbtn");

			// ajax를 이용한 회원 아이디 중복 체크
			$("#checkbtn").on("click", function (e) {
				$.ajax({
					url: '/member/membercheck',
					type: 'Get',
					dataType: "json",
					data: { "user_id": $("#user_idc").val() },
					success: function (data) {
						console.log(data);
						if (data == true) {
							alert("아이디가 중복입니다");
						} else {
							alert("중복된 아이디가 없습니다");
						}
					}
				}); //ajax 종료
			}); // 스크립트 끝
		</script>