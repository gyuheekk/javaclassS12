package com.spring.javaclassS12.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/kakao")
public class KakaoController {

	//카카오맵 화면보기(은행 아이콘 누르면 은행 지점 마커표시하기)
  @RequestMapping(value = "/kakaoMap", method = RequestMethod.GET)
  public String kakaoMapGet() { 
  	return "kakao/kakaoMap";
  }
	 
}

