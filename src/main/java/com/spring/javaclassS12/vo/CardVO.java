package com.spring.javaclassS12.vo;

import lombok.Data;

@Data
public class CardVO {
	private int idx;
	private String mid;
	private String cardSw;
	private String cardContent;
	private String cardIssuedDate;
	private String cardExpiryDate;
	private String cardNumber;
}
