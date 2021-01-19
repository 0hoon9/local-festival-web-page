<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
			<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
				<script src="https://code.jquery.com/jquery-3.5.1.js"
					integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>

				<!doctype html>
				<html>

				<head>
					<meta name="_csrf" content="${_csrf.token}" />
					<meta name="_csrf_header" content="${_csrf.headerName}" />
					<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
					<title> 비밀번호 수정 </title>

					<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet"
						id="bootstrap-css">
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
												<a href="#" class="active" id="login-form-link">비밀번호 수정</a>
											</div>
										</div>
										<hr>
									</div>
									<div class="panel-body">
										<div class="row">
											<div class="col-lg-12">
												<form id="pw-search-form" action="/member/changePassword" method="post" method="post"
													role="form" style="display: block;">
													<div class="form-group">
														<input type="text" name="user_id" id="user_id" tabindex="1" class="form-control"
															placeholder="사용자 ID" value="">
													</div>
													<div class="form-group">
														<input type="text" name="user_Name" id="user_Name" tabindex="2" class="form-control"
															placeholder="사용자 이름">
													</div>
													<div class="form-group">
														<input type="text" name="new_pw" id="new_pw" tabindex="2" class="form-control"
															placeholder="새로운 비밀번호">
													</div>
													<div class="form-group">
														<input type="text" name="new_pw_check" id="new_pw_check" tabindex="2" class="form-control"
															placeholder="비밀번호 확인">
													</div>
													<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
													<div class="form-group">
														<div class="row">
															<div class="col-sm-6 col-sm-offset-3">
																<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
																<input type="button" name="login-submit" id="modbtn" tabindex="4"
																	class="form-control btn btn-login" value="비밀번호 재설정">
															</div>
														</div>
													</div>
													<div class="form-group">
														<div class="row">
															<div class="col-lg-12">
																<div class="text-center">
																	<a href="/herethere/main" tabindex="5" class="forgot-password">메인화면으로 돌아가기</a>
																</div>
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
				<script type="text/javascript">

					// 해당 페이지의 경우 사용자가 수정하기 버튼을 누르면 버튼을 무효화 시킨 후 아래 메서드를 실행되게 함
					// 근데 이때 ajax를 포스트 방식으로 자료를 전달하는데 아래 ajax 부분을 보면 알겠지만, 보안용 토큰은 별도로 같이 전달되지 않음
					// 즉 포스트 방식으로 보안용 토큰 정보까지 한번에 넘기면 편한데 그러면 페이지가 넘어가게 됨...
					// 그래서 일부러 비동기 방식으로 페이지가 넘어가지 않고 이 안에서 회원 정보를 수정할때 반응이 나오도록 하려고하다보니
					// 보안용 토큰 정보를 ajax 방식으로 데이터 전송시 헤더에 실어서 보냄
					// 아래 메서드 말고 상단 meta 데이터 부분을 보면 토큰 정보가 있는 것을 확인

					$(function () {
						var token = $("meta[name='_csrf']").attr("content");
						var header = $("meta[name='_csrf_header']").attr("content");
						$(document).ajaxSend(function (e, xhr, options) {
							xhr.setRequestHeader(header, token);
						});
					});

					var btn = $("#modbtn");

					// ajax 방식으로 회원 비밀번호 수정하는 메서드
					// 페이지 내 input에 입력된 정보를 전달한 후 결과에 따라 동작이 둘로 나눠지게 만듦
					$(btn).on("click", function (e) {
						e.preventDefault();
						$.ajax({
							url: '/member/changePassword',
							type: 'Post',
							dataType: "json",
							data: {
								"user_id": $("#user_id").val(),
								"user_Name": $("#user_Name").val(),
								"new_pw": $("#new_pw").val(),
								"new_pw_check": $("#new_pw_check").val()
							},

							success: function (data) {
								if (data == false) {
									alert("현재 아이디 혹은 새로운 비밀번호가 맞지 않습니다");
								} else {
									alert("변경이 완료되었습니다.");
									location.href = "/herethere/main";
								}
							}
						}); //ajax 종료
					});
				</script>

				</html>