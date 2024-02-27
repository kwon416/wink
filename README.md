<div align=center>
	<img src="https://capsule-render.vercel.app/api?type=waving&color=auto&height=200&section=header&text=WINK&fontSize=90" />	
</div>

<div align=center>
    <img src="https://github.com/kwon416/wink/assets/95855658/3b0b5816-f4d7-4fe1-be14-0b4ca26ccf66" height="200">
	<h3>나를 궁금해하는 사람을 찾아보세요!</h3>
    <h4>궁금한 사람에게 익명으로 질문하고 답장해보세요!</h4>
    <h4>Flutter & Firebase 기반 개인 프로젝트</h4>
<br />

</div>

## 주요 기능 소개

### Application
- Flutter 기반 Andorid & iOS 어플리케이션으로 본인 인증으로 회원가입이 가능하다.
- 인증된 회원은 userId 값을 가지고, 자신의 ID로 다른 사람을 초대할 수 있는 다이나믹 링크를 만들어 나에게 WINK를 보내거나 질문하도록 할 수 있다.
- 초기 한 명의 회원에게 WINK를 보낼 수 있고 상대는 익명으로 받게 된다. 
- WINK를 받은 회원은 푸시알림과 WINK박스에서 수신 내역을 확인할 수 있고, WINK를 보낸 회원에게 질문을 할 수 있다.
- 한 명 이외의 여러명의 사람에게 WINK를 보내고 싶다면 코인을 사용한다.
- 코인은 친구초대, 광고시청 또는 인앱결제로 얻을 수 있다.
- 또 코인은 누가 나에게 WINK를 보냈는 지 힌트를 얻고 싶을 때 사용할 수 있다.
- 힌트는 프로필 사진, 닉네임, 성별 등을 회원이 제공한다.
- 앱 설정 기능으로는 다국어 지원, 푸시알림 설정, 다크모드 등이 있다.

### Firebase
- 본인 인증은 Firebase Authentication 기반 전화번호 인증을 사용. 월 5만회까지 인증 무료이고 사용량에 따라 과금된다.
- 회원 정보는 Firebase Realtime Database 에 키/밸류 형태로 저장되며, Firebase 인증을 받은 회원에게 접근이 허용된다.
- 푸시 알림은 FCM 으로 구성되며, 토큰을 이용하여 푸시를 발송한다. 전체 공지 또는 광고 푸시는 웹 콘솔에서 발송한다.
- 회원이 업로드한 사진은 Firebase Storage에 회원 ID를 기반으로 저장한다.
- 친구 초대 링크는 Dynimic Links 로 생성하여 앱 설치까지 유도할 수 있다.

## 화면 구성
|  초기 화면   | 로그인(전화번호 인증) |  회원가입   |
|:--------:|:------------:|:-------:|
|  ![simulator_screenshot_EE7CE65C-FAED-4B5C-9674-427328DFA295](https://github.com/kwon416/wink/assets/95855658/946bf059-8246-4643-843b-07a21d5cd0e8)   |    ![Simulator Screenshot - iPhone 15 Pro Max - 2024-02-27 at 13 39 38](https://github.com/kwon416/wink/assets/95855658/8edc59db-3d29-49c5-8ef7-a08eaf2e1513)     |  ![simulator_screenshot_5466BFAC-1DF7-4AC9-B916-4936055E70A5](https://github.com/kwon416/wink/assets/95855658/58c95cd1-f2e6-4ef6-89d8-ee2869c32ff6)  |
| WINK 보내기 전 |   WINK 보내기 후    |   WINK 박스   |
|  ![simulator_screenshot_6CBCE1E2-7157-40A9-BB40-27F4549BD141](https://github.com/kwon416/wink/assets/95855658/97e9d3ac-53b3-4282-92cc-3c4dae09c731)   |    ![simulator_screenshot_E6D94348-6F05-4E01-96BF-64D7A56F6CEB](https://github.com/kwon416/wink/assets/95855658/63448359-bdd7-4212-8e87-0c9bd9348d64)     |  ![simulator_screenshot_959DC56F-4209-4A7E-B756-BECB80E1853B](https://github.com/kwon416/wink/assets/95855658/495cdb5d-a25e-4d28-ab71-404ca0bd4e47)  |
|   푸시알림   |    코인 결제     | 프로필 |
|  ![simulator_screenshot_22481440-C121-4A6D-8930-38DFEF02C4E3](https://github.com/kwon416/wink/assets/95855658/c8d64db9-272e-4c69-925c-27728e8ebdaf)   |    ![simulator_screenshot_B9BBCE67-897C-4EEB-87F0-B2C942B3BE56](https://github.com/kwon416/wink/assets/95855658/c429add3-b072-4680-ba5a-47e34e9417ed)     |  ![Simulator Screenshot - iPhone 15 Pro Max - 2024-02-27 at 13 52 53](https://github.com/kwon416/wink/assets/95855658/0be7b0b2-878d-481a-a7e3-b1f20f8531bd)  |
|  프로필 수정  |    친구 초대     |   설정    |
|  ![simulator_screenshot_E335AB46-9371-49B2-A9BF-C597EA428DA7](https://github.com/kwon416/wink/assets/95855658/8e534563-6e8e-4bb0-9871-c739f909294a)   |    ![simulator_screenshot_CCBA6A34-BF02-4F18-91E4-091A2B9C769F](https://github.com/kwon416/wink/assets/95855658/cd9be301-1757-4569-8d92-b0f8ed7cd7be)     |  ![simulator_screenshot_C961A9C6-876F-436B-9583-0A488F64BF15](https://github.com/kwon416/wink/assets/95855658/a71ae023-4454-4745-a1ef-2c08c96978ae)  |


# CI/CD

## FastLane

android / ios Dir 에서

```
$ bundle install
```

plugin 추가
```
$ fastlane add_plugin [플러그인 이름]
```

memo: badge 플러그인은 imagemagick 라이브러리를 사용함
```
$ brew install imagemagick
```


### 배포 방법 (현재 로컬만, 깃허브 액션도 추후 추가)

lane: beta(내부 테스트 및 테스트 플라이트), release(스토어 배포)
env: production, staging
```
$ fastlane [lane 이름] --env [환경변수 파일 이름]
```


