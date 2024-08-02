show tables;

/* 대출테이블(신용대출-13) */
create table sloanS (
	idx  					int not null auto_increment primary key,	/* 고유번호 */
	mid  					varchar(30) not null, 										/* 고객 아이디 */
	job  					varchar(30) not null,											/* 직업 */
	company 			varchar(30) not null,											/* 직장명 */
	position 			varchar(10) not null,											/* 직위 */
	workingPeriod varchar(10) not null,											/* 근무 기간 */
	monthlyIncome int not null,															/* 월 소득 */
	loanAmount 		int not null,															/* 대출 신청 금액 */
	loanPeriod  	int not null,															/* 대출 기간 */
	loanContent 	varchar(30) not null,											/* 대출 신청 목적 */
	interesRate 	decimal(5,2) not null,										/* 이자율 */
	repaymentMethod char(1) not null, 									/* 상환 방식(원금균등상환:X, 만기일시상환:Y) */
	status varchar(10) not null default 'R', 								/* 상품 상태(신청:R, 승인:A, 만기:E) */
  foreign key(mid) references sMember(mid)
);
desc sloanS;
drop table sloanS;

/* 대출테이블(학자금대출-13) */
create table sloanH (
	idx  					int not null auto_increment primary key,	/* 고유번호 */
	mid  					varchar(30) not null, 										/* 고객 아이디 */
	school  			varchar(30) not null,											/* 학교명 */
	major 				varchar(30) not null,											/* 학과 */
	grade 				int not null,															/* 학년 */
	studentNumber int not null,															/* 학번 */
	tuition 			int not null,															/* 등록금 금액 */
	loanAmount 		int not null,															/* 대출 신청 금액 */
	loanPeriod  	int not null,															/* 대출 기간 */
	loanContent 	varchar(30) not null,											/* 대출 신청 목적 */
	interesRate 	decimal(5,2) not null,										/* 이자율 */
	repaymentMethod varchar(20) not null, 									/* 상환 방식 */
	status varchar(10) not null default 'R', 								/* 상품 상태(신청:R, 승인:A, 만기:E) */
  foreign key(mid) references sMember(mid)
);
desc sloanH;
drop table sloanH;

/*
/* 대출테이블(자동차대출) */
create table sloanJ (
	idx  						int not null auto_increment primary key,	/* 고유번호 */
	mid  						varchar(30) not null, 										/* 고객 아이디 */
	carKind  				varchar(30) not null,											/* 자동차 종류 */
	carManufacturer varchar(30) not null,											/* 자동차 제조사 */
	carModel 				varchar(30) not null,											/* 자동차 모델명 */
	carNumber 			varchar(30) not null,											/* 등록금 금액 */
	monthlyIncome 	int not null,															/* 등록금 금액 */
	loanAmount 			int not null,															/* 대출 신청 금액 */
	loanPeriod  		int not null,															/* 대출 기간 */
	loanContent 	varchar(30) not null,												/* 대출 신청 목적 */
	interesRate decimal(5,2) not null,												/* 이자율 */
	repaymentMethod varchar(20) not null, 										/* 상환 방식 */
	status varchar(10) not null default 'R', 									/* 상품 상태(신청:R, 승인:A, 만기:E) */
  foreign key(mid) references sMember(mid)
);
desc sloanJ;
drop table sloanJ;
*/

/* 대출테이블(예/적금 담보대출-13) */
create table sloanM (
	idx  					int not null auto_increment primary key,	/* 고유번호 */
	mid  					varchar(30) not null, 										/* 고객 아이디 */
	savingName  	varchar(30) not null,											/* 자동차 종류 */
	savingAccount varchar(30) not null,											/* 자동차 제조사 */
	StartDate 		datetime not null,												/* 자동차 모델명 */
	savingPeriod 	int not null,															/* 등록금 금액 */
	expiryDate 		datetime not null,												/* 등록금 금액 */
	loanAmount 		int not null,															/* 대출 신청 금액 */
	loanPeriod  	int not null,															/* 대출 기간 */
	loanContent 	varchar(30) not null,											/* 대출 신청 목적 */
	interesRate decimal(5,2) not null,											/* 이자율 */
	repaymentMethod varchar(20) not null, 									/* 상환 방식 */
	status varchar(10) not null default 'R', 								/* 상품 상태(신청:R, 승인:A, 만기:E) */
  foreign key(mid) references sMember(mid)
);
desc sloanM;
drop table sloanM;

/* 월별 상환 내역테이블 */
create table sLoanRepayment (
	idx 							 	 int not null auto_increment primary key, /* 대출상환 고유 일련번호 */
	mid  							 	 varchar(30) not null, 										/* 고객 아이디 */
	loanName 					 	 int not null,                        		/* 대출 종류 */
	everyRepaymentAmount 	 	 decimal(5,2) not null,             			/* 매 달 상환 금액 */
	principalAmount 	 	 decimal(5,2),             								/* 상환한 원금 */
	remainingPrincipal 	 decimal(5,2),             								/* 상환한 원금 */
	remainingPrincipal 	 decimal(5,2),														/* 남은 원금 */
	interestAmount 		 	 decimal(5,2) not null,              			/* 상환한 이자 */
	repaymentDate 		 	 datetime default now(),     							/* 상환 날짜 */
	foreign key(mid) references sMember(mid)
);

/* 대출 상환테이블 */
create table sLoanRepayment (
	idx 						int not null auto_increment primary key,  /* 대출상환 고유 일련번호 */
	mid  						varchar(30) not null, 										/* 고객 아이디 */
	loanName 				int not null,                        			/* 대출 종류 */
	repaymentAmount decimal(5,2) not null,             				/* 총 상환 금액 */
	principalAmount decimal(5,2) not null,             				/* 상환한 원금 */
	interestAmount 	decimal(5,2) not null,              			/* 상환한 이자 */
	repaymentDate 	datetime default now(),     							/* 상환 날짜 */
	foreign key(mid) references sMember(mid)
);

desc sLoanRepayment;
drop table sLoanRepayment;