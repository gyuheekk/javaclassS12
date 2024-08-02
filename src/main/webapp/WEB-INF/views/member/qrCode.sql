show tables;

create table sQrCode (
	idx 				int not null auto_increment primary key,
	mid 				varchar(20) not null,
	name 				varchar(20) not null,
	publishDate varchar(30) not null, /* QR코드 발행일자 */
	foreign key(mid) references sMember(mid)
);

desc sQrCode;