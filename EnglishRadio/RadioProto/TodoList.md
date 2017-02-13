해야할 일

선순위

1그룹

-----Done-----

- 즐겨찾기 제거시 메인 화면에서도 하트가 사라지기 - 완료 17.02.10
: ViewController 의 viewWillAppear 함수에 changeFavorite 호출

- favorite, 표시, 삭제  - 완료

- 하단에 있는 Bottom View 클릭시 뷰 올라오기 (처음에는 안보임) - 완료 17.02.12.
: reload 시에 아래에서 위로 올라오도록 프로그래밍 setting에 있는 데이터 스위치와 같다

- 스위치 선택했을 때 Cell Expand 하기 - 완료 17.02.12.
: reload할 때 표시 옵션을 none이 아니라 bottom 이라 top 으로 하면 해결

- 음량 슬라이더 제어 - 진행중(심지선) : 테스트 해야함

- "<<(rewind)버튼"을 누르면 이 전에 들었던 라디오채널로 돌아가기 - 완료(조민규)
관련 클래스: ViewController
추가된 변수: 
1. history : 최근 재생된 스테이션의 아이디값을 저장함
추가된 함수: 
1. addHistory : 다음 버튼을 눌렀을 때 가장 먼저 호출되어야 하는 함수. 현재 스테이션 아이디값을 추가한다.
2. getLastStationId : 마지막 스테이션 아이디값을 가져오고 그 값은 배열에서 지워진다
3. prevButton : 이전 버튼을 눌렀을 때 호출되는 함수 @ibaction
수정한 함수:
1. nextButton : addHistory 를 가장 위에 추가함
개선 사항:
1. 다음으로 넘어갈 때 같은 스테이션이 될 확률이 있음
2. 다음으로 넘어갈 때 랜덤하게 넘어가므로 음악 재생 어플과 약간은 다름

- realm 이 휴대폰에서 안된다?? - 해결
원인: 마이그레이션이 안된 테스트용 데이터가 남아 있었기 때문.
해결: 테스트 디바이스에서 앱을 삭제했다가 다시 설치

- BottomPlayView modal 로 넘어가기 - 완료

- 각 탭바 아이콘 - 완료

- 즐겨찾기 설정 시 안내 문구(방해하지 않는 알림) - 완료(조민규)
관련 클래스 : ViewController
추가된 변수 :
1. alertLabel : 안내문구가 적힌 라벨
2. alertView : alertLabel이 포함된 뷰
3. alertTimer : 애니매이션을 위한 타이머
추가된 함수 : 
1. alertFavorite : 페이버릿에 추가됫음을 알리기 위해
2. alertEnd : 애니매이션 종료
개선사항 및 추가 예정 :
1. 삭제 되었을 때도 추가 예정
2. 확장성

-----todo-----

- 코드 다듬기 & 코멘트 적어놓기
- 잠금화면 제어


- BottomPlayView 화면 중간쯤 올라오기
- BottomPlayView Favorite, Setting 에서도 보이기 
- BottomPlayView 에서도 Play 제어 가능

- Favorite 에서 재생 가능 

- Setting 에서 재생 가능



- 헤드폰 제어


- 3G, wifi 연결 구분

- 런치 스크린 이미지


- 탭바 아이콘이 하얗게는 안될까?? 선택시 태두리 변경 


2그룹

Now Playing 애니메이션
제목 좌우로 흐르기 
데이터 타이머
앨범아트
위젯
포스터치
최적화



후순위

온라인 업뎃
파이어 베이스
