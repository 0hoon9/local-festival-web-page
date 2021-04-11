<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
			<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

			<!DOCTYPE html>
			<html>

			<head>
				<meta charset="UTF-8">

				<style type="text/css">
					#board {
						margin: auto;
						width: 1000px;
					}

					thead tr th {
						text-align: center;
					}
					
					tbody tr th {
						text-align: center;
					}
					
					div.btn-group{
						margin-left: 10px;
					}
					
					#divRec{
						float: right;
						margin-right: 30px;
					}
					
					div.countRec {
						display: inline-block;
						margin-left: 5px;
					}

					#img {
						width: 500px;
						height: auto;
					}
				</style>

				<title>축제글 조회</title>

				<script src="https://code.jquery.com/jquery-3.5.1.js"></script>

				<!-- 합쳐지고 최소화된 최신 CSS -->
				<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

				<!-- 부가적인 테마 -->
				<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

				<!-- Board CSS -->
				<link rel="stylesheet" href="/resources/assets/css/board-style.css">

				<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
				<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

				<script type="text/javascript">

					//url복사
					function copy(url) {
						var t = document.createElement("textarea");
						document.body.appendChild(t);
						t.value = url;
						t.select();
						document.execCommand('copy');
						document.body.removeChild(t);
					}

					//url공유
					$(document).ready(function () {
						$(".dropdown-menu li a").click(function () {
							shareAct(this);
						});
					});

					function shareAct(a) {
						var snsCode = $(a).attr('id');
						var cUrl = document.location.href;

						switch (snsCode) {
							case "twitter":
								cUrl = 'https://twitter.com/intent/tweet?text=공유하기:&url=' + cUrl;
								window.open(cUrl, '', 'width=500,height=500,scrollbars=yes');
								break;
							case "facebook":
								cUrl = 'http://www.facebook.com/sharer/sharer.php?u=' + cUrl;
								window.open(cUrl, '', 'width=500,height=500,scrollbars=yes');
								break;
							case "kakao":
								cUrl = 'https://story.kakao.com/share?url=' + cUrl;
								window.open(cUrl, '', 'width=500,height=500,scrollbars=yes');
								break;
						}
					}

					//게시글 추천수
					function countRec() {
						var bnum = ${ board.bnum }
						$.getJSON("/herethere/selectOne/countRec?bnum=" + bnum, function (count) {
							var cnt = "";
							$(count).each(function () {
								cnt += "<div>" + this + "</div>";
							})
							$(".countRec").html(cnt);
						})
					}
					
					// 시작과 동시에 게시글 로딩 및 페이징되는 숫자 로딩
					$(document).ready(function () {
						reply();
						reply_count();
					});
				</script>


			</head>

			<body>
				<div id="root">
					<header id="header">
						<div>
							<%@ include file="../include/header.jsp" %>
						</div>
					</header>

					<nav id="nav">
						<div>
							<%@ include file="../include/nav.jsp" %>
						</div>
					</nav>

					<section id="container">
						<aside>
							<ul class="board-aside">
						      <li><a href="/herethere/local_fair?page=${cri.page}&amount=${cri.amount}&type=${cri.type}&keyword=${cri.keyword}">목록보기</a></li>
						    </ul>
						</aside>

						<div id="container_box">

							<div id="board">

								<input type="hidden" name="bnum" id="bnum" value='${board.bnum}'>

								<table class="table table-bordered">

									<thead>
										<tr>
											
											<th colspan="2"><c:out value="${board.title}" />
											
												<!-- url공유 드롭다운 -->
												<div class="btn-group">
													<button type="button" id="btnUrl" class="dropdown-toggle" data-toggle="dropdown"
														aria-expanded="false">
														<span class="glyphicon glyphicon-link" aria-hidden="true"></span>
														<!-- <span class="caret"></span> 드롭다운 버튼 -->
													</button>
													<ul class="dropdown-menu" role="menu">
														<li><a id="copy">URL 복사</a></li>
														<li><a id="twitter">트위터 공유</a></li>
														<li><a id="facebook">페이스북 공유</a></li>
														<li><a id="kakao">카카오스토리 공유</a></li>
													</ul>
												</div>
												<script>
													$("a#copy").click(function () {
														var url = document.location.href;
														copy(url);
														alert("URL이 복사되었습니다")
													})
												</script>

												<!-- 추천버튼 -->
												<div id="divRec">
													<sec:authorize access="isAnonymous()">
														<button type="button" id="btnRecommendAnonymous">
															<span class="glyphicon glyphicon-thumbs-up" aria-hidden="true"></span>
														</button>
                                					</sec:authorize>
												
													<sec:authorize access="isAuthenticated()">
														<button type="button" id="btnRecommendAuthenticated">
															<span class="glyphicon glyphicon-thumbs-up" aria-hidden="true"></span>
														</button>
														<input type="hidden" id="user_id" value="<sec:authentication property='principal.username' />">
                                					</sec:authorize>
													
													<!-- 게시글 추천수 -->
													<div class="countRec">
														<script>countRec();</script>
													</div>
													
													<!-- 즐겨찾기버튼 로그인 시 볼 수 있음-->
													<span>
														<sec:authorize access="isAuthenticated()">
														<button class="favorite">즐겨찾기</button>
														</sec:authorize>
													</span>
												</div>
												<!-- 게시글 추천 -->
												<script>
													$("#btnRecommendAnonymous").click(function(){
														alert("로그인 후 이용해주세요");
														return false;
													});
												
													$("#btnRecommendAuthenticated").click(function () {
														var header = '${_csrf.headerName}'; 
														var token = '${_csrf.token}';
														
														var bnum = $("#bnum").val();
														var user_id = $("#user_id").val();

														var data = { bnum: bnum, user_id: user_id };
																												
														$.ajax({
															url: "/herethere/selectOne/insertRec",
															type: "post",
															data: data,
															beforeSend: function(xhr){
																xhr.setRequestHeader(header, token);
															},
															success: function (str) {
																alert(str);
																countRec();
															}
														});
													});
												</script>
												
												<!-- 즐겨찾기 저장을 위한 메서드 -->
												<!-- 즐겨찾기 클릭시 정보 저장 -->
												<script>
												$(".favorite").click(function (e) {
													e.preventDefault();
													var header = '${_csrf.headerName}';
													var token = '${_csrf.token}';
													$.ajax({
														url: "/favorite/register",
														type: "post",
														dataType: "text",
														data: {
															user_id: $('#user_id').val(),
															bnum: ${board.bnum}
															},
														beforeSend: function(xhr){
															xhr.setRequestHeader(header, token);
															},
														success : function(data) {
															if(data=="fail"){
																alert("이미 즐겨찾기 되있습니다.");
															} else{
																alert("즐겨찾기가 성공했습니다.");
															}
															},
														}); // end of ajax
													}); // end of favorite 클릭
													
												</script>
												
												<script>
												<!-- 댓글 생성 함수 -->
												function reply(nowpage_data) {

													var bnum = ${board.bnum};
													
													var page = nowpage_data; // 페이징 및 댓글 로딩을 위한 현재 페이지 데이터 전송 받음
													
													if(page == null||page == ""){ // 만약 페이지 정보가 없으면 1로 디폴트 설정
														page = 1;
													}
													$('.page').removeAttr('style'); 
													// 댓글 로딩시 페이징 숫자에 적용된 스타일 해제
													// 페이지 클릭시 스타일 나타나도록
													
													// 댓글 로딩을 위한 자료 받아옴
													// 글 번호, 페이지 번호 전달함
													$.getJSON("/reply/read_paging?bnum="+bnum+"&page="+page, function (reply) {
														var reply_c="";
														var date = "";
														var year= "";
														var month = "";
														var day = "";
														var hour = "";
														var minute = "";
														var second = "";
														// 이렇게 변수가 많은 이유는 json으로 데이터를 받아옴
														// 근데 날짜 데이터가 유닉스 타임 기준으로 숫자로 옴
														// 해당 숫자를 나라로 변경해서 표현해주려고 날짜 관련 변수 선언
														
														// 이건 뭐냐면 현재 클릭된 페이지의 정보를 히든으로 저장
														// 교재는 뭐 criteria 쓰고 어쩌고 하는데
														// 해당 로직은 그렇게 저장했다 불러왔다 귀찮아서 jsp 내에서 다 처리함
														// 현재 페이지를 html 히든 스타일로 저장함
														// 댓글 삭제, 댓글 로딩, 페이징 할 때 매번 저장해줌
														var now;
														now += "<span class='now_data'>"+page+"<span>";
														$("#nowp").html(now);
														
														$(reply).each(function (i) {
															date = new Date(reply[i].replyDate);
															year = date.getFullYear()
															month = (date.getMonth()+1);
															day = date.getDate();
															hour = date.getHours();
															minute = date.getMinutes();
															second = date.getSeconds();
															
															// 댓글 로딩을 위한 부분
															reply_c += "<tr id="+reply[i].rnum+">"
															reply_c += "<td>"+"사용자: "+reply[i].replyer+"</td>";
															reply_c += "<td>"+"댓글번호: "+reply[i].rnum+"</td>";
															reply_c += "<td>"+"등록일자: "+year+" . "+month+" . "+day+" ("+hour+":"+minute+":"+second+")"+"</td>";
															reply_c += "<td>"
															reply_c += '<sec:authorize access="isAnonymous()">';
															reply_c += "<div style='text-align:center;'><button type='button' class='fakeDelBtn'>X</button><div>";
															reply_c += '</sec:authorize>';
															reply_c += '<sec:authorize access="hasRole(\'ROLE_MEMBER\')">';
															reply_c += "<div style='text-align:center;'><button type='button' value='"+reply[i].rnum+"' id='"+reply[i].rnum+"' class='delBtn'>X</button><div>";
															reply_c += '</sec:authorize>';
															reply_c += '<sec:authorize access="hasRole(\'ROLE_ADMIN\')">';
															reply_c += "<div style='text-align:center;'><button type='button' value='"+reply[i].rnum+"' id='"+reply[i].rnum+"' class='adminDelBtn'>X</button><div>";
															reply_c += '</sec:authorize>';
															reply_c += "</td>";
															reply_c += "</tr>"
															reply_c += "<tr>"
															reply_c += "<td colspan='4'>"+reply[i].reply;
															reply_c += "</tr>"

														})
														$("#reply").html(reply_c); // 문자열에 저장된 내용을 테이블에 보여줌 
														
														// 해당 선택 페이지에 스타일 적용
														// 선택한 페이지 색상 및 크기 변경
														var temp = 'p'+page
														$('#'+temp).css({"color": 'red', 'font-size': '20px'});

													})
												};
												</script>
												
												<script>
												<!-- 댓글 아래 페이징 번호 생성 함수 -->
												// 사실 이때 처음 혼자 만든 로직이라 내용이 김
												// 페이징 처리인데 5가지 상황에 맞춰서 각각 내용에 맞게 페이징처리해줌
												// 실제로는 3개면 가능한 상황인데 일단 몰라서 상황에 맞는 페이징을 전부 처리함
												
												// 조건 1. 숫자 입력이 없을 때와 있을 때(숫자 입력 없는 건 초기 진입했을 때)
												// 조건 1-1. 숫자 없을 때 5이하(페이지가 5개 이하)면 숫자만 출력  ex) 1 2 3 4 5
												// 조건 1-2. 숫자 없을 때 5이상(페이지가 5개 이상)이면 숫자+next화살표까지 출력   ex) 1 2 3 4 5 ▷ 
												// 조건 2. 숫자 입력 있을 때(초기 진입 이외에 화면 눌렀을 때)
												// 조건 2-1. next, prev 눌렀는데 페이징 숫자가 5이상 일 때 prev와 next 화살표 둘다 필요할 때  ex) ◁ 6 7 8 9 10 ▷
												// 조건 2-2. next, prev 눌렀는데 페이징 숫자가 5이하 일 때  prev만 필요한 경우  ex) ◁ 11 12 13 14
												// 조건 2-3. next, prev 눌렀는데 페이징 숫자가 5이하 일 때  prev만 필요한 경우  ex) ◁ 11 12 13 14
												// 조건 2-4. 댓글 페이지를 눌러서 댓글 페이지 정보가 입력됐는데 페이지가 5이하일 때  ex) 1 2 3 4 5
												
												// 위와 같이 했는데, 나중에 보니까 모듈처럼 페이지를 나눠서 하게 됨
												// 추후에 즐겨찾기 페이징에선 조건 분기 prev, next, 숫자 3개로 나뉨
												function reply_count(data) {
													var bnum = ${board.bnum};
													
													// 숫자 입력이 없을 때
													if(typeof data == "undefined"){
														
													$.getJSON("/reply/reply_count?bnum="+bnum, function (count) {
														var rpCnt = "";
														/* console.log("현재 페이징에 필요한 출력 숫자: "+count); */
															
														// 페이징 처리할 숫자가 5보다 작을 때
														if(count <= 5){
															$(count).each(function (i) {
																rpCnt += "<tr style='text-align: center'>";
																rpCnt += "<td colspan='3'>";
																
																for(var i = 1; i <= count; i++){
																	rpCnt += "<a href='' class='page' value='"+i+"' id='p"+i+"'>"+i+"</a> ";
																	}
																
																rpCnt += "</td>";
																rpCnt += "</tr>";
																})
																$("#reply_c").html(rpCnt);
															} // end of  페이징처리 할 숫자가 5보다 작을 때
															
														// 페이징 처리할 숫자가 5보다 클 때
														if(count > 5){
															$(count).each(function (i) {
																rpCnt += "<tr style='text-align: center'>";
																rpCnt += "<td colspan='3'>";
																for(var i = 1; i <= 5; i++){
																	rpCnt += "<a href='' class='page' value='"+i+"' id='p"+i+"'>"+i+"</a> ";
																	}
																rpCnt += "<a href='' class='next' value='"+(count-(count-5))+"'>▷</a> ";
																rpCnt += "</td>";
																rpCnt += "</tr>";
																})
																$("#reply_c").html(rpCnt);
															} // end of  페이징처리 할 숫자가 5보다 클때
														
													}); // end of "/reply/reply_count"로 게시물 번호 전달해서 페이징에 필요한 숫자 전달 제이슨으로 전달 받은 후 처리
													
													}; // end of 입력 값이 없을 때 댓글 페이징을 위한 숫자 출력
													
													// 숫자 입력이 있을 때
													if(typeof data != "undefined"){
														
														/* console.log("data값: "+ data) */
														$.getJSON("/reply/reply_count?bnum="+bnum, function (count) {var rpCnt = "";
															/* console.log("count값 : "+count); */
															
															// prev 또는 Next 버튼을 눌렀을 때 페이징 처리할 숫자가 5를 초과할 때
															if((count>5) && ((count-data) > 5)){
																$(count).each(function (i) {
																	rpCnt += "<tr style='text-align: center'>";
																	rpCnt += "<td colspan='3'>";
																	rpCnt += data > 0 ? "<a href='' class='prev' value='"+((data)-5)+"'>◁</a> " : ""
																	for(var i = data; i < data+5; i++){
																		rpCnt += "<a href='' class='page' value='"+(i+1)+"' id='p"+(i+1)+"'>"+(i+1)+"</a> ";
																		}
																	rpCnt += "<a href='' class='next' value='"+(data+5)+"'>▷</a> ";
																	rpCnt += "</td>";
																	rpCnt += "</tr>";
																	})
																	$("#reply_c").html(rpCnt);
																} // end of 페이징 처리할 숫자가 5보다 클때
															
															// NEXT 버튼 누르거나 댓글을 추가 할 때 페이징 처리할 숫자가 5이하일 때
															if((count>5) && ((count-data) <= 5)){																
																$(count).each(function (i) {
																	rpCnt += "<tr style='text-align: center'>";
																	rpCnt += "<td colspan='3'>";
																	rpCnt += "<a href='' class='prev' value='"+((data)-5)+"'>◁</a> ";
																	for(var i = data; i < (data+(count-data)); i++){
																		rpCnt += "<a href='' class='page' value='"+(i+1)+"' id='p"+(i+1)+"'>"+(i+1)+"</a> ";
																		}
																	rpCnt += "</td>";
																	rpCnt += "</tr>";
																	})
																	$("#reply_c").html(rpCnt);
																} // end of  페이징처리 할 숫자가 5보다 작을 때
															
															// 전체 구현 페이지가 5 이하일 때 댓글을 추가할 때 
															if(count <= 5){
																$(count).each(function(i){
																	rpCnt += "<tr style='text-align: center'>";
																	rpCnt += "<td colspan='3'>";
																	for(var i = data; i < (data+(count-data)); i++){
																		rpCnt += "<a href='' class='page' value='"+(i+1)+"' id='p"+(i+1)+"'>"+(i+1)+"</a> ";
																		}
																	rpCnt += "</td>";
																	rpCnt += "</tr>";
																	})
																	$("#reply_c").html(rpCnt);
																}
													});
													}
													
												}; // end of 페이징 번호 생성 함수 
												
												</script>
												
												<div></div>

											</th>
										</tr>
									</thead>

									<tbody>

										<tr>
											<th><label>지역</label></th>
											<td>${board.area}</td>
										</tr>
										
										<tr>
											<th><label>기간</label></th>
											<td>${board.startDate} ~ ${board.endDate}</td>
										</tr>

										<%-- <tr>
											<th><label>제목</label></th>
											<td colspan="3">
												<c:out value="${board.title}" />
											</td>
										</tr> --%>

										<tr>
											<th><label>내용</label></th>
											<td>${board.content}</td>
										</tr>

									</tbody>

								</table>
								
								<!-- 댓글 테이블 -->
								<table class="table table-bordered" id="reply">
								</table>
								<table class="table table-bordered" id="reply_c">
								</table>
								<textarea id="reply_w" style="resize: none;" cols="122" rows="5" placeholder="댓글을 입력해주세요"></textarea>
								<div style="display: none" id="nowp"></div>
								
								
								<!-- 비로그인시 경고 띄우는 버튼에만 접근 가능 -->
								<sec:authorize access="isAnonymous()">
								<br><div style="text-align: right"><input id="anony_replyBtn"type="submit" value="등록"></div>
								</sec:authorize>
								
								<!-- 로그인시 댓글 등록 가능한 버튼에 접근 가능 -->
								<sec:authorize access="isAuthenticated()">
								<input id="replyer" type="hidden" value="<sec:authentication property="principal.member.user_id"/>">
								<br><div style="text-align: right"><input id="auth_replyBtn"type="submit" value="등록"></div>
								</sec:authorize>
								
								<script type="text/javascript">
								
								<!-- 비 로그인으로 댓글 버튼 접근시 경고 띄움 -->
								$("#anony_replyBtn").click(function(){
									alert("로그인 후 이용해주세요");
									return false;
									});
								
								<!-- 로그인으로 댓글 버튼 접근시 등록 진행 -->
								$("#auth_replyBtn").click(function (e) {
									e.preventDefault();
									var header = '${_csrf.headerName}';
									var token = '${_csrf.token}';
									$.ajax({
										url: "/reply/write",
										type: "post",
										dataType: "json",
										data: {
											bnum: ${board.bnum},
											reply: $("#reply_w").val(),
											replyer: $("#replyer").val(),
											},
										beforeSend: function(xhr){
											xhr.setRequestHeader(header, token);
											},
										success: function (data) {
											if(data != null){
												alert("댓글 등록이 성공했습니다");
												var temp = data;
												// 댓글 등록 이후에 페이징을 위해서 처리해줘야 함
												// 댓글 등록, 삭제시 페이지 변경이 되는 경우가 있어서 처리해줘야 함
												if((data%5)==0&&(data/5)>=1){
													data = data - 5;
													}
												else{
													data = data-(data%5);
													}
												reply_count(data);
												reply(temp);
												}
											}
											});
									});
								</script>
								
								<!-- 로그인 없이 댓글 삭제 버튼을 누를 경우 실행됨 -->
								<script>
								$(document).on("click", ".fakeDelBtn", function(){
									alert("로그인 후 삭제가 가능합니다");
								})
								</script>
								
								<script>
								// 운영자용 삭제 버튼 적용 메서드
								$(document).on("click", ".adminDelBtn", function(){
									var header = '${_csrf.headerName}';
									var token = '${_csrf.token}';
									$.ajax({
										url: "/reply/admin_delete",
										type: "post",
										dataType: "json",
										data: {
											rnum: $(this).attr('id'),
											nowpage: $(".now_data").text(),
											bnum: ${board.bnum},
											},
										beforeSend: function(xhr){
											xhr.setRequestHeader(header, token);
											},
										success: function (data) {
											alert("댓글이 삭제됐습니다.");
											if(data[1] != null){
												var temp = data[1];
												var paging = data[1];
												if((paging%5)==0&&(paging/5)>=1){
													paging = paging - 5;
													}
												else{
													paging = paging-(paging%5);
													}
												reply_count(paging);
												reply(temp);
												}
											}
											});
								});
								
								</script>
								
								<script type="text/javascript">
								<!-- 댓글 삭제버튼 누를 경우 실행됨 -->
								<!-- 일반 사용자용임 -->
								$(document).on("click",".delBtn",function(){
									var header = '${_csrf.headerName}';
									var token = '${_csrf.token}';
									$.ajax({
										url: "/reply/delete",
										type: "post",
										dataType: "json",
										data: {
											rnum: $(this).attr('id'),
											nowpage: $(".now_data").text(),
											bnum: ${board.bnum},
											login_user: $('#replyer').val()
											},
										beforeSend: function(xhr){
											xhr.setRequestHeader(header, token);
											},
										success: function (data) {
											if(data[0] == "success"){
												alert("댓글이 삭제됐습니다.");
											} else{
												alert("본인이 등록한 댓글만 삭제 가능합니다.");
											}
											
											if(data[1] != null){
												var temp = data[1];
												var paging = data[1];
												if((paging%5)==0&&(paging/5)>=1){
													paging = paging - 5;
													}
												else{
													paging = paging-(paging%5);
													}
												reply_count(paging);
												reply(temp);
												}
											}
											});
								});
								
								<!-- 페이징 숫자를 누르면 해당 숫자에 맞는 댓글 페이지 새로 갱신 -->
								$(document).on("click", ".page", function(e){
									e.preventDefault();
									var header = '${_csrf.headerName}';
									var token = '${_csrf.token}';
									$.ajax({
										url: "/reply/nowpage",
										type: "get",
										dataType: "json",
										data: {
											nowpage: $(this).attr('value')
											},
										beforeSend: function(xhr){
											xhr.setRequestHeader(header, token);
											},
										success: function (data) {
											if(data != null){
												/* console.log("전달 받은 값(페이지수): "+data); */
												var now;
												// 페이징을 위해서 누를 때마다 매번 페이징 번호를 html에 저장
												now += "<span class='now_data'>"+data+"<span>";
												$("#nowp").html(now);
												reply(data);												
												}
											}
											});
								});
								
								<!-- next를 누르면 해당 숫자에 맞는 댓글 페이지 새로 갱신 -->
								$(document).on("click", ".next", function(e){
									e.preventDefault();
									var header = '${_csrf.headerName}';
									var token = '${_csrf.token}';
									$.ajax({
										url: "/reply/nowpage",
										type: "get",
										dataType: "json",
										data: {
											nowpage: $(this).attr('value')
											},
										beforeSend: function(xhr){
											xhr.setRequestHeader(header, token);
											},
										success: function (data) {
											if(data != null){
												/* console.log("전달 받은 값(페이지수): "+data); */
												var now;
												// 페이징을 위해서 누를 때마다 매번 페이징 번호를 html에 저장
												now += "<span class='now_data'>"+data+"<span>";
												$("#nowp").html(now);
												reply_count(data);
												reply(data+1);
												}
											}
											});
								});
								
								<!-- prev를 누르면 해당 숫자에 맞는 댓글 페이지 새로 갱신 -->
								$(document).on("click", ".prev", function(e){
									e.preventDefault();
									var header = '${_csrf.headerName}';
									var token = '${_csrf.token}';
									$.ajax({
										url: "/reply/nowpage",
										type: "get",
										dataType: "json",
										data: {
											nowpage: $(this).attr('value')
											},
										beforeSend: function(xhr){
											xhr.setRequestHeader(header, token);
											},
										success: function (data) {
											if(data != null){
												/* console.log("전달 받은 값(페이지수): "+data); */
												var now;
												// 페이징을 위해서 누를 때마다 매번 페이징 번호를 html에 저장
												now += "<span class='now_data'>"+data+"<span>";
												$("#nowp").html(now);
												reply_count(data);
												reply(data+5);
												}
											}
											});
								});
								</script>

							</div>

							<hr>

						</div>
					</section>

					<footer id="footer">
						<div>
							<%@ include file="../include/footer.jsp" %>
						</div>
					</footer>

				</div>

			</body>

			</html>