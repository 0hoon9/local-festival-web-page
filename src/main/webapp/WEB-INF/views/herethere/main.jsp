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
                                
                                <sec:authorize access="isAuthenticated()">
                                    <div class="request">
                                       <button id="requestBtn" class="btn">등록요청</button>
                                    </div>
                                    <div class="requestModal">

                                        <div class="modalContent">

                                            <div>
                                                <input type="text" name="title" placeholder="제목을 입력해주세요">
                                                <textarea class="modal_repCon" name="content"
                                                    placeholder="등록을 원하시는 축제에 대해 입력해주세요"></textarea>
                                                <input type="hidden" name="user_id"
                                                    value="<sec:authentication property='principal.username' />">
                                            </div>

                                            <div>
                                                <button type="button" class="modal_insert">등록</button>
                                                <button type="button" class="modal_cancel">취소</button>
                                            </div>

                                        </div>

                                        <div class="modalBackground"></div>

                                    </div>
                                </sec:authorize>
                                
                                <script type="text/javascript">
                                    $(document).on("click", "#requestBtn", function () {
                                        $(".requestModal").attr("style", "display:block;");
                                    });

                                    $(document).on("click", ".modal_insert", function () {
                                        var header = '${_csrf.headerName}';
                                        var token = '${_csrf.token}';

                                        var data = {
                                            title: $("input[name=title]").val(),
                                            content: $("textarea[name=content]").val(),
                                            user_id: $("input[name=user_id]").val()
                                        };

                                        $.ajax({
                                            url: "/herethere/insertRequest",
                                            type: "post",
                                            data: data,
                                            beforeSend: function (xhr) {
                                                xhr.setRequestHeader(header, token);
                                            },
                                            success: function () {
                                                location.href = "/herethere/main";
                                            }
                                        })
                                    });

                                    $(document).on("click", ".modal_cancel", function () {
                                        $(".requestModal").attr("style", "display:none;");
                                    });
                                </script>
                                
                                <form action="/herethere/local_fair" class="search-box" method='get'>
                                    <div class="input-form">
                                    	<input type="hidden" name="page" value="1">
										<input type="hidden" name="amount" value="10">
										<input type="hidden" name="type" value="TC">
                                        <input type="text" name="keyword" placeholder="여기저기 검색">
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