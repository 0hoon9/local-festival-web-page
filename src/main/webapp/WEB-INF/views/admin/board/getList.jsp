<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<<<<<<< HEAD
			<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
=======
		<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
		
			<!DOCTYPE html>
			<html>

			<head>
				<meta charset="UTF-8">
				<title>관리자페이지</title>
				
				<style type="text/css">
					#moveBtn {
					    position: fixed;
					    right: 3%;
					    bottom: 5%;
					}
					
					#board {
					    margin: auto;
					}
					
					#paging {
					    text-align: center;
					}
					
					#delBtn {
					    float: right;
					}
				</style>
				
				<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
				<!-- 합쳐지고 최소화된 최신 CSS -->
				<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
				<!-- 부가적인 테마 -->
				<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
				<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
				<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
				<!-- Board CSS -->
				<link rel="stylesheet" href="/resources/assets/css/board-style.css">
			</head>

			<body>
				<div id="root">
					<header id="header">
						<div>
							<%@ include file="../../include/header.jsp" %>
						</div>
					</header>
					<nav id="nav">
						<div>
							<%@ include file="../../include/nav.jsp" %>
						</div>
					</nav>

					<section id="container">
						<aside>
							<%@ include file="../../include/aside.jsp" %>
						</aside>
						<div id="container_box">
							<h3>게시글 목록</h3>
							<hr>
							<div id="board">
							
								<div id="delBtn">
									<button type="button" id="selectDeleteBtn" class="btn btn-link btn-sm">
										<span class="glyphicon glyphicon-trash" aria-hidden="true">삭제</span>
									</button>
>>>>>>> 19792d409f9274741829109a856233fa1b34e92a

				<!DOCTYPE html>
				<html>

				<head>
					<meta charset="UTF-8">
					<title>관리자페이지</title>

					<style type="text/css">
						#moveBtn {
							position: fixed;
							right: 3%;
							bottom: 5%;
						}

						#board {
							margin: auto;
						}

						#paging {
							text-align: center;
						}

						#delBtn {
							float: right;
						}
					</style>

					<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
					<!-- 합쳐지고 최소화된 최신 CSS -->
					<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
					<!-- 부가적인 테마 -->
					<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
					<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
					<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
					<!-- Board CSS -->
					<link rel="stylesheet" href="/resources/assets/css/board-style.css">
				</head>

				<body>
					<div id="root">
						<header id="header">
							<div>
								<%@ include file="../../include/header.jsp" %>
							</div>
						</header>
						<nav id="nav">
							<div>
								<%@ include file="../../include/nav.jsp" %>
							</div>
						</nav>

						<section id="container">
							<aside>
								<%@ include file="../../include/aside.jsp" %>
							</aside>
							<div id="container_box">
								<h3>게시글 목록</h3>
								<hr>
								<div id="board">

									<div id="delBtn">
										<button type="button" id="selectDeleteBtn" class="btn btn-link btn-sm">
											<span class="glyphicon glyphicon-trash" aria-hidden="true">삭제</span>
										</button>

										<script>
											//선택한 게시글 삭제여부 'y'로 변경		
											$("#selectDeleteBtn").click(function () {
												var header = '${_csrf.headerName}';
												var token = '${_csrf.token}';

												var checkArr = new Array();

												$("input[name=bnum]:checked").each(function () {
													checkArr.push($(this).attr("data-bnum"));
												});

												$.ajax({
													url: "/admin/getList/selectDelete",
													type: "post",
													data: { chbox: checkArr },
													beforeSend: function (xhr) {
														xhr.setRequestHeader(header, token);
													},
													success: function () {
														location.href = "/admin/board/getList";
													}
												})
											})
										</script>
									</div>

									<table class="table table-bordered table-hover">
										<thead>
											<tr class="active">
												<th><input type="checkbox" id="allCheck">번호</th>
												<th>지역</th>
												<th>제목</th>
												<th>작성자</th>
												<th>작성일</th>
												<th>수정일</th>
												<th>조회수</th>
											</tr>
										</thead>

										<div>
											<script>
												//게시글 전체선택
												$("#allCheck").click(function () {
													if ($("#allCheck").prop("checked")) {
														$("input[name=bnum]").prop("checked", true);
														//input태그의 name이 bnum인 태그들을 찾아서 checked옵션을 true로 정의
													} else {
														$("input[name=bnum]").prop("checked", false);
														//input태그의 name이 bnum인 태그들을 찾아서 checked옵션을 false로 정의
													}
												})
											</script>
										</div>

										<tbody>
											<c:forEach items="${list}" var="board">
												<tr>
													<td>
														<input type="checkbox" name="bnum" data-bnum="${board.bnum}">
														<c:out value="${board.bnum}" />
													</td>
													<td>
														<c:out value="${board.area}" />
													</td>
													<td>
														<fmt:formatDate pattern="yyyy-MM-dd" value="${board.regDate}" var="a" />
														<fmt:formatDate pattern="yyyy-MM-dd" value="${now}" var="b" />

														<%-- <a href='/admin/board/selectOne?bnum=<c:out value="${board.bnum}"/>'>
															<c:out value="${board.title}" />
															</a> --%>
															<a href="/admin/board/selectOne?bnum=${board.bnum}
														&page=${pageMaker.cri.page}&amount=${pageMaker.cri.amount}
														&type=${pageMaker.cri.type}&keyword=${pageMaker.cri.keyword}">
																${board.title}
															</a>

															<c:if test="${a eq b}">
																<span class="label label-primary">new</span>
															</c:if>
													</td>
													<td>
														<c:out value="${board.writer}"></c:out>
													</td>
													<td>
														<fmt:formatDate pattern="yyyy-MM-dd" value="${board.regDate}" />
													</td>
													<td>
														<fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate}" />
													</td>
													<td>
														<c:out value="${board.cnt}"></c:out>
													</td>
											</c:forEach>
										</tbody>

										<div>
											<script>
												//게시글 개별선택하면 allCheck의 체크해제
												$("input[name=bnum]").click(function () {
													$("#allCheck").prop("checked", false);
												})
											</script>
										</div>

									</table>

								</div>

								<div id="search">
									<select name="searchType">
										<option value="n" <c:out value="${cri.type == null ? 'selected' : ''}" />>-----
										</option>
										<option value="a" <c:out value="${cri.type eq 'a' ? 'selected' : ''}" />>지역
										</option>
										<option value="t" <c:out value="${cri.type eq 't' ? 'selected' : ''}" />>제목
										</option>
										<option value="c" <c:out value="${cri.type eq 'c' ? 'selected' : ''}" />>내용
										</option>
										<option value="tc" <c:out value="${cri.type eq 'tc' ? 'selected' : ''}" />>제목+내용
										</option>
									</select>

									<input type="text" id="keywordInput" />

									<button id="searchBtn" class="btn search-btn">검색</button>

									<script>
										$(function () {
											$('#searchBtn').click(function () {

												if ($("#search option:selected").val() == "n") {
													alert("검색조건을 선택해주세요")
													return false;
												}
												else if ($("#keywordInput").val() == "") {
													alert("검색내용을 입력해주세요")
													return false;
												}
												else {
													self.location = "getList"
														+ '${pageMaker.makeQuery(1)}'
														+ "&type="
														+ $("#search option:selected").val()
														+ "&keyword="
														+ encodeURIComponent($('#keywordInput').val());
												}

											});
										});   
									</script>
								</div> <!-- search -->

								<div id="paging">
									<ul class="pagination">
										<!-- 이전 버튼의 생성 여부를 확인하여 버튼을 보여줌 -->
										<c:if test="${pageMaker.prev}">
											<li>
												<a href='<c:url value="/admin/board/getList${pageMaker.makeSearch(pageMaker.startPage - 1)}"/>'
													aria-label="Previous">
													<span aria-hidden="true">&laquo;</span>
												</a>
											</li>
										</c:if>

										<!-- 페이지의 시작 번호와 끝 번호를 이용해 페이지 버튼을 보여줌 -->
										<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="pageNum">
											<li>
												<a href='<c:url value="/admin/board/getList${pageMaker.makeSearch(pageNum)}"/>'>${pageNum}
												</a>
											</li>
										</c:forEach>

