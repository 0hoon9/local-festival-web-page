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
								<li><a href="/herethere/local_fair">전체</a></li>
								<li><a href="/herethere/local_fair2">서울</a></li>
								<li><a href="/herethere/local_fair3">인천/대전/광주</a></li>
								<li><a href="/herethere/local_fair4">대구/울산/부산</a></li>
								<li><a href="/herethere/local_fair5">경기/강원</a></li>
								<li><a href="/herethere/local_fair6">충남/충북</a></li>
								<li><a href="/herethere/local_fair7">전남/전북</a></li>
								<li><a href="/herethere/local_fair8">경남/경북</a></li>
								<li><a href="/herethere/local_fair9">제주</a></li>
							</ul>
						</aside>

						<div id="board">
							<ul>

								<c:forEach items="${list}" var="list">
									
									<li>
										<div class="list">
											<div class="thumbImg">
												<a href="selectOne?bnum=${list.bnum}"><img src="${list.thumbImg}"></a>
											</div>
											<div class="title">
												<br><h4><b><a href="selectOne?bnum=${list.bnum}">${list.title}</a></b></h4>
												지역: ${list.area }<br>
												기간: ${list.startDate } ~ ${list.endDate }
											</div>
										</div>
									</li>
									
								</c:forEach>

							</ul>
					<!-- 게시물 검색 추가 -->
						<div>
							<div class="option">
							<form id="searchForm" action="/herethere/local_fair" method="get">
			<%@ include file="./include/search-form.jsp" %>
						</div>

						<div id="paging">
							<ul class="pagination">
								<!-- 이전 버튼의 생성 여부를 확인하여 버튼을 보여줌 -->
								<c:if test="${pageMaker.prev}">
									<li>
										<a href='<c:url value="/herethere/local_fair?page=${pageMaker.startPage-1}"/>'
											aria-label="Previous">
											<span aria-hidden="true">&laquo;</span>
										</a>
									</li>
								</c:if>

								<!-- 페이지의 시작 번호와 끝 번호를 이용해 페이지 버튼을 보여줌 -->
								<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="pageNum">
									<li>
										<a href='<c:url value="/herethere/local_fair?page=${pageNum}"/>'>${pageNum}
										</a>
									</li>
								</c:forEach>

								<!-- 다음 버튼의 생성 여부를 확인하여 버튼을 보여줌 -->
								<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
									<li>
										<a href='<c:url value="/herethere/local_fair?page=${pageMaker.endPage+1}"/>'
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