package com.spring.javaclassS12.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaclassS12.service.LoanService;
import com.spring.javaclassS12.service.MemberService;
import com.spring.javaclassS12.service.SavingService;
import com.spring.javaclassS12.vo.LoanHVO;
import com.spring.javaclassS12.vo.LoanMVO;
import com.spring.javaclassS12.vo.LoanSVO;
import com.spring.javaclassS12.vo.MemberVO;
import com.spring.javaclassS12.vo.SavingVO;

@Controller
@RequestMapping("/loan")
public class LoanController {
	
	@Autowired
	MemberService memberService;

	@Autowired
	LoanService loanService;
	
	@Autowired
	SavingService savingService;
	
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
	public String loanSPost(LoanSVO vo, String mid, String workingPeriodY, String workingPeriodM,
		String otherjobContent, String otherLoanContent) {
		// 한 아이디에 대출은 한 종류만 들 수 있어서, 신청내역이 있는지 체크
		LoanSVO sVo = loanService.getLoansIdCheck(mid);
		if(sVo != null) {
			if(sVo.getStatus().equals("신청")) return "redirect:/message/loanJoinOk";
			else return "redirect:/message/loanApproveOk";
		}
	 
		// 월 소득금액의 30%가 월 상환액인지 체크
		int loanPeriod = 0;
		if(vo.getLoanPeriod() == 1) loanPeriod = 12;
		else if(vo.getLoanPeriod() == 2) loanPeriod = 24;
		else if(vo.getLoanPeriod() == 3) loanPeriod = 36;
		else if(vo.getLoanPeriod() == 4) loanPeriod = 48;
		else loanPeriod = 60;
		if(vo.getMonthlyIncome() < (vo.getLoanAmount()/loanPeriod) / 0.3) {
			return "redirect:/message/loanSMoneyNo";
		}
		
		if(vo.getJob().equals("기타(직업)")) vo.setJob(otherjobContent);
		if(vo.getLoanContent().equals("기타(목적)")) vo.setLoanContent(otherLoanContent);
		
		vo.setMid(mid);
		vo.setWorkingPeriod(workingPeriodY+"년 "+workingPeriodM+"개월");
		vo.setInteresRate(8.0);
		vo.setRepaymentMethod("원금균등상환");
		
		int res = loanService.setLoanSInput(vo);
		
		if(res != 0) return "redirect:/message/loanSOk";
		else return "redirect:/message/loanSNo";
	}
	
	// 학자금대출 처리
	@RequestMapping(value = "/loanH", method = RequestMethod.POST)
	public String loanHPost(LoanHVO vo, String mid, String admissionDateY, String admissionDateM,
			String graduationDateY, String graduationDateM) {
		// 한 아이디에 대출은 한 종류만 들 수 있어서, 신청내역이 있는지 체크
		LoanHVO hVo = loanService.getLoanhIdCheck(mid);
		if(hVo != null) {
			if(hVo.getStatus().equals("신청")) return "redirect:/message/loanJoinOk";
			else return "redirect:/message/loanApproveOk";
		}
		
		// 등록금 금액의 최대 70%를 넘지 않도록 체크
		if(vo.getTuition()*0.7 < vo.getLoanAmount()) {
			return "redirect:/message/loanHMoneyNo";
		}
		
		vo.setMid(mid);
		vo.setAdmissionDate(admissionDateY+"년 "+admissionDateM+"월");
		vo.setGraduationDate(graduationDateY+"년 "+graduationDateM+"월");
		vo.setGrade(vo.getGrade()+"학년");
		vo.setInteresRate(5.0);
		vo.setRepaymentMethod("원금균등상환");
		
		int res = loanService.setLoanHInput(vo);
		
		if(res != 0) return "redirect:/message/loanHOk";
		else return "redirect:/message/loanHNo";
	}
	
	// 예/적금 담보대출 처리
	@RequestMapping(value = "/loanM", method = RequestMethod.POST)
	public String loanMPost(LoanMVO vo, String mid, String StartDateY, String StartDateM, String StartDateD,
			String expiryDateY, String expiryDateM, String expiryDateD) {
		// 한 아이디에 대출은 한 종류만 들 수 있어서, 신청내역이 있는지 체크
		LoanMVO mVo = loanService.getLoanmIdCheck(mid);
		if(mVo != null) {
			if(mVo.getStatus().equals("신청")) return "redirect:/message/loanJoinOk";
			else return "redirect:/message/loanApproveOk";
		}
		// 예/적금 가입 정보가 있는지 확인
		SavingVO sVo = null;
		System.out.println("vo : " + vo);
		sVo = savingService.getSavingIdCheck(mid, sVo.getSavingSw());
		System.out.println("sVo : " + sVo);
		
		//if(sVo)
		
		// 예/적금 
		
		vo.setMid(mid);
		vo.setStartDate(StartDateY+"년 "+StartDateM+"월 "+StartDateD+"일");
		vo.setExpiryDate(expiryDateY+"년 "+expiryDateM+"월 "+expiryDateD+"일");
		vo.setInteresRate(5.0);
		vo.setRepaymentMethod("만기일시상환");
		
		int res = loanService.setLoanMInput(vo);
		
		if(res != 0) return "redirect:/message/loanMOk";
		else return "redirect:/message/loanMNo";
	}
	
	//대출상품 소개 창 띄우기
	@RequestMapping(value = "/loanCheck", method = RequestMethod.GET)
		public String loanCheckGet(Model model, HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		
		List<LoanSVO> vos1 = loanService.getLoansInfor(mid);
		List<LoanHVO> vos2 = loanService.getLoanhInfor(mid);
		System.out.println("vos2 : " + vos2);
		
		model.addAttribute("vos1", vos1);
		model.addAttribute("vos2", vos2);
		
		return "loan/loanCheck";
	}
	
}

