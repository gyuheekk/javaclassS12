show tables;

create table saving (
    idx int auto_increment primary key,         		 -- 고유번호
    mid varchar(50) not null,                  			 -- 회원 ID
    savingSw char(1) not null,  										 -- 상품 유형 (예금:Y, 적금:J)
    amount decimal (15, 2) not null,  							 -- 예금: 예치금액, 적금: 월 납입액
    total_deposit decimal(15, 2) null,       			 	 -- 적금의 총 납입 금액 (예금은 NULL)
    savingAccount varchar(20) unique not null, 			 -- 계좌번호 (고유한 번호. 중복X)
    startDate date not null,                  			 -- 최초가입일
    PaymentPeriod int not null,										 	 -- 납입기간(개월 수)
    interest decimal(5, 2) not null,      					 -- 이자율 (%)
    expiryDate date not null,               				 -- 만기일
    totalAmount decimal(15, 2) not null, 						 -- 만기 시 예상 총액 (원금 + 이자)
    expectedInterest decimal(15, 2) not null, 			 -- 예상 이자
    expectedTax decimal(15, 2) not null,      			 -- 예상 세금
    expected_tax_amount decimal(15, 2) not null,  	 -- 세후 예상 실수령액 (총액-세금)
    status varchar(10) not null default 'A', 				 -- 상품 상태(활성:A, 만기:E, 해지:C)
    foreign key(mid) references sMember(mid)
);
    /*UNIQUE KEY `unique_mid_product` (mid, savingSw)*/  -- 한 사람당 예금 하나, 적금 하나만 가능하도록 제약
desc saving;
drop table saving;

-- 예금가입
insert into saving values (default,'admin','Y',1000000,null,'123-456-123456','2024-07-23',12,3.5,'2025-07-23',1035000,35000,5250,1029750,'A');

-- 적금 가입
insert into saving values (default,'admin','J',12000000,1000000,'234-456-123456','2024-07-23',12,3.5,'2025-07-23',1035000,35000,5250,1029750,'A');

select * from saving;