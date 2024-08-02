show tables;

/* 카드 테이블 */
create table sCard (
	idx int not null auto_increment, 														/* 카드 고유 일련번호 */
	mid varchar(30) not null,																		/* 고객 아이디 */
	cardSw varchar(30) not null,																/* 카드 종류 (S:신용카드, C:체크카드, H:학생카드) */
	cardContent varchar(50) not null,														/* 카드 발급 목적 */
	cardIssuedDate datetime default now(),											/* 카드 발급 날짜 */
	cardExpiryDate datetime default now(),											/* 카드 만료 날짜 (발급일로부터 5년) */
	cardNumber char(19) not null default '1234-1234-1234-1234',	/* 카드번호 (난수 '4-4-4-4') */
	primary key(idx),
  foreign key(mid) references sMember(mid)
);
desc sCard;
drop table sCard;

insert into sCard values (default,'admin','S','신용카드 할인혜택',default,default,default);
insert into sCard values (default,'admin','H','신용카드 할인혜택',default,default,default);

select * from sCard;

select * from sCard where mid = 'admin';