package com.spring.javaclassS12.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS12.dao.LoanDAO;
import com.spring.javaclassS12.vo.LoanSVO;

@Service
public class LoanServiceImpl implements LoanService {

	@Autowired
	LoanDAO loanDAO;
	
	@Override
	public int setLoanSInput(LoanSVO vo) {
		return loanDAO.setLoanSInput(vo);
	}


}
