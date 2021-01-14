<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<div class="option">
		<!-- cri의 type 체크 후 selected적용 -->
		<!-- 게시물 검색 폼 -->
		<form id="searchForm" action="/herethere/local_fair" method="get">
			<select name="type">
				<option value="" <c:out value="${pageMaker.cri.type == null?'selected':''}" />>--</option>
				<option value="T" <c:out value="${pageMaker.cri.type eq 'T'?'selected':''}" />>제목</option>
				<option value="C" <c:out value="${pageMaker.cri.type  eq 'C'?'selected':''}" />>내용</option>
				<option value="W" <c:out value="${pageMaker.cri.type  eq 'W'?'selected':''}" />>작성자</option>
				<option value="TC" <c:out value="${pageMaker.cri.type eq 'TC'?'selected':''}" />>제목 or 내용
				</option>
				<option value="TW" <c:out value="${pageMaker.cri.type eq 'TW'?'selected':''}" />>제목 or 작성자
				</option>
				<option value="TWC" <c:out value="${pageMaker.cri.type eq 'TWC'?'selected':''}" />>제목 or 내용 or
				작성자</option>
			</select>
			<input type="text" name="keyword" value='<c:out value="${pageMaker.cri.keyword}"/>' />
			<button class="btn search-btn">검색</button>
		</form>
		<!-- 페이지 유지에 필요한 정보를 전달하는 폼 -->
		<form id="actionForm" action="/herethere/local_fair" method="get">
			<input type="hidden" name="page" value="${pageMaker.cri.page}">
			<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
			<input type="hidden" name="type" value="${pageMaker.cri.type}">
			<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
		</form>
	</div>