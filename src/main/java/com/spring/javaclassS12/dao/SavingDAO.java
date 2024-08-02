package com.spring.javaclassS12.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS12.vo.SavingVO;

public interface SavingDAO {

	public int setSavingSignup(@Param("vo") SavingVO vo);

	public SavingVO getSavingIdCheck(@Param("mid") String mid, @Param("savingSw") String savingSw);

	public List<SavingVO> getSavingInfor(@Param("mid") String mid);





}
