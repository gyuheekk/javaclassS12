package com.spring.javaclassS12.vo;

import lombok.Data;

@Data
public class BoardReplyVO {
	private int idx;
	private int boardIdx;
	private int re_step;
	private int re_order;
	private String mid;
	private String wDate;
	private String content;
}
