package com.spring.javaclassS12.vo;

import lombok.Data;

@Data
public class LoanSVO {
	// 공통사항(8)
	private int idx;
	private String mid;
	private int loanAmount;
	private int loanPeriod;
	private String loanContent;
	private double interesRate;
	private String repaymentMethod;
	private String status;

	// 신용대출(5)
	private String job;
	private String company;
	private String position;
	private String workingPeriod;
	private int monthlyIncome;
	
}
