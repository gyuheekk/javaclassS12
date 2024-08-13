package com.spring.javaclassS12.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS12.vo.LoanHVO;
import com.spring.javaclassS12.vo.LoanMVO;
import com.spring.javaclassS12.vo.LoanSVO;

public interface LoanDAO {

	public int setLoanSInput(@Param("vo") LoanSVO vo);

	public LoanSVO getLoansIdCheck(@Param("mid") String mid);

	public List<LoanSVO> getLoansInfor(@Param("mid") String mid);

	public LoanHVO getLoanhIdCheck(@Param("mid") String mid);

	public int setLoanHInput(@Param("vo") LoanHVO vo);

	public List<LoanHVO> getLoanhInfor(@Param("mid") String mid);

	public LoanMVO getLoanmIdCheck(@Param("mid") String mid);

	public int setLoanMInput(@Param("vo") LoanMVO vo);





}
