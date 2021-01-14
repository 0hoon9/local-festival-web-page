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
                                <a href="main"><img src="/resources/assets/img/logo/logo.png" alt=""></a>
                            </div>
                            <!-- Main-menu -->
                            <div class="main-menu f-right d-none d-lg-block">
                                <nav>
                                    <ul id="navigation">
                                        <li><a href="main">홈</a></li>
                                        <li><a href="../page/map">간편보기</a></li>
                                        <li><a href="popular">인기</a>
                                        <li><a href="main_travel">여행지</a>
                                            <ul class="submenu">
                                                <li><a href="recommend">추천 여행지</a></li>
                                                <li><a href="local_travel">지역 여행지</a></li>
                                            </ul>
                                        </li>
                                        <li><a href="myPage">My</a></li>
                                        <li><a href="event">이벤트</a></li>
                                    </ul>
                                </nav>
                            </div>
                            <!-- Header-btn -->
                            
                            <div class="header-btns d-none d-lg-block f-right">
                            
                            <!-- 로그인을 안할 경우 아래 버튼 두개가 보임 -->
                        	<sec:authorize access="isAnonymous()">
                            	<a href="/sign/customLogin" class="btn">로그인</a>
                            	<a href="/member/join" class="btn">회원가입</a>
                        	</sec:authorize>
                        
                        	<!-- 로그인을 할 경우 아래 버튼 두개가 보임 -->
                        	<sec:authorize access="isAuthenticated()">
	                        	<a href="/member/memberAdmin" class="btn">회원정보</a>
                            	<a href="/sign/customLogout" class="btn">로그아웃</a>
	                        </sec:authorize>
	                        
                            </div>
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