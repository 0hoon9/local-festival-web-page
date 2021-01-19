<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <!doctype html>
        <html class="no-js" lang="zxx">

        <head>
            <meta charset="utf-8">
            <meta http-equiv="x-ua-compatible" content="ie=edge">
            <title> 여기저기</title>
            <meta name="description" content="">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <link rel="shortcut icon" type="image/x-icon" href="/resources/assets/img/favicon.ico">

            <!-- CSS here -->
            <link rel="stylesheet" href="/resources/assets/css/bootstrap.min.css">
            <link rel="stylesheet" href="/resources/assets/css/owl.carousel.min.css">
            <link rel="stylesheet" href="/resources/assets/css/slicknav.css">
            <link rel="stylesheet" href="/resources/assets/css/flaticon.css">
            <link rel="stylesheet" href="/resources/assets/css/progressbar_barfiller.css">
            <link rel="stylesheet" href="/resources/assets/css/gijgo.css">
            <link rel="stylesheet" href="/resources/assets/css/animate.min.css">
            <link rel="stylesheet" href="/resources/assets/css/animated-headline.css">
            <link rel="stylesheet" href="/resources/assets/css/magnific-popup.css">
            <link rel="stylesheet" href="/resources/assets/css/fontawesome-all.min.css">
            <link rel="stylesheet" href="/resources/assets/css/themify-icons.css">
            <link rel="stylesheet" href="/resources/assets/css/slick.css">
            <link rel="stylesheet" href="/resources/assets/css/nice-select.css">
            <link rel="stylesheet" href="/resources/assets/css/style.css">
            <link rel="stylesheet" href="/resources/assets/css/custom.css">

            <script src="https://code.jquery.com/jquery-3.5.1.js"></script>

            <style type="text/css">
                div.request{text-align: right; margin-bottom: 30px;}

                div.requestModal {
                    position: relative;
                    z-index: 1;
                    display: none;
                }

                div.modalBackground {
                    position: fixed;
                    top: 0;
                    left: 0;
                    width: 100%;
                    height: 100%;
                    background: rgba(0, 0, 0, 0.8);
                    z-index: -1;
                }

                div.modalContent {
                    position: fixed;
                    top: 20%;
                    left: calc(50% - 250px);
                    width: 500px;
                    height: 300px;
                    padding: 20px 10px;
                    background: #fff;
                    border: 2px solid #666;
                }

                div.modalContent textarea {
                    font-size: 16px;
                    font-family: '맑은 고딕', verdana;
                    padding: 10px;
                    margin: 10px 0;
                    width: 470px;
                    height: 160px;
                }

                div.modalContent button {
                    font-size: 15px;
                    color: orange;
                    padding: 5px 10px;
                    margin: 5px 0;
                    background: #fff;
                    border: 1px solid #ccc;
                }

                div.modalContent button.modal_cancel {
                    margin-left: 20px;
                }
            </style>

        </head>

        <body>
            <!-- ? Preloader Start -->
            <!-- 접속시 로딩상태를 프레그레스바로 알려줌 -->
            <div id="preloader-active">
                <div class="preloader d-flex align-items-center justify-content-center">
                    <div class="preloader-inner position-relative">
                        <div class="preloader-circle"></div>
                        <div class="preloader-img pere-text">
                            <img src="/resources/assets/img/logo/loder.png" alt="">
                        </div>
                    </div>
                </div>
            </div>
            <header>
                <!-- Header Start -->
                <div class="header-area header-transparent">
                    <div class="main-header header-sticky">
                        <div class="container-fluid">
                            <div class="menu-wrapper d-flex align-items-center justify-content-between">
                                <!-- Logo -->
                                <div class="logo">
                                    <a href="/herethere/main"><img src="/resources/assets/img/logo/logo.png" alt=""></a>
                                </div>
                                <!-- Main-menu -->
                                <div class="main-menu f-right d-none d-lg-block">
                                    <nav>
                                        <ul id="navigation">
                                            <li><a href="/herethere/main">홈</a></li>
                                            <li><a href="/herethere/map">간편보기</a></li>
                                            <li><a>인기 축제</a>
	                                            <ul class="submenu">
	                                                <li><a href="/herethere/popular_recommend">추천수</a></li>
	                                                <li><a href="/herethere/popular_hit">조회수</a></li>
	                                            </ul>
	                                        </li>
                                            <li><a href="/herethere/local_fair">지역별 축제</a></li>                                 
                                        </ul>
                                    </nav>
                                </div>

                                <sec:authorize access="isAnonymous()">
                                    <div class="header-btns d-none d-lg-block f-right">
                                        <a href="/sign/customLogin" class="btn">로그인</a>
                                        <a href="/member/join" class="btn">회원가입</a>
                                    </div>
                                </sec:authorize>

                                <sec:authorize access="isAuthenticated()">
                                    <div class="header-btns d-none d-lg-block f-right">
                                        <a href="/member/memberAdmin" class="btn">회원정보</a>
                                        <a href="/admin/main" class="btn">관리자</a>
                                        <a href="/sign/customLogout" class="btn">로그아웃</a>
                                    </div>
                                </sec:authorize>

                                <!-- Mobile Menu -->
                                <div class="col-12">
                                    <div class="mobile_menu d-block d-lg-none"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Header End -->
            </header>
            <!-- header end -->