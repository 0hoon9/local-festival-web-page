<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
			<!DOCTYPE html>
			<html>

			<head>
				<meta charset="UTF-8">

				<style type="text/css">
					div#board{
						text-align: center;
					}
					div#board ul li {
						display: inline-block;
						margin: 10px;
					}
					
					div.list{
						width: 300px; height: 330px;
						border: 1px solid #c2c5db;
						padding: 10px;
					}
					div#board div.thumbImg img {
						height: 180px;
					}
					div#board div.title {
						padding: 10px 0;
						text-align: center;
					}
					#paging {
						text-align: center;
					}
				</style>

				<title>지역별 축제</title>

				<script src="https://code.jquery.com/jquery-3.5.1.js"></script>

				<!-- 합쳐지고 최소화된 최신 CSS -->
				<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

				<!-- 부가적인 테마 -->
				<link rel="stylesheet"
					href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

				<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
				<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

				<link rel="stylesheet" href="/resources/assets/css/board-style.css">
								<link rel="stylesheet" href="/resources/assets/css/local-fair.css">

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
								<li><a href="/herethere/local_fair">전체보기</a></li>
								<li>
									<div id="array">
										<select name="area">
											<option>서울</option>
											<option>부산</option>
											<option>대구</option>
											<option>인천</option>
											<option>광주</option>
											<option>대전</option>
											<option>울산</option>
											<option>경기</option>
											<option>강원</option>
											<option>충청</option>
											<option>전라</option>
											<option>경상</option>
											<option>제주</option>
										</select>
									</div>
									<button id="searchBtn" class="btn search-btn">검색</button>
									<script type="text/javascript">
										$("#searchBtn").click(function(){
											self.location = "local_fair"
												+ '${pageMaker.makeQuery(1)}'
												+ "&type=A"
												+ "&keyword="
												+ encodeURIComponent($("select option:selected").val());
										})
									</script>
								</li>
							</ul>
						</aside>
												
						<div id="board">
							<ul>
								<c:forEach items="${list}" var="list">
									<li>
										<div class="list">
											<div class="thumbImg">
												<a href="/herethere/selectOne?bnum=${list.bnum}
													&page=${pageMaker.cri.page}
													&amount=${pageMaker.cri.amount}
													&type=${pageMaker.cri.type}
													&keyword=${pageMaker.cri.keyword}">
													<img src="${list.thumbImg}"></a>
											</div>
											<div class="title">
												<br><h4><b><a href="/herethere/selectOne?bnum=${list.bnum}
																&page=${pageMaker.cri.page}
																&amount=${pageMaker.cri.amount}
																&type=${pageMaker.cri.type}
																&keyword=${pageMaker.cri.keyword}">
																${list.title}</a></b></h4>
												지역: ${list.area}<br>
												기간: ${list.startDate} ~ ${list.endDate}
											</div>
										</div>
									</li>
								</c:forEach>
							</ul>
						</div>
						
						<div>
							<div class="option">
							<form id="searchForm" action="/herethere/local_fair" method="get">
								<%@ include file="./include/search-form.jsp" %>
						</div>
						
						<script>
							let searchForm = $("#searchForm");
							$("#searchForm button").on("click", function (e) {
								if (!searchForm.find("option:selected").val()) {
									alert("검색종류를 선택하세요");
									return false;
								}
								if (!searchForm.find("input[name='keyword']").val()) {
									alert("키워드를 입력하세요");
									return false;
								}
								searchForm.find("input[name='pageNum']").val("1"); //검색결과는 항상 1페이지로
								e.preventDefault(); //이벤트 중단(페이지 새로고침 중단) 
								searchForm.submit();
							})
						</script>						

						<div id="paging">
							<ul class="pagination">
								<!-- 이전 버튼의 생성 여부를 확인하여 버튼을 보여줌 -->
								<c:if test="${pageMaker.prev}">
									<li>
										<a href='<c:url value="/herethere/local_fair${pageMaker.makeSearch(pageMaker.startPage - 1)}"/>'
											aria-label="Previous">
											<span aria-hidden="true">&laquo;</span>
										</a>
									</li>
								</c:if>

								<!-- 페이지의 시작 번호와 끝 번호를 이용해 페이지 버튼을 보여줌 -->
								<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="pageNum">
									<li>
										<a href='<c:url value="/herethere/local_fair${pageMaker.makeSearch(pageNum)}"/>'>${pageNum}
										</a>
									</li>
								</c:forEach>

								<!-- 다음 버튼의 생성 여부를 확인하여 버튼을 보여줌 -->
								<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
									<li>
										<a href='<c:url value="/herethere/local_fair${pageMaker.makeSearch(pageMaker.endPage + 1)}"/>'
											aria-label="Next">
											<span aria-hidden="true">&raquo;</span>
										</a>
									</li>
								</c:if>
							</ul>
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