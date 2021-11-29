# YaSickMaCha

```
git clone [link]
```

eclipse
1. import...
2. General -> Existing Projects into Workspace
3. Select root directory에 clone 받은 프로젝트
4. Finish

## 실행 및 사용방법
- Oracle DB USERID = db11, USERPWD = db11
- `http://localhost:8080/YaSickMaCha/index.jsp` 로 접속하여 시작

## 제작 환경
- JDK 16, JRE 16
- Oracle (19c), Eclipse, SQL developer

## 기능
### 학생
- 학번, 비밀번호, 이름, 휴대폰 번호, 전공을 입력하여 회원가입 및 로그인
- 야식마차 조회, 신청
- 수령한 메뉴에 대한 후기 작성 및 삭제
- 회원 정보 변경 및 탈퇴

### 관리자
- 아이디, 비밀번호를 입력하여 로그인
- 진행 중인 야식마차 현황을 이용하여 메뉴 수령 여부 변경
- 학생 정보 변경
- 메뉴 추가 및 수정

## 동시성 제어
`SELECT ~ FOR UPDATE` 구문을 이용하여 메뉴 신청에 대한 다중 사용자 동시성 제어를 수행 (in menuInfoUpdate.jsp)

## Contributor
![고재철](https://github.com/Go-Jaecheol)
![백성욱](https://github.com/SeongukBaek)
![백승찬](https://github.com/Backseungchan)
