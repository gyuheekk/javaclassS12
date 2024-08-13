show tables;

/* 게시판 테이블 */
create table sBoard (
  idx  int not null auto_increment,		/* 게시글의 고유번호 */
  mid  varchar(20) not null,					/* 게시글 올린이 아이디 */
  title varchar(100)   not null,			/* 게시글 제목 */
  content text not null,							/* 글 내용 */
  readNum int default 0,							/* 글 조회수 */
  openSw	char(2)  default 'OK',			/* 게시글 공개여부(OK:공개, NO:비공개) */
  wDate		datetime default now(),			/* 글쓴 날짜 */
  part		varchar(20) not null,				/* 게시판분류(공지사항/faq) */
  primary key(idx),										/* 기본키 : 고유번호 */
  foreign key(mid) references sMember(mid)
);
drop table sBoard;
desc sBoard;

insert into sBoard values (default,'admin','게시판 서비스를 시작합니다.','즐거운 게시판생활 되세요.',default,default,default,'공지사항');
insert into sBoard values (default,'atom1234','대출 문의','대출 상품 언제 출시되나요??',default,default,default,'문의사항');
insert into sBoard values (default,'hkd1234','카드발급 문의','카드 발급 했는데, 실물카드로도 받을 수 있어요?',default,default,default,'문의사항');
insert into sBoard values (default,'admin','출석이벤트','7월 출석이벤트를 시작합니다!',default,default,default,'이벤트');
insert into sBoard values (default,'admin','산불조심','건조한 날씨 산불 조심하세요',default,default,default,'공지사항');
insert into sBoard values (default,'admin','출석이벤트','8월 출석이벤트를 시작합니다!',default,default,default,'이벤트');
insert into sBoard values (default,'admin','보이스피싱 예방','보이스피싱 사기 조심하세요!',default,default,default,'공지사항');
insert into sBoard values (default,'btom1234','예적금','예적금 상품은 없나요??',default,default,default,'문의사항');
insert into sBoard values (default,'admin','이용제한','사이트 점검일이라 사이트 이용이 제한됩니다.',default,default,default,'공지사항');
insert into sBoard values (default,'admin','룰렛이벤트','7월 룰렛이벤트 시작합니다.',default,default,default,'이벤트');
insert into sBoard values (default,'ctom1234','사이트문의','알림 서비스는 없나요??',default,default,default,'문의사항');

