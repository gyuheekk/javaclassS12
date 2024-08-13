package com.spring.javaclassS12.service;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS12.dao.CardDAO;
import com.spring.javaclassS12.vo.CardVO;

@Service
public class CardServiceImpl implements CardService {
	
	@Autowired
	CardDAO cardDAO;

	@Override
	public int setCardSignup(CardVO vo) {
		// 카드번호 발급 (난수 16자리)
		int rand = 0;
		String strRand = "";
		for(int i=0; i<16; i++) {
			rand = (int)(Math.random()*10);
			strRand += rand + "";
		}
		
		// 카드번호 : 1234-1234-1234-1234
		String cardNumber = strRand.substring(0,4)+"-"+strRand.substring(4,8)+"-"+strRand.substring(8,12)+"-"+strRand.substring(12);
		vo.setCardNumber(cardNumber);
		
		// 카드 만료날짜 
		LocalDate localDate = LocalDate.now(); // 현재 날짜로 초기화
		LocalDate plusFiveYear = localDate.plusYears(5); // 5년을 더한 날짜 계산
		String cardExpiryDate = "";
		cardExpiryDate = plusFiveYear.toString(); // LocalDate를 문자열로 변환
		
		vo.setCardExpiryDate(cardExpiryDate);
		
		return cardDAO.setCardSignup(vo);
	}

	@Override
	public List<CardVO> getCardInfor(String mid) {
		return cardDAO.getCardInfor(mid);
	}


}
