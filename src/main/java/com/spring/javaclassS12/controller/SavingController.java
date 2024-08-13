package com.spring.javaclassS12.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javaclassS12.service.AccountService;
import com.spring.javaclassS12.service.MemberService;
import com.spring.javaclassS12.service.SavingService;
import com.spring.javaclassS12.vo.AccountVO;
import com.spring.javaclassS12.vo.MemberVO;
import com.spring.javaclassS12.vo.SavingAccountVO;
import com.spring.javaclassS12.vo.SavingVO;

@Controller
@RequestMapping("/saving")
public class SavingController {
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	SavingService savingService;
	
	@Autowired
	AccountService accountService;

	//예/적금상품 소개 창 띄우기
	@RequestMapping(value = "/savingProduct", method = RequestMethod.GET)
		public String savingProductGet() {
		return "saving/savingProduct";
	}
	
	//예금상품 신청 창 띄우기
	@RequestMapping(value = "/savingSignup", method = RequestMethod.GET)
	public String savingYGet(HttpSession session, Model model, String flagSw) {
		String mid = (String) session.getAttribute("sMid");
		int balance = accountService.getBalanceSearch(mid);
		MemberVO vo = memberService.getMemberIdCheck(mid);
		
		int[] productSelect = new int[3];
		if(flagSw.equals("Y")) {
			productSelect[0] = 6;
			productSelect[1] = 12;
			productSelect[2] = 24;
		}
		else if(flagSw.equals("J")) {
			productSelect[0] = 12;
			productSelect[1] = 24;
			productSelect[2] = 36;
		}
		
		model.addAttribute("vo", vo);
		model.addAttribute("balance",balance);
		model.addAttribute("flagSw", flagSw);
		model.addAttribute("productSelect", productSelect);
		
		return "saving/savingSignup";
	}
	
	//예적금 신청 처리페이지
	@RequestMapping(value = "/savingSignup", method = RequestMethod.POST)
	public String savingSignupPost(Model model, SavingVO vo) {
		//System.out.println("vo : " + vo);
		// 한 아이디에 예금.적금은 하나만 들 수 있어서, 같은 아이디에 예금적금 신청내역이 있다면 돌려보내기
		SavingVO sVo = savingService.getSavingIdCheck(vo.getMid(), vo.getSavingSw());
		if(sVo != null) return "redirect:/message/savingInforYes";
		
		String savingAccount = savingService.createSavingAccount(); // 계좌만들기
		
		// 자율통장에 출금할 예치금이 있는지 체크
		int balance = accountService.getBalanceSearch(vo.getMid());
		if(balance < vo.getAmount()) {
			return "redirect:/message/savingNoMoney";
		}
		
		AccountVO aVo = new AccountVO();
		aVo.setMid(vo.getMid());
		aVo.setFlagSw("C");
		aVo.setMoney(vo.getAmount());
		if(vo.getSavingSw().equals("Y")) {
			aVo.setContent("정기예금 개설 : " + savingAccount);
		}
		else aVo.setContent("정기적금 개설 : " + savingAccount);
		accountService.setAccountInput(aVo);
		
		SavingAccountVO saVo = new SavingAccountVO();
		saVo.setMid(vo.getMid());
		saVo.setSavingAccount(savingAccount);
		saVo.setSavingSw(vo.getSavingSw());
		saVo.setMoney(vo.getAmount());
		
		String str = "";
		if(vo.getSavingSw().equals("Y")) {
			str = "정기예금";
		}
		else str = "정기적금";
		saVo.setContent(str);
		accountService.setSavingAccountInput(saVo);
		
		vo.setSavingAccount(savingAccount);
		int res = savingService.setSavingSignup(vo);
		
		if(res != 0) return "redirect:/message/savingOk";
		else return "redirect:/message/savingNo";
	}
	
	// 가입한 예/적금 확인 페이지
	@RequestMapping(value = "/savingCheck", method = RequestMethod.GET)
	public String savingCheckGet(Model model, HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		List<SavingVO> vos = savingService.getSavingInfor(mid);
		
		model.addAttribute("vos", vos);
		
		return "saving/savingCheck";
	}
	
}

