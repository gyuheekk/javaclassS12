package com.spring.javaclassS12.service;

import java.util.List;

import com.spring.javaclassS12.vo.ExchangeRateVO;

public interface ExchangeRateService {

	public String getCurrencyRate(String receiveCountry, String searchdate);

	public List<ExchangeRateVO> getExchangeRateUnit(String searchdate);

	public String getCurrencyRateCompute(String receiveCountry, String sendAmount, String searchdate);





}
