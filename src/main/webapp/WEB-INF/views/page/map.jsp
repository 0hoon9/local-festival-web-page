<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="../include/header.jsp" %>

        <body>
            <!-- Search 페이지 CSS -->
            <link rel="stylesheet" href="/resources/assets/css/map-style.css">
            <!-- 카카오 라이브러리 services와 clusterer, drawing 라이브러리 불러오기 -->
            <script type="text/javascript"
                src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9ab90baec58228c9ac322f2cd8131a44&libraries=services,clusterer,drawing"></script>
            <!-- jquery cdn불러오기 -->
            <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
            <div class="in-header"></div>
            <div class="contents">
                <!-- 검색 영역-->
                <div id="search-area">
                    <div class="search-form">
                        <div class="search-items">
                            <div class="search-image">
                                <img src=\resources\assets\img\logo\map_logo.png>
                            </div>
                            <div class="search-icon">
                                <button type="button" id="init"><img class="icon"
                                        src="/resources/assets/img/logo/place_icon.png"></button>
                            </div>
                        </div>
                        <div class="search-text">
                            <form>
                                <input type="text" value="" id="keyword" placeholder="지역으로 검색">
                                <input type="image" id="image" src="\resources\assets\img\logo\search_icon.png">
                            </form>
                        </div>
                    </div>
                    <div id="info">
                        <ul id="placesList"></ul>
                    </div>
                </div>
                <!-- 지도의 영역 -->
                <div id="map"></div>
            </div>
            <!-- Kakao API Key -->
            <script type="text/javascript"
                src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9ab90baec58228c9ac322f2cd8131a44"></script>

            <script>
                $(document).ready(function () {
                    let mapData = []; //축제정보가 담긴 json 데이터를 받을 새로운배열
                    let markers = []; // 마커를 담을 배열

                    // 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성
                    let infowindow = new kakao.maps.InfoWindow({ zIndex: 1 });
                    let infowindows = []; // 인포윈도우를 담을 배열
                    let mapContainer = document.getElementById('map'); //지도를 담을 영역의 DOM레퍼런스
                    let mapOption = { //지도를 생성할 때 필요한 기본 옵션
                        center: new kakao.maps.LatLng(37.57414, 126.95639), //지도의 중심좌표
                        level: 3 //지도의 확대 레벨
                    };
                    let map = new kakao.maps.Map(mapContainer, mapOption); //지도 생성 및 객체 리턴

                    // 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성
                    let mapTypeControl = new kakao.maps.MapTypeControl();

                    // 지도에 컨트롤을 추가해야 지도위에 표시됨
                    map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

                    // 지도 확대 축소를 제어할 수 있는 줌 컨트롤을 생성
                    let zoomControl = new kakao.maps.ZoomControl();
                    map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

                    // 지도에 교통정보를 표시하도록 지도타입을 추가
                    // map.addOverlayMapTypeId(kakao.maps.MapTypeId.TRAFFIC);

                    // 아래 코드는 위에서 추가한 교통정보 지도타입을 제거
                    //map.removeOverlayMapTypeId(kakao.maps.MapTypeId.TRAFFIC)

                    getData();//최초에 모든 축제 데이터를 보여줌

                    // 모든축제 데이터 조회 함수
                    function getData() {
                        //함수의 인자 data로 json정보를 담는다
                        $.getJSON('/resources/assets/jsonData/mapData.json', function (data) {
                            $.each(data.data, function (key, value) { //data인자에 data key로 value(배열)에 접근
                                //value(모든 축제정보)를 위에서 선언한 새로운 배열에 담는다
                                mapData.push(value);//이때, mapData는 객체로 이루어진 배열이된다
                            });
                            //배열을 순회하며 데이터를 처리
                            mapData.forEach((element) => { //element는 key와 value로 이루어진 객체이다
                                let festival_name = element.festival_name; //축제이름
                                let latitude = element.latitude; //위도
                                let longitude = element.longitude; //경도
                                // 축제데이터를 마커로 지도에 추가
                                let markerPosition = new kakao.maps.LatLng(latitude, longitude); //마커가 표시될 위치
                                let marker = new kakao.maps.Marker({
                                    position: markerPosition
                                });
                                //마커가 지도 위에 표시되도록 설정한다
                                marker.setMap(map);
                                markers.push(marker);//나중에 marker를 쉽게 제거하기 위해 markers배열에 marker 추가

                                // 인포윈도우에 사용될 정보를 저장할 변수 설정
                                let iwContent = '<div style="padding:5px;">'
                                    + festival_name
                                    + '<br> <a href="https://map.kakao.com/link/map/' + festival_name + "," + latitude + "," + longitude + '"'
                                    + 'style="color:blue" target="_blank">큰지도보기</a>'
                                    + '<a href="https://map.kakao.com/link/to/' + festival_name + "," + latitude + "," + longitude + '"'
                                    + 'style="color:blue" target="_blank"> 길찾기'
                                    + "</a></div>";
                                iwPosition = new kakao.maps.LatLng(latitude, longitude); //인포윈도우 표시 위치

                                // 인포윈도우를 생성
                                let infowindow = new kakao.maps.InfoWindow({
                                    position: iwPosition,
                                    content: iwContent
                                });
                                infowindows.push(infowindow);// markers와 동일한 이유

                                // 마커에 클릭이벤트 등록
                                // 클릭시 인포윈도우 open or close
                                let checker = true; // 인포윈도우 표시, 제거를 판단할 boolean 타입 변수
                                kakao.maps.event.addListener(marker, 'click', function () {
                                    if (checker) {
                                        // 마커 위에 인포윈도우를 표시
                                        infowindow.open(map, marker);
                                        checker = false;
                                    } else {
                                        infowindow.close();
                                        checker = true;
                                    }
                                });
                            }); //end forEach
                        });//end getJson
                    }//end getData()

                    //마커를 추가하는 함수
                    //현재 데이터상 좌표와 주소가 정확하지 않아 지역검색시 마커가 전국적으로 퍼져 나오나 오류가 아닙니다
                    function addMarker(position, idx, title) {
                        let imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 사용
                            imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
                            imgOptions = {
                                spriteSize: new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
                                spriteOrigin: new kakao.maps.Point(0, (idx * 46) + 10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
                                offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
                            },
                            markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
                            marker = new kakao.maps.Marker({
                                position: position, // 마커의 위치
                                image: markerImage
                            });
                        marker.setMap(map); // 지도에 마커 표출
                        markers.push(marker); //markers배열에 등록. 마커를 삭제할때 사용함 
                        return marker;
                    }

                    // 검색 결과 목록과 검색 결과 마커 추가
                    function displayKeyword(keyword) {
                        let listEl = document.getElementById('placesList'),
                            menuEl = document.getElementById('search-area'),
                            fragment = document.createDocumentFragment(),
                            bounds = new kakao.maps.LatLngBounds(),
                            listStr = '',
                            indexCount = 0,
                            onlyOne = false,
                            searchResult = [];

                        // 검색 결과 목록에 추가된 항목들 제거
                        removeAllChildNods(listEl);

                        // 지도에 표시되고 있는 마커 제거
                        removeMarker();

                        // 데이터 표출
                        mapData.forEach((element) => {
                            //json데이터중 지번주소나 도로명주소에 keyword가 포함되면 true
                            if (element.address.includes(keyword) ||
                                element.address_two.includes(keyword)) {

                                // 마커 생성 및 지도에 표시
                                let markerPosition = new kakao.maps.LatLng(element.latitude, element.longitude),
                                    marker = addMarker(markerPosition, indexCount),
                                    itemEl = getListItem(indexCount, element); // 검색 결과 항목 Element를 생성
                                marker.setMap(map); // 지도에 마커 표출
                                markers.push(marker);
                                indexCount++; //총 검색결과 count하는 변수

                                // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
                                // LatLngBounds 객체에 좌표를 추가한다. 이때 객체에 저장된 좌표들을 기준으로
                                // 전체 마커를 볼 수 있도록 중심좌표와 확대레벨이 변경된다
                                bounds.extend(markerPosition);

                                // 마커와 검색결과 항목에 mouseover시
                                // 해당 장소 인포윈도우에 장소명을 표시
                                // mouseout 했을 때 인포윈도우를 닫는다
                                (function (marker, title) {
                                    kakao.maps.event.addListener(marker, 'mouseover', function () {
                                        displayInfowindow(marker, title);
                                    });
                                    kakao.maps.event.addListener(marker, 'mouseout', function () {
                                        infowindow.close();
                                    });
                                    itemEl.onmouseover = function () {
                                        displayInfowindow(marker, title);
                                    };
                                    itemEl.onmouseout = function () {
                                        infowindow.close();
                                    };
                                })(marker, element.festival_place);
                                fragment.appendChild(itemEl);
                            }
                        });

                        // 검색결과 항목들을 검색결과 목록 Elemnet에 추가
                        listEl.appendChild(fragment);
                        menuEl.scrollTop = 0;

                        // 검색된 장소 위치를 기준으로 지도 범위를 재설정
                        map.setBounds(bounds);

                        // 검색된 정보가 없으면 경고창 띄움
                        if (indexCount === 0) {
                            indexCount++; //검색결과가 없을시 반복문으로 인해 alert창이 반복되는 것을 방지
                            alert("키워드를 재입력 하세요");
                        }
                    }

                    // 검색결과 항목을 Element로 반환하는 함수
                    function getListItem(index, data) {
                        let el = document.createElement('li'),
                            itemStr = '<span class="markerbg marker_' + (index + 1) + '"></span>' +
                                '<div class="info">' +
                                '   <h5>' + data.festival_name + '</h5>';
                        if (data.address_two) {
                            itemStr += '    <span>' + data.address_two + '</span>' +
                                '   <span class="jibun gray">' + data.address + '</span>';
                        } else {
                            itemStr += '    <span>' + data.festival_name + '</span>';
                        }
                        itemStr += '  <span class="tel">' + data.phone_num + '</span>' +
                            '</div>';
                        el.innerHTML = itemStr;
                        el.className = 'item';
                        return el;
                    }

                    // 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수
                    // 인포윈도우에 장소명을 표시
                    function displayInfowindow(marker, title) {
                        let content = '<div style="padding:5px;z-index:1;">' + title + '</div>';
                        infowindow.setContent(content);
                        infowindow.open(map, marker);
                    }

                    // 기존 마커 제거
                    function removeMarker() {
                        for (let i = 0; i < markers.length; i++) {
                            markers[i].setMap(null);
                            infowindows[i].close();
                        }
                        markers = [];
                    }

                    // 검색결과 목록의 자식 element를 제거하는 함수
                    function removeAllChildNods(el) {
                        while (el.hasChildNodes()) {
                            el.removeChild(el.lastChild);
                        }
                    }

                    // 사용자 검색 요청시 json 데이터 가져오기
                    $("#image").click(function (e) {
                        let keyword = document.getElementById('keyword').value; // 키워드 값 저장
                        displayKeyword(keyword); // 검색 결과에 대한 목록과 마커 추가 및 호출
                        e.preventDefault(); // 이벤트 중단, 페이지 이동 없이 같은 창에서 검색을 구현하기 위함
                    });

                    $("#init").click(function (e) {
                        let msg = "검색 결과를 초기화 하시겠습니까?"
                        let flag = confirm(msg);
                        getData();
                    })


                });//end ready
            </script>
            <%@ include file="../include/footer.jsp" %>
        </body>

        </html>