show tables;

create table sBoard (
  idx  int not null auto_increment,		/* 게시글의 고유번호 */
  mid  varchar(20) not null,					/* 게시글 올린이 아이디 */
  title varchar(100)   not null,			/* 게시글 제목 */
  content text not null,							/* 글 내용 */
  readNum int default 0,							/* 글 조회수 */
  openSw	char(2)  default 'OK',			/* 게시글 공개여부(OK:공개, NO:비공개) */
  wDate		datetime default now(),			/* 글쓴 날짜 */
  part		varchar(20) not null,				/* 게시판분류(공지사항/문의사항/이벤트) */
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

select * from sBoard;

select count(*) from sBoard where part = '문의사항';

/* 댓글 달기 */
create table sBoardReply (
  idx       int not null auto_increment,	/* 댓글 고유번호 */
  boardIdx  int not null,						/* 원본글(부모글)의 고유번호-외래키로 지정 */
  re_step   int not null,           /* 레벨(re_step)에 따른 들여쓰기(계층번호): 부모댓글의 re_step는 0이다. 대댓글의 경우는 '부모re_step+1'로 처리한다. */
  re_order  int not null,           /* 댓글의 순서를 결정한다. 부모댓글을 1번, 대댓글의 경우는 부모댓글보다 큰 대댓글은 re_order+1 처리하고, 자신은 부모댓글의 re_order보다 +1 처리한다. */  
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

