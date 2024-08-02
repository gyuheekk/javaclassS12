package com.spring.javaclassS12.service;

import java.util.List;

import com.spring.javaclassS12.vo.SavingVO;

public interface SavingService {

	public int setSavingSignup(SavingVO vo);

	public SavingVO getSavingIdCheck(String mid, String savingSw);

	public String createSavingAccount();

	public List<SavingVO> getSavingInfor(String mid);





}
