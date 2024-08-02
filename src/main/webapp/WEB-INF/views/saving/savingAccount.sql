show tables;

create table savingAccount (
	idx int not null auto_increment,
	mid varchar(30) not null,
	savingAccount varchar(20) unique not null,
	savingSw char(1) not null, -- 상품 유형 (예금:Y, 적금:J)
	money int not null,
	content varchar(50) not null,
	accDate datetime default now(),
	primary key(idx),
	foreign key(mid) references sMember(mid)
);
drop table savingAccount;



