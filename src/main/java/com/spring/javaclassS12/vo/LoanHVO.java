package com.spring.javaclassS12.vo;

import lombok.Data;

@Data
public class LoanHVO {
	//공통사항(6)
	private int idx;
	private String mid;
	private int loanAmount;
	private double interesRate;
	private String repaymentMethod;
	private String status;

	// 학자금대출(7)
	private String school;
	private String major;
	private String admissionDate;
	private String graduationDate;
	private String grade;
	private String studentNumber;
	private int tuition;
}
