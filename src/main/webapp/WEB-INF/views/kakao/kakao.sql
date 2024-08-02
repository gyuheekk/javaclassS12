show tables;

create table sKakaoAddress (
	address varchar(50) not null, /* 지점명 */
	latitude  double not null, 		/* 위도 */
	longitude double not null 		/* 경도 */
)
desc sKakaoAddress;
drop table sKakaoAddress;

select * from sKakaoAddress order by address;

delete from sKakaoAddress;
