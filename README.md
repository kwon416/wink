# wink

A new Flutter project.

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
$ brew install imagemagick



### 배포 방법 (현재 로컬만, 깃허브 액션도 추후 추가)

lane: beta(내부 테스트 및 테스트 플라이트), release(스토어 배포)
env: production, staging
```
$ fastlane [lane 이름] --env [환경변수 파일 이름]
```