<<<<<<< HEAD
										<!-- 다음 버튼의 생성 여부를 확인하여 버튼을 보여줌 -->
										<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
											<li>
												<a href='<c:url value="/admin/board/getList${pageMaker.makeSearch(pageMaker.endPage + 1)}"/>'
													aria-label="Next">
													<span aria-hidden="true">&raquo;</span>
												</a>
											</li>
										</c:if>
									</ul>
								</div>
							</div>
						</section>

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

						<footer id="footer">
							<div>
								<%@ include file="../../include/footer.jsp" %>
=======
									<div>
										<script>
											//게시글 개별선택하면 allCheck의 체크해제
											$("input[name=bnum]").click(function () {
												$("#allCheck").prop("checked", false);
											})
										</script>
									</div>
									
								</table>

							</div>
							
							<div id="paging">
								<ul class="pagination">
									<!-- 이전 버튼의 생성 여부를 확인하여 버튼을 보여줌 -->
									<c:if test="${pageMaker.prev}">
										<li>
											<a href='<c:url value="/admin/board/getList?page=${pageMaker.startPage-1}"/>'
												aria-label="Previous">
												<span aria-hidden="true">&laquo;</span>
											</a>
										</li>
									</c:if>

									<!-- 페이지의 시작 번호와 끝 번호를 이용해 페이지 버튼을 보여줌 -->
									<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="pageNum">
										<li>
											<a href='<c:url value="/admin/board/getList?page=${pageNum}"/>'>${pageNum}
											</a>
										</li>
									</c:forEach>

									<!-- 다음 버튼의 생성 여부를 확인하여 버튼을 보여줌 -->
									<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
										<li>
											<a href='<c:url value="/admin/board/getList?page=${pageMaker.endPage+1}"/>' aria-label="Next">
												<span aria-hidden="true">&raquo;</span>
											</a>
										</li>
									</c:if>
								</ul>
>>>>>>> 19792d409f9274741829109a856233fa1b34e92a
							</div>
						</footer>

					</div>

				</body>

				</html>