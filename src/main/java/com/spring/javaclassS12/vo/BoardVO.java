package com.spring.javaclassS12.vo;

import lombok.Data;

@Data
public class BoardVO {
	private int idx;
	private String mid;
	private String title;
	private String content;
	private int readNum;
	private String openSw;
	private String wDate;
	private String part;
	
	private int hour_diff; // 게시글 24시간 경과유무 체크
	private int date_diff; // 게시글 일자 경과유무 체크
	private int replyCnt; // 부모글의 댓글수를 저장하는 변수
	
}
