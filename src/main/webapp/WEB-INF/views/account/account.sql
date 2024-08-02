show tables;

/* 거래내역 테이블 */
create table sAccount (
  idx  int not null auto_increment,							/* 계좌 고유 일련번호 */
  mid  varchar(30) not null,										/* 계좌가지고 있는 고객아이디 */
  flagSw char(1)   not null default 'C', 				/* I:입금,  C:출금, E:계좌출금, G:계좌입금 */
  money	 int	not null default 0, 							/* 계좌 입/출금액 */
  content varchar(50) not null default '통장개설',	/* 계좌 입/출금 내역(적요) */
  accDate datetime	default now(),							/* 입출금 날짜 */
  primary key(idx),
  foreign key (mid) references sMember(mid)
);

desc sAccount;
drop table sAccount;
delete from sAccount;

select * from sAccount where mid = 'admin' and flagSw = 'C' order by idx desc;
select * from sAccount where mid = 'admin' and flagSw = 'I' order by idx desc;
select * from sAccount where mid = 'admin';

insert into sAccount values (default, 'admin',default,default,default,default);
insert into sAccount values (default, 'admin','I',default,default,default);
insert into sAccount values (default, 'hkd1234',default,default,default,default);
insert into sAccount values (default, 'atom1234',default,default,default,default);
insert into sAccount values (default, 'btom1234',default,default,default,default);
insert into sAccount values (default, 'ctom1234',default,default,default,default);
insert into sAccount values (default, 'dtom1234',default,default,default,default);
insert into sAccount values (default, 'etom1234',default,default,default,default);
insert into sAccount values (default, 'ftom1234',default,default,default,default);
insert into sAccount values (default, 'gtom1234',default,default,default,default);
insert into sAccount values (default, 'htom1234',default,default,default,default);

select max(money) from sAccount; 

select * from sAccount where datediff(now(), accDate) = 0;
select count(*) from sAccount where datediff(now(), accDate) = 0;

select count(*) from sAccount where flagSw = 'I' and datediff(now(), accDate) = 0;
select count(*) from sAccount where flagSw = 'C' and datediff(now(), accDate) = 0;
select count(*) from sAccount where flagSw = 'E' and datediff(now(), accDate) = 0;
select count(*) from sAccount where flagSw = 'G' and datediff(now(), accDate) = 0;

select count(*) from sAccount where datediff(now(), accDate) = 0 and flagSw = 'G';
select * from sAccount order by idx desc limit 0,10;

select * from sAccount where flagSw = 'I' and	datediff(now(), accDate) = 0 order by idx desc limit 0,10;

select * from sAccount where flagSw = 'I' and datediff(now(), accDate) = 0 order by idx desc limit 0,10;

select count(*) from sAccount where now();

select count(*) from sAccount where datediff(now(), accDate) = 0;

select * from sAccount where mid = 'admin' order by idx desc limit 1;

select * from sAccount where mid = 'admin' order by idx desc;

select * from sAccount;

select * from sMember where mid='admin' and accountNumber='11111';

select * from sMember where accountNumber='240-528-207480';

select sum(money) as balance from sAccount where (mid='admin' and flagSw='I') or (mid='admin' and flagSw='G');
select sum(money) as balance from sAccount where (mid='admin' and flagSw='C') or (mid='admin' and flagSw='E');

select(select sum(money) from sAccount where (mid='admin' and flagSw='I') or (mid='admin' and flagSw='G')) - (select sum(money) from sAccount where (mid='admin' and flagSw='C') or (mid='admin' and flagSw='E')) as balance;

select(select sum(money) from sAccount where (flagSw='I') or (flagSw='G')) - (select sum(money) from sAccount where (flagSw='C') or (flagSw='E')) as balance;

select (select sum(money) from sAccount where (mid='admin' and flagSw='I') or (mid='dtom1234' and flagSw='G'))
					- (select sum(money) from sAccount where (mid='dtom1234' and flagSw='C') or (mid='dtom1234' and flagSw='E')) as balance;
					
select sum(money) as balance from sAccount where (mid='admin' and flagSw='I') or (mid='admin' and flagSw='G');
select sum(money) as balance from sAccount where (mid='admin' and flagSw='C') or (mid='admin' and flagSw='E');

select sum(money) from sAccount where (flagSw='I') or (flagSw='G'); /* 총 입금액 */
select sum(money) from sAccount where (flagSw='C') or (flagSw='E'); /* 총 출금액 */

select(select sum(money) from sAccount where (flagSw='I') or (flagSw='G'))
- (select sum(money) from sAccount where (flagSw='C') or (flagSw='E'));

select sum(money) as balance from sAccount where mid='atom1234' and flagSw = 'I';
select sum(money) as balance from sAccount where mid='admin' and flagSw = 'C';
select sum(money) as balance from sAccount where mid='admin' and flagSw = 'C' or flagSw = 'G';

/* 즐겨찾기 계좌 등록 테이블*/
create table sAccountFavorite (
  idx  int not null auto_increment,		/* 계좌 고유 일련번호 */
  myId  varchar(30) not null,					/* 자신아이디 */
  youId varchar(30) not null,					/* 계좌가지고 있는 고객아이디 */
  accountNumber char(14) not null,		/* 계좌 번호 */
  primary key(idx),
  foreign key (myId) references sMember(mid),
  foreign key (youId) references sMember(mid)
);
desc sAccountFavorite;
drop table sAccountFavorite;

select * from sAccountFavorite where myId = 'admin';

insert into sAccountFavorite values (default,'admin','hkd1234','991-231-789456');
insert into sAccountFavorite values (default,'admin','atom1234','240-702-042673');

delete from sAccountFavorite where idx = 1;