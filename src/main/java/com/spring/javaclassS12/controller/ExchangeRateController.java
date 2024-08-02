package com.spring.javaclassS12.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaclassS12.service.ExchangeRateService;
import com.spring.javaclassS12.vo.ExchangeRateVO;

@Controller
@RequestMapping("/exchangeRate")
public class ExchangeRateController {
	
	@Autowired
	ExchangeRateService exchangeRateService;

	//환율계산하기 폼보기
	 @RequestMapping(value = "/exchangeRate", method = RequestMethod.GET)
	 public String exchangeRateGet(Model model,
	 		@RequestParam(name="searchdate", defaultValue="",required=false) String searchdate) {
	 	if(searchdate.equals("")) {
				Date today = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				searchdate = sdf.format(today);
	 	}
	 	List<ExchangeRateVO> unitVos = exchangeRateService.getExchangeRateUnit(searchdate);
	 	model.addAttribute("searchdate", searchdate);
	 	model.addAttribute("unitVos", unitVos);
	 	//System.out.println(unitVos);
	 	return "exchangeRate/exchangeRate";
	 }
	 
	 // 환율api에서 가져와서 지정된 날짜의 환율 보여주기
	 @ResponseBody
	 @RequestMapping(value="/exchangeRate", method=RequestMethod.POST, produces="application/text; charset=utf-8")
	 public String exchangeRatePost(String searchdate,
	 		@RequestParam(name = "receiveCountry", defaultValue = "", required = false) String receiveCountry){
	   return exchangeRateService.getCurrencyRate(receiveCountry, searchdate);
	 }
	 
	 // 환율api에서 환률가져와서 송금달라입력시 해당 송금액을 원화로 계산한 결과를 리턴해주기
	 @ResponseBody
	 @RequestMapping(value="/exchangeRateCompute", method=RequestMethod.POST, produces="application/text; charset=utf-8")
	 public String exchangeRateComputePost(String searchdate,
	 		@RequestParam(name = "receiveCountry", defaultValue = "", required = false) String receiveCountry,
	 		@RequestParam(name = "sendAmount", defaultValue = "0", required = false) String sendAmount
	 	){
	 	return exchangeRateService.getCurrencyRateCompute(receiveCountry, sendAmount, searchdate);
	 }
	
}

