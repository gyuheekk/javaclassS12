package com.spring.javaclassS12.service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS12.dao.SavingDAO;
import com.spring.javaclassS12.vo.SavingVO;

@Service
public class SavingServiceImpl implements SavingService {
	
	@Autowired
	SavingDAO savingDAO;

	@Override
	public int setSavingSignup(SavingVO vo) {
		
		// 납입 기간에 따른 만료일자
		int paymentPeriod = vo.getPaymentPeriod(); 
		LocalDate expiryDate = null; // 만기일
		LocalDate startDate = LocalDate.now(); // 현재 날짜를 시작일로 설정
		String startDateString = startDate.toString(); // LocalDate를 String으로 변환
		vo.setStartDate(startDateString);

		if (paymentPeriod == 6) {
		    expiryDate = startDate.plusMonths(6);
		}
		else if (paymentPeriod == 12) {
	    expiryDate = startDate.plusMonths(12);
		}
		else if (paymentPeriod == 24) {
	    expiryDate = startDate.plusMonths(24);
		}
		else {
			expiryDate = startDate.plusMonths(36);
		}

		// 날짜를 원하는 형식의 문자열로 변환
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		String expiryDateString = expiryDate.format(formatter);

		vo.setExpiryDate(expiryDateString);
		
		// 예/적금 이자율 저장 & 적금일때 총 납입액 저장
		double interest = 0.0;
		if(vo.getSavingSw().equals("Y")) {
			interest = 2.5;
			vo.setInterest(interest);
		}
		else { 
			double total_deposit = 0.0;
			if(vo.getPaymentPeriod() == 12) {
				total_deposit = vo.getAmount()*12;
			}
			else if(vo.getPaymentPeriod() == 24) {
				total_deposit = vo.getAmount()*24;
			}
			else {
				total_deposit = vo.getAmount()*36;
			}
			interest = 2.8;
			vo.setInterest(interest);
			vo.setTotal_deposit(total_deposit);
		}
		
		// 만기시 원금+이자 (세액공제 전 금액)
		double totalAmount = 0.0;
		// 예금일때
		if(vo.getSavingSw().equals("Y")) {
			if(vo.getPaymentPeriod() == 6) {
				totalAmount = vo.getAmount() + vo.getAmount()*0.025/2;
				vo.setTotalAmount(totalAmount);
			}
			else if(vo.getPaymentPeriod() == 12) {
				totalAmount = vo.getAmount() + vo.getAmount()*0.025;
				vo.setTotalAmount(totalAmount);
			}
			else {
				totalAmount = vo.getAmount() + vo.getAmount()*0.025*2;
				vo.setTotalAmount(totalAmount);
			}
		}
		
		// 적금일때
		else {
			double interestJ = 0.0; // 적금이자
			if(vo.getPaymentPeriod() == 12) {
				double totInterestJ = 0.0; // 적금이자 총합
				for (int i = 12; i >= 1; i--) {
					interestJ = vo.getAmount() * 0.028 * i / 12;
					totInterestJ += interestJ;
				}
				totalAmount = vo.getAmount()*12 + totInterestJ;
				vo.setTotalAmount(totalAmount);
			}
			
			else if(vo.getPaymentPeriod() == 24) {
				double totInterestJ = 0.0; // 적금이자 총합
				for (int i = 24; i >= 1; i--) {
					interestJ = vo.getAmount() * 0.028 * i / 12;
					totInterestJ += interestJ;
				}
				totalAmount = vo.getAmount()*24 + totInterestJ;
				vo.setTotalAmount(totalAmount);
			}
			
			else {
				double totInterestJ = 0.0; // 적금이자 총합
				for (int i = 36; i >= 1; i--) {
					interestJ = vo.getAmount() * 0.028 * i / 12;
					totInterestJ += interestJ;
				}
				totalAmount = vo.getAmount()*36 + totInterestJ;
				vo.setTotalAmount(totalAmount);
			}
		}
		
		// 예상 이자 & 세금
		double tax;
		if(vo.getSavingSw().equals("Y")) {
			if(vo.getPaymentPeriod() == 6) {
				interest = vo.getAmount()*0.025/2;
				tax = interest * 0.154;
				vo.setExpectedTax(tax);
				vo.setExpectedInterest(interest);				
			}
			else if(vo.getPaymentPeriod() == 12) {
				interest = vo.getAmount()*0.025;
				tax = interest * 0.154;
				vo.setExpectedTax(tax);
				vo.setExpectedInterest(interest);				
			}
			else {
				interest = vo.getAmount()*0.025*2;
				tax = interest * 0.154;
				vo.setExpectedTax(tax);
				vo.setExpectedInterest(interest);				
			}
		}
		else {
				if(vo.getPaymentPeriod() == 12) {
				double totInterestJ = 0.0; // 적금이자 총합
				double interestJ = 0.0; // 적금이자 총합
				for (int i = 12; i >= 1; i--) {
					interestJ = vo.getAmount() * 0.028 * i / 12;
					totInterestJ += interestJ;
				}
				tax = Math.round(totInterestJ * 0.154);
				vo.setExpectedInterest(totInterestJ);
				vo.setExpectedTax(tax);
			}
				else if(vo.getPaymentPeriod() == 24) {
					double totInterestJ = 0.0; // 적금이자 총합
					double interestJ = 0.0; // 적금이자 총합
					for (int i = 24; i >= 1; i--) {
						interestJ = vo.getAmount() * 0.028 * i / 12;
						totInterestJ += interestJ;
					}
					tax = Math.round(totInterestJ * 0.154);
					vo.setExpectedInterest(totInterestJ);
					vo.setExpectedTax(tax);
				}
				else {
					double totInterestJ = 0.0; // 적금이자 총합
					double interestJ = 0.0; // 적금이자 총합
					for (int i = 36; i >= 1; i--) {
						interestJ = vo.getAmount() * 0.028 * i / 12;
						totInterestJ += interestJ;
					}
					tax = Math.round(totInterestJ * 0.154);
					vo.setExpectedInterest(totInterestJ);
					vo.setExpectedTax(tax);
				}
		}
		
		// 세후 실수령액
		double a = vo.getTotalAmount(); 
		double b = vo.getExpectedTax();
    double result = a - b;
    vo.setExpected_tax_amount(result);
		
		 
		return savingDAO.setSavingSignup(vo);
	}

	@Override
	public SavingVO getSavingIdCheck(String mid, String savingSw) {
		return savingDAO.getSavingIdCheck(mid, savingSw);
	}

	@Override
	public String createSavingAccount() {
		// 신청한 예/적금 계좌번호 발급 (난수 12자리 -> 123-123-123123)
		int rand = 0;
		String strRand = "";
		for(int i=0; i<12; i++) {
			rand = (int)(Math.random()*10);
			strRand += rand + "";
		}
		return strRand.substring(0,3)+"-"+strRand.substring(3,6)+"-"+strRand.substring(6);
	}

	@Override
	public List<SavingVO> getSavingInfor(String mid) {
		return savingDAO.getSavingInfor(mid);
	}

}
