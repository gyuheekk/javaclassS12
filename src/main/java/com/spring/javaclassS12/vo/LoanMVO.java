package com.spring.javaclassS12.vo;

import lombok.Data;

@Data
public class LoanMVO {
	//공통사항(8)
	private int idx;
	private String mid;
	private int loanAmount;
	private int loanPeriod;
	private String loanContent;
	private double interesRate;
	private String repaymentMethod;
	private String status;

	// 예/적금 담보대출(5)
	private String savingName;
	private String savingAccount;
	private String StartDate;
	private int savingPeriod;
	private String expiryDate;
	
}