INSERT INTO sBoard (idx, mid, title, content, readNum, openSw, wDate, part) VALUES
(default, 'admin', '게시판 서비스를 시작합니다.', '즐거운 게시판 생활 되세요.', default, default, '2024-07-01 10:00:00', '공지사항'),
(default, 'admin', '회원가입 방법', 'Q: 회원가입은 어떻게 하나요?\nA: 회원가입은 상단의 회원가입 버튼을 클릭하고 필요한 정보를 입력하시면 됩니다.', default, default, '2024-07-02 11:00:00', 'FAQ'),
(default, 'admin', '새로운 기능 업데이트 안내', '여러분의 의견을 반영하여 새로운 기능이 추가되었습니다.', default, default, '2024-07-03 12:00:00', '공지사항'),
(default, 'admin', '비밀번호 재설정', 'Q: 비밀번호를 잊어버렸어요. 어떻게 재설정하나요?\nA: 로그인 페이지에서 비밀번호 재설정 버튼을 클릭하고 안내에 따라 진행하세요.', default, default, '2024-07-04 13:00:00', 'FAQ'),
(default, 'admin', '게시판 이용 규칙', '게시판 이용 시 준수해야 할 규칙을 안내드립니다.', default, default, '2024-07-05 14:00:00', '공지사항'),
(default, 'admin', '프로필 수정', 'Q: 프로필 정보를 어떻게 수정하나요?\nA: 로그인 후 마이페이지에서 프로필 수정 버튼을 클릭하여 수정할 수 있습니다.', default, default, '2024-07-06 15:00:00', 'FAQ'),
(default, 'admin', '정기 점검 안내', '서버 정기 점검으로 인한 서비스 일시 중단 안내입니다.', default, default, '2024-07-07 16:00:00', '공지사항'),
(default, 'admin', '게시글 작성 방법', 'Q: 게시글은 어떻게 작성하나요?\nA: 게시글 작성 버튼을 클릭하고 내용을 입력한 후 등록 버튼을 누르시면 됩니다.', default, default, '2024-07-08 17:00:00', 'FAQ'),
(default, 'admin', '이벤트 안내', '즐거운 이벤트에 참여하시고 푸짐한 선물을 받아가세요.', default, default, '2024-07-09 18:00:00', '공지사항'),
(default, 'admin', '첨부파일 추가', 'Q: 게시글에 첨부파일을 어떻게 추가하나요?\nA: 게시글 작성 시 첨부파일 추가 버튼을 클릭하여 파일을 업로드할 수 있습니다.', default, default, '2024-07-10 19:00:00', 'FAQ'),
(default, 'admin', 'FAQ 업데이트', '자주 묻는 질문(FAQ) 섹션이 업데이트되었습니다.', default, default, '2024-07-11 20:00:00', '공지사항'),
(default, 'admin', '댓글 작성 방법', 'Q: 게시글에 댓글을 어떻게 작성하나요?\nA: 게시글 하단의 댓글 작성란에 내용을 입력한 후 등록 버튼을 누르시면 됩니다.', default, default, '2024-07-12 21:00:00', 'FAQ'),
(default, 'admin', '회원 등급 변경 안내', '회원 등급 정책이 변경되었습니다. 자세한 내용은 공지사항을 확인하세요.', default, default, '2024-07-13 22:00:00', '공지사항'),
(default, 'admin', '이용약관 확인', 'Q: 이용약관은 어디서 확인할 수 있나요?\nA: 홈페이지 하단의 이용약관 링크를 클릭하여 확인할 수 있습니다.', default, default, '2024-07-14 23:00:00', 'FAQ'),
(default, 'admin', '보안 강화 조치', '계정 보안을 위해 새로운 보안 조치가 시행됩니다.', default, default, '2024-07-15 09:00:00', '공지사항'),
(default, 'admin', '탈퇴 방법', 'Q: 회원 탈퇴는 어떻게 하나요?\nA: 마이페이지에서 회원 탈퇴 버튼을 클릭하고 안내에 따라 진행하세요.', default, default, '2024-07-16 10:00:00', 'FAQ'),
(default, 'admin', '서비스 장애 복구 안내', '일시적인 서비스 장애가 복구되었습니다. 불편을 끼쳐 드려 죄송합니다.', default, default, '2024-07-17 11:00:00', '공지사항'),
(default, 'admin', '계정 복구', 'Q: 탈퇴한 계정을 복구할 수 있나요?\nA: 탈퇴한 계정은 복구할 수 없습니다. 새로운 계정을 생성해주세요.', default, default, '2024-07-18 12:00:00', 'FAQ'),
(default, 'admin', '게시판 업데이트', '게시판 시스템이 업데이트되었습니다. 새로운 기능을 확인해보세요.', default, default, '2024-07-19 13:00:00', '공지사항'),
(default, 'admin', '이메일 변경', 'Q: 회원가입 시 사용한 이메일을 변경할 수 있나요?\nA: 마이페이지에서 이메일 변경 버튼을 클릭하여 변경할 수 있습니다.', default, default, '2024-07-20 14:00:00', 'FAQ'),
(default, 'admin', '모바일 앱 출시', '이제 모바일 앱에서도 게시판을 이용하실 수 있습니다.', default, default, '2024-07-21 15:00:00', '공지사항'),
(default, 'admin', '알림 설정', 'Q: 게시글 알림 설정은 어떻게 하나요?\nA: 마이페이지에서 알림 설정을 클릭하여 원하는 알림을 설정할 수 있습니다.', default, default, '2024-07-22 16:00:00', 'FAQ'),
(default, 'admin', '운영 정책 변경', '운영 정책이 일부 변경되었으니 확인 부탁드립니다.', default, default, '2024-07-23 17:00:00', '공지사항'),
(default, 'admin', '비밀번호 변경', 'Q: 비밀번호는 어떻게 변경하나요?\nA: 로그인 후 마이페이지에서 비밀번호 변경 버튼을 클릭하여 변경할 수 있습니다.', default, default, '2024-07-24 18:00:00', 'FAQ'),
(default, 'admin', '서비스 일시 중단 안내', '서버 점검으로 인한 서비스 일시 중단 안내입니다.', default, default, '2024-07-25 19:00:00', '공지사항'),
(default, 'admin', '회원 등급 확인', 'Q: 현재 회원 등급을 확인할 수 있나요?\nA: 마이페이지에서 현재 회원 등급을 확인할 수 있습니다.', default, default, '2024-07-26 20:00:00', 'FAQ'),
(default, 'admin', '이용자 설문조사', '서비스 개선을 위한 이용자 설문조사에 참여해주세요.', default, default, '2024-07-27 21:00:00', '공지사항'),
(default, 'admin', '게시글 신고', 'Q: 부적절한 게시글을 어떻게 신고하나요?\nA: 게시글 하단의 신고 버튼을 클릭하여 신고할 수 있습니다.', default, default, '2024-07-28 22:00:00', 'FAQ'),
(default, 'admin', '새로운 테마 적용', '게시판에 새로운 테마가 적용되었습니다. 이용해보세요.', default, default, '2024-07-29 23:00:00', '공지사항'),
(default, 'admin', '접속 로그 확인', 'Q: 내 접속 로그는 어디서 확인할 수 있나요?\nA: 마이페이지에서 접속 로그 확인 버튼을 클릭하여 확인할 수 있습니다.', default, default, '2024-07-30 09:00:00', 'FAQ'),
(default, 'admin', '계정 보안 강화', '계정 보안을 위해 비밀번호를 주기적으로 변경해주세요.', default, default, '2024-07-31 10:00:00', '공지사항'),
(default, 'admin', '닉네임 변경', 'Q: 닉네임을 변경할 수 있나요?\nA: 마이페이지에서 닉네임 변경 버튼을 클릭하여 변경할 수 있습니다.', default, default, '2024-08-01 11:00:00', 'FAQ'),
(default, 'admin', '게시글 삭제', 'Q: 작성한 게시글을 삭제할 수 있나요?\nA: 게시글 하단의 삭제 버튼을 클릭하여 삭제할 수 있습니다.', default, default, '2024-08-02 12:00:00', 'FAQ'),
(default, 'admin', '공지사항 확인', 'Q: 사이트의 공지사항은 어디서 확인할 수 있나요?\nA: 홈페이지 상단의 공지사항 메뉴를 클릭하여 확인할 수 있습니다.', default, default, '2024-08-03 13:00:00', 'FAQ'),
(default, 'admin', '메시지 보내기', 'Q: 다른 회원에게 메시지를 보내는 방법은?\nA: 프로필 페이지에서 메시지 보내기 버튼을 클릭하여 메시지를 보낼 수 있습니다.', default, default, '2024-08-04 14:00:00', 'FAQ'),
(default, 'admin', '서비스 개선 요청', '서비스 개선 사항은 언제든지 건의해주세요.', default, default, '2024-08-05 15:00:00', '공지사항');


