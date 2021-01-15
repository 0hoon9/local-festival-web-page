<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<style type="text/css">
 #board {margin: auto; width: 850px;}
 #paging {text-align: center;}
 </style>

<title>관리자 메인페이지</title>

<script src="https://code.jquery.com/jquery-3.5.1.js"></script>

<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

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
			<h3>회원 정보</h3>
			<hr>
			
				<div id="board">
					<table class="table table-bordered table-hover">
						<thead>
							<tr class="active">
								<th>아이디</th>
								<th>비밀번호</th>
								<th>이름</th>
								<th>가입일</th>
							</tr>
						</thead>

						<tbody>
							<c:forEach items="${member}" var="member">
								<tr>
									<td>
										<c:out value="${member.user_id}" />
									</td>
									<td>
										<c:out value="${member.user_pw}" />
									</td>
									<td>
										<c:out value="${member.user_Name}" />
									</td>
									<td>
										<fmt:formatDate pattern="yyyy-MM-dd" value="${member.regDate}" />
									</td>
							</c:forEach>
						</tbody>

					</table>
				</div>
				
				<div id="paging">
					<ul class="pagination">
						<!-- 이전 버튼의 생성 여부를 확인하여 버튼을 보여줌 -->
						<c:if test="${pageMaker.prev}">
							<li>
								<a href='<c:url value="/admin/member/memberList?page=${pageMaker.startPage-1}"/>'
									aria-label="Previous">
									<span aria-hidden="true">&laquo;</span>
								</a>
							</li>
						</c:if>

						<!-- 페이지의 시작 번호와 끝 번호를 이용해 페이지 버튼을 보여줌 -->
						<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="pageNum">
							<li>
								<a href='<c:url value="/admin/member/memberList?page=${pageNum}"/>'>${pageNum}
								</a>
							</li>
						</c:forEach>

						<!-- 다음 버튼의 생성 여부를 확인하여 버튼을 보여줌 -->
						<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
							<li>
								<a href='<c:url value="/admin/member/memberList?page=${pageMaker.endPage+1}"/>' aria-label="Next">
									<span aria-hidden="true">&raquo;</span>
								</a>
							</li>
						</c:if>
					</ul>
				</div>
		</div>
	</section>
	
	<footer id="footer">
		<div>
			<%@ include file="../../include/footer.jsp" %>
		</div>
	</footer>

</div>

</body>
</html>