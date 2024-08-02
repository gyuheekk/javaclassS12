package com.spring.javaclassS12.vo;

import lombok.Data;

@Data
public class SavingVO {
	private int idx;
	private String mid;
	private String savingSw;
	private int amount;
	private double total_deposit;
	private String savingAccount;
	private String startDate;
	private int paymentPeriod;
	private double interest;
	private String expiryDate;
	private double totalAmount;
	private double expectedInterest;
	private double expectedTax;
	private double expected_tax_amount;
	private String status;
}
