# Netflix-iOS
Netflix

### 🔗Link

**Source**

https://github.com/doyeonjeong/Netflix-iOS

## 📖 상세 내용
<img width="280" alt="1" src="https://github.com/doyeonjeong/Netflix-iOS/assets/108422901/0ffd8c95-bec4-446e-8691-abc3702342e5">
<img width="280" alt="2" src="https://github.com/doyeonjeong/Netflix-iOS/assets/108422901/aac0a37f-a103-44fc-8e35-30dafd0993d7">
<img width="280" alt="Transition 구현" src="https://github.com/doyeonjeong/Netflix-iOS/assets/108422901/2512a73e-edb2-4aaf-9a25-d35151d235ee">


## 💡 개발 배경
선배 개발자인 [Arex](https://github.com/kangddong)가 Netflix Clone을 강의 없이

Compositional Layout, Diffable DataSource, MVVM을 적용하여 구현해보라는 3주짜리 미션을 주셔서 진행해본 개인 프로젝트입니다.

진행했던 내용을 순차적으로 기록하기 위해 주차별 PR을 완료한 상태입니다.

코드리뷰 후 Merge 하기로 했습니다.

https://github.com/doyeonjeong/Netflix-iOS/pull/1

https://github.com/doyeonjeong/Netflix-iOS/pull/2

https://github.com/doyeonjeong/Netflix-iOS/pull/3


## 🛠️ 사용 기술 및 라이브러리

- Swift, iOS
- UIKit
- KMDB API
- Lottie
- Postman
- UICompositionalLayout, UICollectionViewDiffableDataSourse, NSDiffableDataSourceSnapshot
- NSCache, DispatchQueue, async/await, Task, URLSession

## 📱 담당한 기능

- **NSLayoutConstraint**를 사용한 오토 레이아웃
- **Lazy** 초기화
- **private** 메서드 및 **extension** 로직 분리
- **CompositionalLayout**과 **DiffableDataSourse**를 사용한 UI 구현

## 💡 깨달은 점

- `async/await` 문법은 비동기 작업을 도우나 그 자체로는 새로운 스레드를 생성하지 않음
- `Task { await }` 구문으로 비동기 작업을 백그라운드에 요청하여 멀티스레딩 상황을 관리함
- `DiffableDataSource`를 이용하여 동적인 UI 업데이트가 가능함
- `DispatchQueue` 를 이용하여 메인 스레드와 백그라운드 스레드를 적절한 시점에 사용
- `NSCache`를 이용하여 불러온 이미지 데이터의 캐시를 저장하면 빠른 로딩이 가능함
- `URLSession.dataTask` 가 기본적으로 `httpMethod`의 GET 요청을 한다는 것을 학습함
