package com.spring.javaclassS12.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaclassS12.service.LoanService;
import com.spring.javaclassS12.service.MemberService;
import com.spring.javaclassS12.vo.LoanSVO;
import com.spring.javaclassS12.vo.MemberVO;

@Controller
@RequestMapping("/loan")
public class LoanController {
	
	@Autowired
	MemberService memberService;

	@Autowired
	LoanService loanService;
	
	// 대출상품 소개 창 띄우기
	@RequestMapping(value = "/loanProduct", method = RequestMethod.GET)
		public String loanProductGet() {
		return "loan/loanProduct";
	}
	
	//대출 신청 페이지 - 1단계 개인정보 입력
	@RequestMapping(value = "/loanSignup", method = RequestMethod.GET)
	public String loanSignupGet(Model model, String loanSw) {
		model.addAttribute("loanSw", loanSw);
		return "loan/loanSignup";
	}
	
	//대출 신청 페이지 - 1단계 개인정보 입력란 확인
	@ResponseBody
	@RequestMapping(value = "/loanSignup", method = RequestMethod.POST)
	public String loanS1POST(HttpSession session, Model model, String name,
			String birth, String tel, String email) {
		// 입력한 개인정보가 현재 로그인한 사람의 정보와 일치하는지 확인
		String mid = (String) session.getAttribute("sMid");
		MemberVO vo = memberService.getMemberIdCheck(mid);
		String Birth = vo.getBirth().substring(0,10);
		//System.out.println("Birth : " + Birth);
		//System.out.println("vo : " + vo);
		//System.out.println("mid(내가 입력한 값) : " + mid);
		//System.out.println("name(내가 입력한 값) : " + name);
		//System.out.println("birth(내가 입력한 값) : " + birth);
		//System.out.println("tel(내가 입력한 값) : " + tel);
		//System.out.println("email(내가 입력한 값) : " + email);
		if(vo != null && vo.getMid().equals(mid) && vo.getName().equals(name) && 
			Birth.equals(birth) && vo.getTel().equals(tel) && vo.getEmail().equals(email)) {
			return "1";
		}
		else return "0";
	}
	
	// 각 종류별 대출 페이지로 이동
	@RequestMapping(value = "/loanSignCheck", method = RequestMethod.GET)
	public String loanSignCheckGet(Model model, String loanSw) {
		if(loanSw.equals("S")) return "loan/loanS";
		else if(loanSw.equals("H")) return "loan/loanH";
		else if(loanSw.equals("J")) return "loan/loanJ";
		else return "loan/loanM";
	}
	
	// 신용대출 처리
	@RequestMapping(value = "/loanS", method = RequestMethod.POST)
	public String loanSPost(LoanSVO vo, String mid, String workingPeriodY, String workingPeriodM) {
		// 월 소득금액의 30%가 월 상환액인지 체크
		int loanPeriod = 0;
		if(vo.getLoanPeriod() == 1) loanPeriod = 12;
		else if(vo.getLoanPeriod() == 2) loanPeriod = 24;
		else if(vo.getLoanPeriod() == 3) loanPeriod = 36;
		else if(vo.getLoanPeriod() == 4) loanPeriod = 48;
		else loanPeriod = 60;
		//System.out.println("loanPeriod : " + loanPeriod);
		if(vo.getMonthlyIncome() < (vo.getLoanAmount()/loanPeriod) / 0.3) {
			return "redirect:/message/loanSMoneyNo";
		}
		
		vo.setMid(mid);
		vo.setWorkingPeriod(workingPeriodY+"년 "+workingPeriodM+"개월");
		vo.setInteresRate(8.0);
		vo.setRepaymentMethod("X");
		vo.setStatus("R");
		
		int res = loanService.setLoanSInput(vo);
		
		if(res != 0) return "redirect:/message/loanSOk";
		else return "redirect:/message/loanSNo";
	}
	
}

