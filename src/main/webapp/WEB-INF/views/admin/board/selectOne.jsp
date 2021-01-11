<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
		
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<style type="text/css">
 body { font-family:'맑은 고딕', verdana; padding:0; margin:0; }
 ul { padding:0; margin:0; list-style:none;  }
 a {  text-decoration: none; }

 div#root { width:90%; margin:0 auto; }
 
 header#header { font-size:60px; padding:20px 0; }
 header#header h1 a { color:#000; font-weight:bold; }
 
 nav#nav { padding:10px; text-align:right; }
 nav#nav ul li { display:inline-block; margin-left:10px; }

 section#container { padding:20px 0; }
 section#container::after { content:""; display:block; clear:both; }
 aside { float:left; width:200px; }
 div#container_box { float:right; width:calc(100% - 200px - 20px); }
 
 aside ul li { text-align:center; }
 aside ul li a { display:block; width:100%; padding:10px 0;}
 aside ul li a:hover { background:#eee; }
 
 footer#footer { background:#f9f9f9; padding:20px; }
 footer#footer ul li { display:inline-block; margin-right:10px; }
 
 #moveBtn{position:fixed; right: 3%; bottom: 5%;}
 
#board {margin: auto; width: 800px;}
thead tr th {text-align: center;}
tfoot tr td {text-align: center;}
.countRec{display: inline-block;}			
#img {width: 500px; height: auto;}
</style>

<title>관리자 페이지</title>

<script src="https://code.jquery.com/jquery-3.5.1.js"></script>

<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
	
	//url복사
	function copy(url){
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
                      cUrl = 'https://twitter.com/intent/tweet?text=공유하기:&url='+cUrl;
                      window.open(cUrl, '', 'width=500,height=500,scrollbars=yes');	
                      break;	 
                  case "facebook":
                      cUrl = 'http://www.facebook.com/sharer/sharer.php?u='+cUrl;
                      window.open(cUrl, '', 'width=500,height=500,scrollbars=yes');	
                      break;	 
                  case "kakao":
                      cUrl = 'https://story.kakao.com/share?url='+cUrl;
                      window.open(cUrl, '', 'width=500,height=500,scrollbars=yes');	
                      break;		 
              }		 	 
          }
          
	//게시글 추천수
	function countRec(){
		var bnum = ${board.bnum}
		$.getJSON("/admin/selectOne/countRec?bnum="+bnum, function(count){
			var cnt = "";
			$(count).each(function(){
				cnt += "<div>"+this+"</div>";
			})
			$(".countRec").html(cnt);
		})
	}

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
			<%@ include file="../include/aside.jsp" %>
		</aside>
		<div id="container_box">
			<h3>게시글 조회</h3>
			<hr>
				<div id="board">

					<input type="hidden" name="bnum" id="bnum" value='${board.bnum}'>

					<table class="table table-bordered">

						<thead>
							<tr>
								<th colspan="3">${board.bnum}번 게시글
								
									<!-- url공유 드롭다운 -->
									<div class="btn-group">
										<button type="button" id="btnUrl" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
											<span class="glyphicon glyphicon-link" aria-hidden="true"></span>
											<span class="caret"></span> <!-- 드롭다운 버튼 -->
										</button>
										<ul class="dropdown-menu" role="menu">
										    <li><a id="copy">URL 복사</a></li>
										    <li><a id="twitter">트위터 공유</a></li>
										    <li><a id="facebook">페이스북 공유</a></li>
										    <li><a id="kakao">카카오스토리 공유</a></li>
									   </ul>
									</div>
									<script>
										$("a#copy").click(function(){
											var url = document.location.href;
											copy(url);
											alert("URL이 복사되었습니다")
										})
									</script>
								</th>
								
								<th>
									<input type="hidden" id="user_id" value="aa">
									<!-- aa는 임의값 tbl_member user_id에 동일한 데이터가 있어야 함 -->
									<button type="button" id="btnRecommend">
										<span class="glyphicon glyphicon-thumbs-up" aria-hidden="true"></span>
									</button>
									
									<!-- 게시글 추천수 -->
									<div class="countRec">
										<script>countRec();</script>
									</div>
									
	                                <!-- 게시글 추천 -->
	                                <script>
	                                	 $("#btnRecommend").click(function () {
	                                		 
		                                        var bnum = $("#bnum").val();
		                                        var user_id = $("#user_id").val();
		 
		                                        var data = {bnum : bnum, user_id : user_id};
		 
		                                        $.ajax({
		                                            url: "/admin/selectOne/insertRec",
		                                            type: "post",
		                                            data: data,
		                                            success: function (count) {
		                                                countRec();
		                                            }
		                                        });
	                                    	});
	                                </script>
	                                
								</th>
							</tr>
						</thead>

						<tbody>

							<tr>
								<th><label>지역</label></th>
								<td>${board.area}</td>
								<th><label>기간</label></th>
								<td>${board.startDate} ~ ${board.endDate}</td>
							</tr>

							<tr>
								<th><label>제목</label></th>
								<td colspan="3">
									<c:out value="${board.title}" />
								</td>
							</tr>

							<tr>
								<th><label>내용</label></th>
								<td colspan="3">${board.content}</td>
							</tr>

							<tr>
								<th><label>이미지</label></th>
								<td colspan="3"><img src="${board.img}" id="img"></td>
							</tr>

							<tr>
								<th><label>작성자</label></th>
								<td colspan="3">${board.writer}</td>
							</tr>

							<tr>
								<th><label>등록날짜</label></th>
								<td>
									<fmt:formatDate pattern="yyyy-MM-dd" value="${board.regDate}" />
								</td>
								<th><label>수정날짜</label></th>
								<td>
									<fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate}" />
								</td>
							</tr>

						</tbody>

						<tfoot>
							<tr>
								<td colspan="4">
									<button onclick="location.href='/admin/board/update?bnum=${board.bnum}'"
										class="btn btn-success btn-sm">수정하기</button>
								</td>
							</tr>
							<tr>
								<td colspan="4">
									<form action="/admin/board/updateY" method="post">
										<input type="hidden" name="bnum" value="${board.bnum}">
										<input type="submit" value="삭제하기" class="btn btn-warning btn-sm">
									</form>
								</td>
							</tr>
						</tfoot>

					</table>

				</div>
				
			<hr>
			
		</div>
	</section>
	
	<footer id="footer">
		<div>
			<%@ include file="../include/footer.jsp" %>
		</div>
	</footer>
	
	<div id="moveBtn">
	  <button type="button" id="upBtn" class="btn btn-lg">
	  	<span class="glyphicon glyphicon-arrow-up" aria-hidden="true"></span>
	  </button>
	  <script>
		$("#upBtn").click( function() {
			$('html, body').animate({scrollTop:0}, 400);
			return false;
		});
	  </script>
	</div>

</div>

</body>
</html>