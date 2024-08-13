package com.spring.javaclassS12.service;

import java.util.List;

import com.spring.javaclassS12.vo.LoanHVO;
import com.spring.javaclassS12.vo.LoanMVO;
import com.spring.javaclassS12.vo.LoanSVO;

public interface LoanService {

	public int setLoanSInput(LoanSVO vo);

	public LoanSVO getLoansIdCheck(String mid);

	public List<LoanSVO> getLoansInfor(String mid);

	public LoanHVO getLoanhIdCheck(String mid);

	public int setLoanHInput(LoanHVO vo);

	public List<LoanHVO> getLoanhInfor(String mid);

	public LoanMVO getLoanmIdCheck(String mid);

	public int setLoanMInput(LoanMVO vo);





}
