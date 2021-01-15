<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="UTF-8">
		<meta name="_csrf" content="${_csrf.token}" />
		<meta name="_csrf_header" content="${_csrf.headerName}" />

		<style type="text/css">
			form {
				margin: auto;
				width: 800px;
			}
			#insertBtn {
				text-align: center;
			}
		</style>

		<title>관리자 페이지</title>

		<script src="https://code.jquery.com/jquery-3.5.1.js"></script>

		<!-- 합쳐지고 최소화된 최신 CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

		<!-- 부가적인 테마 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

		<!-- Board CSS -->
		<link rel="stylesheet" href="/resources/assets/css/board-style.css">

		<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

		<!-- ckeditor cdn -->
		<script src="//cdn.ckeditor.com/4.15.1/standard/ckeditor.js"></script>

		<script type="text/javascript">

			$(document).ready(function () {

				//입력값이 공백이면 경고창 띄우기
				$("#submit").click(function () {
					var title = $("#title").val();
					var writer = $("#writer").val();

					if (title == "") {
						alert("제목을 입력해주세요");
						return false; //해당 페이지에 그대로
					}
					else if (writer == "") {
						alert("작성자를 입력해주세요");
						return false;
					}
				})
			})

		</script>

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
					<h3>게시글 등록</h3>
					<hr>
					<form action="/admin/board/insert" method="post" enctype="multipart/form-data">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						<div class="form-inline form-group">
							<label>지역</label>
							<select name="area" class="form-control">
								<option>서울</option>
								<option>부산</option>
								<option>대구</option>
								<option>인천</option>
								<option>광주</option>
								<option>대전</option>
								<option>울산</option>
								<option>경기</option>
								<option>강원</option>
								<option>충북</option>
								<option>충남</option>
								<option>전북</option>
								<option>전남</option>
								<option>경북</option>
								<option>경남</option>
								<option>제주</option>
							</select>
						</div>


						<div class="form-inline form-group">
							<label>기간</label>
							<input type="date" name="startDate" class="form-control"> ~ <input type="date" name="endDate"
								class="form-control">
						</div>

						<div class="form-group">
							<label>제목</label>
							<input type="text" name="title" id="title" class="form-control">
						</div>

						<div class="form-group">
							<label>내용</label>
							<textarea rows="10" name="content" id="content" class="form-control"></textarea>

							<!-- ck에디터 적용 -->
							<script>
								var ckeditor_config = {
									resize_enaleb: false,
									enterMode: CKEDITOR.ENTER_BR,
									shiftEnterMode: CKEDITOR.ENTER_P,
									filebrowserUploadUrl: "/admin/ckUpload"
								};

								CKEDITOR.replace("content", 
									{filebrowserUploadUrl:'<c:url value="/admin/ckUpload" />?${_csrf.parameterName}=${_csrf.token}'});
							//textarea id를 ck에디터로 교체
							</script>
						</div>

						<div class="form-group">
							<label>이미지</label>
							<input type="file" accept=".jpg, .png" name="file" id="file">
							<!-- jpg, png 파일 확장자만 선택가능 -->
							<input type="hidden" name="test" value="testtttttttttttttttttttttttt">
							<div class="select_img">
								<img src="" />
								<input type="hidden" value="X" id="deleteBtn" class="btn btn-sm">
							</div>

							<script>

								//파일이 등록되면   
								$("#file").change(function () {
									console.log("여기 들어오나 1)")
									//x창 띄우기
									$("#deleteBtn").attr("type", "button");

									//x창 클릭하면 파일 지우기
									$("#deleteBtn").click(function () {
										$("#file").val("");
										$(".select_img img").removeAttr("src").removeAttr("style");
										$(".select_img input").attr("type", "hidden");
									})

									//현재화면에서 어떤 이미지인지 볼 수 있도록 함
									if (this.files && this.files[0]) {
										//선택한 모든 파일을 나열하는 FileList객체
										console.log("여기 들어오나 2)", this.files[0], this.files)
										var reader = new FileReader;
										//파일을 읽을 수 있도록 도와주는 객체
										console.log("여기 들어오나 3)", reader)
										reader.onload = function (i) {
											$(".select_img img").attr("src", i.target.result).width(200);
											//선택한 이미지의 크기
											console.log("여기 들어오나 4)", i)
										}

										reader.readAsDataURL(this.files[0]);
										//DataURL형식으로 파일 읽기
									}
								});

							</script>

							<!-- 현재 프로젝트의 실제 경로 -->
							<!-- 이 경로를 기준으로 파일을 저장하고 불러올 수 있음 -->
							<%=request.getRealPath("/") %>

						</div>

						<div class="form-group">
							<label>작성자</label>
							<input type="text" name="writer" value="관리자" id="writer" class="form-control" readonly>
						</div>

						<div id="insertBtn">
							<input type="submit" value="등록하기" id="submit" class="btn btn-primary btn-sm">
						</div>

					</form>
					<hr>
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