select * from sBoard;

select count(*) from sBoard where part = '문의사항';

/* 댓글 달기 */
create table sBoardReply (
  idx       int not null auto_increment,	/* 댓글 고유번호 */
  boardIdx  int not null,						/* 원본글(부모글)의 고유번호-외래키로 지정 */
  re_step   int not null,           /* 레벨(re_step)에 따른 들여쓰기(계층번호): 부모댓글의 re_step는 0이다.
  																		 대댓글의 경우는 '부모re_step+1'로 처리한다. */
  re_order  int not null,           /* 댓글의 순서를 결정한다. 부모댓글을 1번, 대댓글의 경우는 부모댓글보다 큰 대댓글은
  																		 re_order+1 처리하고, 자신은 부모댓글의 re_order보다 +1 처리한다. */  
  mid				varchar(20) not null,		/* 댓글 올린이의 아이디 */
  wDate			datetime	default now(),/* 댓글 올린 날짜/시간 */
  content		text not null,					/* 댓글 내용 */
  primary key(idx),
  foreign key(boardIdx) references sBoard(idx)
  on update cascade
  on delete restrict
);
desc sBoardReply;
drop table sBoardReply;

insert into sBoardReply values (default, 33, 'kms1234', default, '192.168.50.60','글을 참조 했습니다.');
insert into sBoardReply values (default, 32, 'kms1234', default, '192.168.50.12','다녀갑니다.');
insert into sBoardReply values (default, 34, 'kms1234', default, '192.168.50.12','멋진글이군요...');

select * from sBoardReply;

select * from sBoard;
select * from sBoard where idx = 9;  /* 현재글 */
select idx,title from sBoard where idx > 9 order by idx limit 1;  /* 다음글 */
select idx,title from sBoard where idx < 9 order by idx desc limit 1;  /* 이전글 */

-- 시간으로 비교해서 필드에 값 저장하기
select *, timestampdiff(hour, wDate, now()) as hour_diff from board2;

-- 날짜로 비교해서 필드에 값 저장하기
select *, datediff(wDate, now()) as date_diff from board2;

-- 관리자는 모든글 보여주고, 일반사용자는 비공개글(openSw='NO')과 신고글(complaint='OK')은 볼수없다. 단, 자신이 작성한 글은 볼수 있다.
select count(*) as cnt from board2;
select count(*) as cnt from board2 where openSW = 'OK' and complaint = 'NO';
select count(*) as cnt from board2 where mid = 'hkd1234';

select * from board2 where openSW = 'OK' and complaint = 'NO';
select * from board2 where mid = 'hkd1234';
select * from board2 where openSW = 'OK' and complaint = 'NO' union select * from board2 where mid = 'hkd1234';
select * from board2 where openSW = 'OK' and complaint = 'NO' union all select * from board2 where mid = 'hkd1234';

select count(*) as cnt from board2 where openSW = 'OK' and complaint = 'NO' union select count(*) as cnt from board2 where mid = 'hkd1234';
select sum(a.cnt) from (select count(*) as cnt from board2 where openSW = 'OK' and complaint = 'NO' union select count(*) as cnt from board2 where mid = 'hkd1234') as a;

select sum(a.cnt) from (select count(*) as cnt from board2 where openSW = 'OK' and complaint = 'NO' union select count(*) as cnt from board2 where mid = 'hkd1234' and (openSW = 'NO' or complaint = 'OK')) as a;

/* 댓글수 연습 */
select * from board2 order by idx desc;
select * from boardReply2 order by boardIdx, idx desc;

-- 부모글(10)의 댓글만 출력
select * from boardReply2 where boardIdx = 10;
select boardIdx,count(*) as replyCnt from boardReply2 where boardIdx = 10;

select * from board2 where idx = 10;
select *,(select count(*) from boardReply2 where boardIdx = 33) as replyCnt from board where idx = 10;
select *,(select count(*) from boardReply2 where boardIdx = b.idx) as replyCnt from board b;

