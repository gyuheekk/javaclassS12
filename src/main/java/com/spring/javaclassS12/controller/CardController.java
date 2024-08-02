package com.spring.javaclassS12.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javaclassS12.service.CardService;
import com.spring.javaclassS12.service.MemberService;
import com.spring.javaclassS12.vo.CardVO;
import com.spring.javaclassS12.vo.MemberVO;

@Controller
@RequestMapping("/card")
public class CardController {
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	CardService cardService;
	
	// 카드 종류 소개 페이지
	@RequestMapping(value = "/cardProduct", method = RequestMethod.GET)
	public String cardProductGet() {
		return "card/cardProduct";
	}
	
	// 카드 신청 페이지
	@RequestMapping(value = "/cardSignup", method = RequestMethod.GET)
	public String cardSingupGet(HttpSession session, Model model, String flagSw) {
		String mid = (String) session.getAttribute("sMid");
		
		MemberVO vo = memberService.getMemberIdCheck(mid);
		
		model.addAttribute("vo", vo);
		model.addAttribute("flagSw", flagSw);
		
		return "card/cardSignup";
	}
	
	// 카드 발급 처리페이지
	@RequestMapping(value = "/cardSignup", method = RequestMethod.POST)
	public String cardSingupPost(CardVO vo) {
		
		int res = cardService.setCardSignup(vo);
		
		if(res != 0) return "redirect:/message/cardOk";
		else return "redirect:/message/cardNo";
	}
	
	// 발급받은 카드 정보 확인 페이지
	@RequestMapping(value = "/cardCheck", method = RequestMethod.GET)
	public String cardCheckGet(Model model, HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		List<CardVO> vos = cardService.getCardInfor(mid);
		
		model.addAttribute("vos", vos);
		
		return "card/cardCheck";
	}

}


