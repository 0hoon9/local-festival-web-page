<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="../include/header.jsp" %>

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
                                <form action="/admin/board/getList" class="search-box" method='get'>
                                    <div class="input-form">
                                        <input type="text" name="keyword" placeholder="여기저기 검색">
                                        <input type="hidden" name="type" value="TC">
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
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--Hero Area End-->
        </main>
        <%@ include file="../include/footer.jsp" %>
            </body>

            </html>