package com.spring.javaclassS12.service;

import java.util.List;

import com.spring.javaclassS12.vo.CardVO;

public interface CardService {

	public int setCardSignup(CardVO vo);

	public List<CardVO> getCardInfor(String mid);




}
