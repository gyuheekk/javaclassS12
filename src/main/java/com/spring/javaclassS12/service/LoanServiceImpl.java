package com.spring.javaclassS12.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS12.dao.LoanDAO;
import com.spring.javaclassS12.vo.LoanHVO;
import com.spring.javaclassS12.vo.LoanMVO;
import com.spring.javaclassS12.vo.LoanSVO;

@Service
public class LoanServiceImpl implements LoanService {

	@Autowired
	LoanDAO loanDAO;
	
	@Override
	public int setLoanSInput(LoanSVO vo) {
		return loanDAO.setLoanSInput(vo);
	}

	@Override
	public LoanSVO getLoansIdCheck(String mid) {
		return loanDAO.getLoansIdCheck(mid);
	}

	@Override
	public List<LoanSVO> getLoansInfor(String mid) {
		return loanDAO.getLoansInfor(mid);
	}

	@Override
	public LoanHVO getLoanhIdCheck(String mid) {
		return loanDAO.getLoanhIdCheck(mid);
	}

	@Override
	public int setLoanHInput(LoanHVO vo) {
		return loanDAO.setLoanHInput(vo);
	}

	@Override
	public List<LoanHVO> getLoanhInfor(String mid) {
		return loanDAO.getLoanhInfor(mid);
	}

	@Override
	public LoanMVO getLoanmIdCheck(String mid) {
		return loanDAO.getLoanmIdCheck(mid);
	}

	@Override
	public int setLoanMInput(LoanMVO vo) {
		return loanDAO.setLoanMInput(vo);
	}


}
