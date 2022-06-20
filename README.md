# 고리타분한 주소록

##### 지원자 박영준
##### 사용기술 : Java 11, Spring Boot 3.6.7, JPA, SQLite, Gradle, Jsp, JQuery
##### 접속 url : http://localhost:8080/address/

### 1. /search 주소록 조회
 - addressBook(주소록) Table의 모든 데이터를 조회합니다.
 - 화면 최초 로딩시, 데이터 변경시에 재조회됩니다.

### 2. /save 주소록 등록, 수정
 - new 버튼을 이용하여 최초 등록이 가능합니다.
 - List Group의 선택 된 데이터를 이용하여 수정할 수 있습니다.

### 3. /delete 주소록 삭제
 - List Group의 선택 된 데이터를 삭제할 수 있습니다.
 - 02로 시작되지 않는 데이터는 삭제할 수 없습니다.
