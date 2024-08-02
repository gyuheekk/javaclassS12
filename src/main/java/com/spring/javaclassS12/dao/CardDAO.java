package com.spring.javaclassS12.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS12.vo.CardVO;

public interface CardDAO {

	public int setCardSignup(@Param("vo") CardVO vo);

	public List<CardVO> getCardInfor(@Param("mid") String mid);





}
