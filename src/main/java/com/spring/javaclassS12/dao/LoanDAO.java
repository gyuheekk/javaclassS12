package com.spring.javaclassS12.dao;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS12.vo.LoanSVO;

public interface LoanDAO {

	public int setLoanSInput(@Param("vo") LoanSVO vo);





}
