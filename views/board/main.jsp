<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

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
                    <img src="/resources/assets/img/logo/loder.PNG" alt="">
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
                                    <li><a href="location">내주변</a></li>
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
    <main>
        <!-- Hero Area Start-->
        <div class="slider-area">
            <div class="single-slider slider-height d-flex align-items-center">
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-xl-8 col-lg-9">
                            <!-- Hero Caption -->
                            <div class="hero__caption">
                            </div>
                            <!--Hero form -->
                            <form action="#" class="search-box">
                                <div class="input-form">
                                    <input type="text" placeholder="여기저기 검색">
                                    <!-- icon search -->
                                    <div class="search-form">
                                        <button><i class="ti-search"></i></button>
                                     </div>
                                    <!-- icon search -->
                                    <div class="world-form">
                                        <i class="fas fa-globe"></i>
                                     </div>
                                </div>
                            </form>	
                            <!-- Domain List -->
                           <!--  <div class="single-domain pt-30 pb-30">
                                <ul>
                                    <li><span>.com</span> <p>$15.99</p></li>
                                    <li><span>.net</span> <p>$10.99</p></li>
                                    <li><span>.rog</span> <p>$10.99</p></li>
                                    <li><span>.me</span> <p>$10.99</p></li>
                                </ul>
                            </div> -->
                            <!-- Domain List  End-->
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--Hero Area End-->
    </main>
    <footer>
        <div class="footer-wrappr  section-bg" data-background="/resources/assets/img/gallery/footer_bg.png">
            <div class="footer-area footer-padding ">
                <div class="container">
                    <div class="row d-flex justify-content-between">
                        <div class="col-xl-2 col-lg-2 col-md-4 col-sm-5">
                            <div class="single-footer-caption mb-50">
                                <div class="footer-tittle">
                                    <h4>Company</h4>
                                    <ul>
                                        <li><a href="#">회사소개</a></li>
                                        <li><a href="#">개인정보처리방침</a></li>
                                        <li><a href="#">이용약관</a></li>
                                        <li><a href="#">광고제휴문의</a></li>
                                        <li><a href="#">사업자 정보</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-2 col-lg-2 col-md-4 col-sm-5">
                            <div class="single-footer-caption mb-50">
                                <div class="footer-tittle">
                                    <h4>Service</h4>
                                    <ul>
                                        <li><a href="#">공지사항</li>
                                        <li><a href="#">자주 묻는 질문</a></li>
                                        <li><a href="#">블로그</li>
                                        <li><a href="#">1:1문의</a></li>
                                        <li><a href="#">건의사항</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3 col-lg-3 col-md-4 col-sm-5">
                            <div class="single-footer-caption mb-50">
                                <div class="footer-tittle">
                                    <h4>Support</h4>
                                    <ul>
                                        <li><p>메일 : herethere@gmail.com</p></li>
                                        <li><p>사업자등록번호: 910-53-104321<p></li>
                                        <li><p>Tel : 031-237-9082<p></li>
                                        <li><p>통신판매업 신고 : 강남-902호<p></li>
                                        <li><p>고객센터 : 1590-1331<p></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3 col-lg-4 col-md-6 col-sm-6">
                            <div class="single-footer-caption mb-50">
                                <!-- logo -->
                                <div class="footer-logo mb-25">
                                    <a href="index.html"><img src="/resources/assets/img/logo/logo2_footer.png" alt=""></a>
                                </div>
                                <div class="footer-tittle mb-50">
                                    <p>뉴스레터를 구독하면 여기저기의 <br>새로운 알림을 받아보실 수 있습니다</p>
                                </div>
                                <!-- Form -->
                                <div class="footer-form">		
                                    <div id="mc_embed_signup">
                                        <form target="_blank" action="https://spondonit.us12.list-manage.com/subscribe/post?u=1462626880ade1ac87bd9c93a&amp;id=92a4423d01" method="get" class="subscribe_form relative mail_part" novalidate="true">
                                            <input type="email" name="EMAIL" id="newsletter-form-email" placeholder=" Email Address " class="placeholder hide-on-focus" onfocus="this.placeholder = ''" onblur="this.placeholder = '이메일 정보 입력'">
                                            <div class="form-icon">
                                                <button type="submit" name="submit" id="newsletter-submit" class="email_icon newsletter-submit button-contactForm">
                                                   	구독<i class="fa fa-heart" aria-hidden="true"></i>
                                                </button>
                                            </div>
                                            <div class="mt-10 info"></div>
                                        </form>
                                    </div>
                                </div>
                                <!-- social -->
                                <div class="footer-social mt-50">
                                    <a href="#"><i class="fab fa-twitter"></i></a>
                                    <a href="https://bit.ly/sai4ull"><i class="fab fa-facebook-f"></i></a>
                                    <a href="#"><i class="fab fa-pinterest-p"></i></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- footer-bottom area -->
            <div class="footer-bottom-area">
                <div class="container">
                    <div class="footer-border">
                        <div class="row">
                            <div class="col-xl-10 ">
                                <div class="footer-copy-right">
                                    <p><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
  Copyright &copy;<script>document.write(new Date().getFullYear());</script> <i class="fa fa-heart" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Koo Yeonghun, Kim Seunggyun, Park Hyeonbin</a>
  <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </footer>
    <!-- Scroll Up -->
    <div id="back-top" >
        <a title="Go to Top" href="#"> <i class="fas fa-level-up-alt"></i></a>
    </div>

    <!-- JS here -->

    <script src="/resources/assets/js/vendor/modernizr-3.5.0.min.js"></script>
    <!-- Jquery, Popper, Bootstrap -->
    <script src="/resources/assets/js/vendor/jquery-1.12.4.min.js"></script>
    <script src="/resources/assets/js/popper.min.js"></script>
    <script src="/resources/assets/js/bootstrap.min.js"></script>
    <!-- Jquery Mobile Menu -->
    <script src="/resources/assets/js/jquery.slicknav.min.js"></script>

    <!-- Jquery Slick , Owl-Carousel Plugins -->
    <script src="/resources/assets/js/owl.carousel.min.js"></script>
    <script src="/resources/assets/js/slick.min.js"></script>
    <!-- One Page, Animated-HeadLin -->
    <script src="/resources/assets/js/wow.min.js"></script>
    <script src="/resources/assets/js/animated.headline.js"></script>
    <script src="/resources/assets/js/jquery.magnific-popup.js"></script>

    <!-- Date Picker -->
    <script src="/resources/assets/js/gijgo.min.js"></script>
    <!-- Nice-select, sticky -->
    <script src="/resources/assets/js/jquery.nice-select.min.js"></script>
    <script src="/resources/assets/js/jquery.sticky.js"></script>
    <!-- Progress -->
    <script src="/resources/assets/js/jquery.barfiller.js"></script>
    
    <!-- counter , waypoint,Hover Direction -->
    <script src="/resources/assets/js/jquery.counterup.min.js"></script>
    <script src="/resources/assets/js/waypoints.min.js"></script>
    <script src="/resources/assets/js/jquery.countdown.min.js"></script>
    <script src="/resources/assets/js/hover-direction-snake.min.js"></script>

    <!-- contact js -->
    <script src="/resources/assets/js/contact.js"></script>
    <script src="/resources/assets/js/jquery.form.js"></script>
    <script src="/resources/assets/js/jquery.validate.min.js"></script>
    <script src="/resources/assets/js/mail-script.js"></script>
    <script src="/resources/assets/js/jquery.ajaxchimp.min.js"></script>
    
    <!-- Jquery Plugins, main Jquery -->	
    <script src="/resources/assets/js/plugins.js"></script>
    <script src="/resources/assets/js/main.js"></script>
    
    </body>
</html>