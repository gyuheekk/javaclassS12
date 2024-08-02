package com.spring.javaclassS12.vo;

import lombok.Data;

@Data
public class LoanHVO {
	//공통사항(8)
	private int idx;
	private String mid;
	private int loanAmount;
	private int loanPeriod;
	private String loanContent;
	private double interesRate;
	private String repaymentMethod;
	private String status;

	// 학자금대출(5)
	private String school;
	private String major;
	private int grade;
	private int studentNumber;
	private int tuition;
}
