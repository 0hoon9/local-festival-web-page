![logo](https://user-images.githubusercontent.com/76147992/113659398-e4c4b400-96dc-11eb-84f1-4cb935fb9c3e.png)

### 여기저기
---
여기저기는 그린컴퓨터 아카데미에서 6개월간의 배움을 토대로 만든 프로젝트입니다.  
약 1개월의 시간이 소요되었으며, 총 3명의 팀원이 참가해 만들었습니다.  
주로 Java(8)와 Spring Framework를 사용하여 WEB을 구성했습니다.  
<br/>

### 개요
---
공공데이터를 기반으로 한 지역축제정보를 제공하는 서비스를 지원합니다.  
사용자는 검색 또는 redirect를 통해 게시물 형태의 축제정보를 확인하거나 지도형태로 제공되는 축제정보를 확인할 수 있습니다.   
사용자에 의해 조회순 또는 축제순 정보로 인기있는 축제를 확인할 수 있으며, 자신이 언제든지 확인하고 싶은 축제정보는 즐겨찾기 기능을 통해 마이페이지에서 확인할 수 있습니다.  
<br/>
  
### 데이터베이스 Table
---  
![table](https://user-images.githubusercontent.com/76147992/113665055-ca440800-96e7-11eb-9cd2-a70742de7808.JPG)  
<br/>
  
### 공공데이터 활용
---  
![공공데이터 활용](https://user-images.githubusercontent.com/76147992/113663877-c0b9a080-96e5-11eb-8b64-b9434e9284d0.jpg)   
<br/>
  
### MVC Pattern
---
Model은 domain에 VO 또는 DTO객체로 관리하였고, mapper에서 mybatis로 연결해주었으며  
Controller는 controller폴더에서 각각의 HTTP요청에 따라 처리해주었습니다.  
View는 WEB-INF 하위폴더의 views에서 관리합니다.  
![2](https://user-images.githubusercontent.com/76147992/113664164-3c1b5200-96e6-11eb-8dda-d112413f9525.JPG)  
<br/>
  
### 스타일
---
부트스트랩 템플릿을 사용하여 커스텀 하였습니다.  
원본: [themewagon에서 제공하는 template](https://themewagon.com/themes/free-responsive-bootstrap-4-html5-hosting-website-template-fastes/)  
<br/>

### 데이터 가공 (JupytherLab, Python3, Excel, Oracle sql developer)
---
데이터 가공 중 데이터의 개수를 조정하는 단계에서  
더미데이터를 추가해 좌표와 주소가 일치하지 않는 이슈가 존재합니다.  
프로그래밍 로직에는 오류가 없습니다.  
![parsing](https://user-images.githubusercontent.com/76147992/113667737-2a3cad80-96ec-11eb-96ff-e17fab6d1843.JPG)  
<br/>

### MyBatis
---
![mybatis](https://user-images.githubusercontent.com/76147992/113667262-7affd680-96eb-11eb-8c48-d74d9feffaff.jpg)  
<br/>

### KaKao Map API
---
사용법: KaKao Developer ![kakao developer](https://developers.kakao.com/)를 참조하세요.
logic: 가공한 데이터(json)파일을 jquery의 .getJSON()으로 가져와 KaKao API문법에 맞게 사용했습니다.
세부사항: 주석 확인  
<br/>

### 담당업무
---
![담당파트](https://user-images.githubusercontent.com/76147992/113665774-0af05100-96e9-11eb-8b06-64b756b74667.jpg)
