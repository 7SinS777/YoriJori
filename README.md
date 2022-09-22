## 레시피 작성 및 공유 사이트
**※ eclipse 개발 툴을 사용하며 작성하였으며, java는 JDK 15.0.2버전으로, springframework는 4.3.22릴리스 버전으로 작성하였습니다.**

* 개요 : facebook, instagram 같은 **SNS페이지**에 **요리**라는 주제를 넣어서 만든 공유 사이트
* 목적 : 1인가구, 코로나 시대에 접어들면서 혼자서 요리하는 것보다 배달 음식으로 끼니를 해결하려는 모습이 많음. 배달 음식이 아닌 스스로 요리를 하고 싶지만 방법을 모를 때, 자신이 가진 재료로 무엇을 만들 수 있는지 모를 때 찾아볼 수 있는 사이트를 만드는 것임.
* 사용 기술
  * java
  * html, css, javascript
  * jsp
  * bootstrap4
  * jquery
  * Oracle sql
  * springframework
  * mybatis
  * springsecurity
  * jstl
  * EL
  * csrf
  
* 기능
  * 회원가입/로그인-아웃/회원탈퇴
  * 프로필 관리
  * 레시피 게시물 작성/수정/삭제
  * 레시피 게시물 조회
  * 레시피 게시물 댓글
  * 레시피 게시물 검색
  
* 코드 구조
  * ajax 비동기 방식으로 웹페이지의 내용을 바꿈.
  * 예시
```javascript
/*소스코드 recipeRegister.jsp에 있는 script문*/
$("#goRecipeAllView").click(function(event) {
  event.preventDefault();
  $.ajax({
    url : "recipeAllView?chose=times",
    type : "get",
    data : "",
    success : function(data) {
      $("#body").html(data);
    },
    error : function() {
      alert("에러입니다.");
    }
  });
});
```
  * MVC패턴의 구조를 지님
    * 1. 웹페이지에서 요소를 클릭하여 이벤트 발생시킨 후, 컨트롤러에 데이터 전송
    * 2. 컨트롤러로 전송된 데이터를 커맨드클래스를 통해서 Dto 모델에 삽입하여 객체 생성
    * 3. Dto 객체를 Dao에 있는 메서드를 통해서 sql에 전달
    * 4. Dao에서 받은 메서드의 종류에 맞게끔 sql에 적용한 뒤, 성공 실패 여부 및 돌려받은 값들을 뷰로 보내기 위해 속성 저장
    * 5. 성공 실패에 따른 결과값을 뷰에 노출
  * DB 설계
    * 테이블 종류
      * MEMBER
      
        ![MEMBER Table](https://user-images.githubusercontent.com/112447007/190324137-5ff2e6e5-0d0e-444a-9a85-5ab254ccccc0.png)
      * RECIPELIST
      
        ![RECIPELIST Table](https://user-images.githubusercontent.com/112447007/190324618-e93b9fd5-fe21-41d0-a3f0-4574311d82c5.png)
      * RECIPEWRITE
      
        ![RECIPEWRITE Table](https://user-images.githubusercontent.com/112447007/190324639-7a96e3b2-7d9f-4c70-8107-341c507966c6.png)
      * RECIPECOMMENTS
      
        ![RECIPECOMMENTS Table](https://user-images.githubusercontent.com/112447007/190324411-d6c1f8c9-9703-4235-981a-43cd6f0af4c0.png)
      * 테이블 관계도

        ![YoriJori DB](https://user-images.githubusercontent.com/112447007/190328882-571f7fe8-f295-4b2d-8d47-ecc95bb55c6c.png)
* 비고
  * 정보처리산업기사 과정평가형 훈련기간 동안 기획한 프로젝트이며, 필자 포함 3인이 한 조로 작성한 프로젝트임.
  * 프로젝트는 현재 진행중이며, 완성되지 않은 프로젝트임.
  * 필자는 DB 설계 및 기능 구현을 담당함.
  * 아직 구현하지 못한 기능도 있으며, UI도 디자인이 정리되지 않음.
  * 구현하지 못한 기능
    * 댓글 삭제(곧 구현 가능)
    * 관리자 권한 및 관리자 모드
    * 신고 시스템
    * 각 계정, 게시물 별 권한 처리
    * 카테고리 검색
    * 커뮤니티
  * 문제점
    * 이미지를 등록하고 난 바로 뒤에 이미지를 로딩하는데 시간이 걸림(해결방법 찾는 중).
 * v1.1 업데이트
   * 레시피 리스트 이동 후, 조회순/최신순 버튼을 눌렀을 때 이동하지 못했던 오류를 수정했습니다.

### 기타사항
질문, 피드백 언제나 환영합니다.
* 연락처 010-9430-4914
* 이메일 ghkdwns9979@naver.com
