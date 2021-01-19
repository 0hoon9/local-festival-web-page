<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <!DOCTYPE html>
  <html>

  <head>
    <meta charset="UTF-8">
    <title>사이드</title>
    <style type="text/css">
    	div.main{text-align: center; margin-bottom: 30px;}
    </style>
  </head>

  <body>
  	<div class="main">
  		<h3><b><a href="/admin/main">메인</a></b></h3>
  	</div>
  	
    <ul class="board-aside">
      <li>
        <h4><b>게시글 목록</b></h4><br>
      </li>
      <li><a href="/admin/board/insert">게시글 등록</a></li>
      <li><a href="/admin/board/getList">게시글 목록</a></li>
      <li><a href="/admin/board/removeList">삭제 게시글</a></li>
    </ul>
    <hr>
    <ul class="board-aside">
      <li>
        <h4><b>회원 관련</b></h4><br>
      </li>
      <li><a href="/admin/member/memberList">회원 정보</a></li>
      <li><a href="/admin/member/reply">댓글 관리</a></li>
	  <li><a href="/admin/member/request">등록 요청</a></li>
	</ul>

  </body>

  </html>