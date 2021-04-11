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
													<span>ID</span><input id="user_id" type="text" tabindex="1" class="form-control" readonly
														value=<sec:authentication property="principal.member.user_id" /> >
												</div>
												<div class="form-group">
													<span>이름</span><input type="text" tabindex="2" class="form-control" readonly
														value=<sec:authentication property="principal.member.user_Name" />>
												</div>
												<br>
												<h4 style="text-align: center"> 즐겨찾기 목록 </h4>
												<table class="table table-bordered" id="favo">
												</table>
												<table class="table table-bordered" id="paging">
												</table>
												<!-- <div id='nowPage' style='display: none'>나우페이지</div> -->
												<div id='nowPage' style="display: none">나우페이지</div>
												
												<script type="text/javascript">
												// 즐겨찾기 만드는 함수
												// 댓글 만드는 함수와 달리 훨씬 합리적으로 만든 로직 길이도 짧아짐
												// 기존 댓글 만드는 로직은 상황에 맞춰 하나씩 다 만들었는데
												// 어떤 상황이든 데이터 받아서 거기에 맞게 알아서 만들어지도록 최대한 코드 절약함
												// 기본적으로 댓글 만드는 로직과 마찬가지로 페이지 정보는 jsp에서만 최대한 다루게 만들어둠
												
												/* 즐겨찾기 만드는 함수 */
												function favoriteRead(data) {
													var userId= $('#user_id').val();
													
													// 만약 입력된 페이지가 없으면(진입시) 1 자동 디폴트 설정
													if(data == 0){
														data = 1;
													}
													
													// 페이지 눌렀을 때 버튼에 불들어오던거 해제함
													// 페이지 로딩하면서 어차피 해당 페이지 갱신되기 때문에 여기서 해제하고 로딩 함수 후반부에 스타일 적용다시함
													$('.page').removeAttr('style');
													
													// 페이징을 위해서 전체 글의 갯수를 가져와야 함
													// 그래서 아이디 전달해서 json으로 페이징에 필요한 글 갯수 전달 받음
													$.getJSON("/favorite/count?user_id="+userId, function (favorite) {
														$('.paging').removeAttr('style');
														
														var userId= $('#user_id').val();
														var print = ""; // 출력을 위한 변수
														var pageNum = data; // 현재 선택된 페이지
														var allReply; // 전체 글 숫자 선언

														// for문 시작 번호
														var startNum = 1;
														// for문 끝 번호
														var endNum = 5;
														
														allReply = favorite; // 메서드로 전달받은 숫자 입력
														
														console.log("아이디 :"+userId);
														
														// 아이디를 입력해서 즐겨찾기 정보 받아옴
														$.getJSON("/favorite/read?user_id="+userId, function (favorite) {
															print += "<tr>";
															print += "<td>번호</td>";
															print += "<td>이름</td>";
															print += "<td>지역</td>";
															print += "<td>삭제</td>";
															print += "</tr>";
															
															// 한 페이지 당 글이 최대 5개가 나와야 함
															// 즉 전체 글 숫자가 100개면 한 페이지당 5개씩 20개 페이지가 만들어져야 함
															// 일일이 다 처리할 수 없으므로 로직을 통해서 만들어줌
															
															if(allReply <= pageNum*5){
																startNum = ((pageNum-1)*5);
																endNum = allReply-1;	
															};
															
															if(allReply > pageNum*5){
																startNum = (pageNum*5)-5;
																endNum = (pageNum*5)-1;
															};
															
															console.log("즐겨찾기 자료: "+favorite);
															
															for(i = startNum; i <= endNum; i++){
																print += "<tr>";
																print += "<td>"+(i+1)+"</td>";
																print += "<td>"+favorite[i].title+"</td>";
																print += "<td>"+favorite[i].area+"</td>";
																print += "<td><button class='delBtn' id="+favorite[i].bnum+">x</button></td>";
																print += "</tr>";
															};
															$('#favo').html(print);

															// 페이징용 클릭한 숫자에 색상 바뀌고 글자 크기 변경
															$('#'+data).css({"color": 'red', 'font-size': '20px'});
														}); // end of getJson
														});
												}; // end of 함수 
												
												</script>
												
												<!-- 페이징 만드는 함수 -->
												<script type="text/javascript">
												
												// 데이터가 입력되지 않으면 1을 디폴트로 입력
												function favoritePaging(data) {
													if(data == 0){
														data = 1;
													}
													
													var userId= $('#user_id').val();
													
													// 페이징을 위한 전체 즐겨찾기 갯수 가져옴
													$.getJSON("/favorite/count?user_id="+userId, function (favorite) {
														var print = "";
														var pageNum = data; // 현재 선택된 페이지
														var allReply = favorite; // 현재 페이지에 등록된 전체 즐겨찾기 수
														
														// 현재 클릭된 페이지 저장을 위해 히든으로 HTML에 저장해둠
														var now;
														now += "<span class='now_data' value='"+pageNum+"'>"+pageNum+"<span>";
														$("#nowPage").html(now);
														
														// for문 시작 번호
														var startNum;
														// for문 끝 번호
														var endNum;
													
														endNum = Math.ceil(pageNum/5)*5; // 끝 번호 디폴트 설정
														startNum = endNum - 4; // 끝 번호에서 4를 빼서 해당 페이지 첫 번호 디폴트 설정
													
														
														// startNum, endNum을 전체 페이지숫자에 맞춰서 변경해줌  
														
														// 전체 페이지보다 현재 페이지 *5가 더 클 때
														if((endNum) * 5 > allReply){
															endNum = Math.ceil(allReply/5);
														}
													
														// 전체 페이지가 현재 페이지수*5보다 작을 때
														if(allReply <= pageNum*5){
															endNum = Math.ceil(allReply/5);
														};
															
														print += "<tr>";
														print += "<td>";
														// 조건에 맞으면 prev 버튼 생성
														if(startNum != 1){
															print += "<a href='' id='"+(startNum-1)+"' class='paging' value='"+(startNum-1)+"'>◁</a>";
														}
														for(i = startNum; i <= endNum; i++){
															print += "<a href='' id='"+i+"' class='paging' value='"+i+"'> "+i+" </a>";
														};
														// 조건에 맞으면 next 버튼 생성
														if(endNum * 5 < allReply){
															print += "<a href='' id='"+(endNum+1)+"' class='paging' value='"+(endNum+1)+"'>▷</a>";
												     	}
														print += "</td>";
														print += "</tr>";
														$('#paging').html(print);
														});
												}; // end of 함수 
												
												</script>
												
												<script>
												$(document).ready(function () {
													// 처음에 시작하면 1을 입력값으로 줘서 오류 막아줌
													favoriteRead(1);
													favoritePaging(1);
												});
												</script>
												
												<script type="text/javascript">
												// 즐겨찾기 삭제 버튼 누를 경우 실행됨
												// 삭제를 위해 누르지만 삭제 정보와 페이징을 위한 페이지 정보 같이 전달함
												$(document).on("click", ".delBtn", function(e){
													e.preventDefault();
													var header = '${_csrf.headerName}';
													var token = '${_csrf.token}';
													
													console.log($('.now_data').text());
													$.ajax({
														url: "/favorite/delete",
														type: "post",
														dataType: "json",
														data: {
															user_id : $('#user_id').val(),	
															bnum: $(this).attr('id'),
															nowpage: $('.now_data').text(),
															},
														beforeSend: function(xhr){
															xhr.setRequestHeader(header, token);
															},
														success: function (data) {
															console.log("삭제하고 난 뒤 페이징 번호 : "+data);
															favoriteRead(data); // 페이지 번호 전달해서 댓글 새로 로딩
															favoritePaging(data); // 페이지 번호 전달해서 페이징 새로 로딩
															}
														});
													});
												</script>
												 
												<script type="text/javascript">
												// 페이지 번호 누를 경우 댓글 새로 로딩하는 메서드
												// 누를 때마다 새로 페이지를 전달해서 로딩해야하므로 즐겨찾기 정보와 페이지 정보 같이 전달
												$(document).on("click", ".paging", function(e){
													e.preventDefault();
													var header = '${_csrf.headerName}';
													var token = '${_csrf.token}';
													$.ajax({
														url: "/favorite/route",
														type: "get",
														dataType: "json",
														data: {
															user_id : $('#user_id').val(),	
															nowpage: $(this).attr('id')
															},
														beforeSend: function(xhr){
															xhr.setRequestHeader(header, token);
															},
														success: function (data) {
															console.log("페이징을 통해 전달 받은 데이터: "+data)
															favoriteRead(data[1]); // 전달 받은 데이터 전달해서 새로 댓글 로딩
															favoritePaging(data[1]); // 전달 받은 데이터 전달해서 페이징 새로 로딩
															}
														});
													});
												</script>
												
												
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