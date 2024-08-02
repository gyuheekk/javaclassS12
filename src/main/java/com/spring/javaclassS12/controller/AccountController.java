package com.spring.javaclassS12.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaclassS12.pagination.PageProcess;
import com.spring.javaclassS12.service.AccountService;
import com.spring.javaclassS12.service.MemberService;
import com.spring.javaclassS12.vo.AccountVO;
import com.spring.javaclassS12.vo.MemberVO;

@Controller
@RequestMapping("/account")
public class AccountController {

	@Autowired
	AccountService accountService;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	PageProcess pageProcess;

	//입금창 띄우기
	@RequestMapping(value = "/accountDeposit", method = RequestMethod.GET)
		public String accountDepositGet() {
		return "account/accountDeposit";
	}
	
	//입금처리
	@RequestMapping(value = "/accountDeposit", method = RequestMethod.POST)
	public String accountDepositPost(HttpServletRequest request, AccountVO vo) {
		// 음수처리
		if(vo.getMoney() < 0) return "redirect:/message/DminusMoney";
		
		int res = accountService.setAccountInput(vo);
		
		if(res != 0) return "redirect:/message/accountDepositOk";
		else return "redirect:/message/accountDepositNo";
	}
	
	//입금 거래 완료 명세서
	@RequestMapping(value = "/accountDepositOk", method = RequestMethod.GET)
		public String accountDepositOkGet(HttpSession session, Model model) {
		
		String mid = (String) session.getAttribute("sMid");
		AccountVO vo = accountService.getAccInfor(mid);
		
		vo.setBalance(accountService.getBalanceSearch(mid));
		model.addAttribute("vo", vo);
		
		return "account/accountDepositOk";
	}
	
	//출금창 띄우기
	@RequestMapping(value = "/accountWithdraw", method = RequestMethod.GET)
		public String accountWithdrawGet(Model model, HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		int balance = accountService.getBalanceSearch(mid);
		model.addAttribute("balance",balance);
		return "account/accountWithdraw";
	}
	
	//출금처리
	@RequestMapping(value = "/accountWithdraw", method = RequestMethod.POST)
	public String accountWithdrawPost(HttpServletRequest request, AccountVO vo) {
		//음수처리, 잔액보다 출금액이 크면 리턴처리
		if(vo.getMoney() < 0) return "redirect:/message/WminusMoney";
		else if(vo.getBalance() < vo.getMoney()) return "redirect:/message/noMoneyW";
		
		int res = accountService.setAccountInput(vo);
		
		if(res != 0) return "redirect:/message/accountWithdrawOk";
		else return "redirect:/message/accountWithdrawNo";
	}
	
	//출금 거래 완료 명세서
	@RequestMapping(value = "/accountWithdrawOk", method = RequestMethod.GET)
		public String accountWithdrawOkGet(HttpSession session, Model model) {
		
		String mid = (String) session.getAttribute("sMid");
		AccountVO vo = accountService.getAccInfor(mid);
		
		vo.setBalance(accountService.getBalanceSearch(mid));
		model.addAttribute("vo", vo);
		
		return "account/accountWithdrawOk";
	}
	
	//계좌이체창 띄우기
	@RequestMapping(value = "/accountTransfer", method = RequestMethod.GET)
	public String accountTransferGet(Model model, HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		int balance = accountService.getBalanceSearch(mid);
		List<AccountVO> vos = accountService.getAccountFavorite(mid);
		model.addAttribute("balance", balance);
		model.addAttribute("vos", vos);
		return "account/accountTransfer";
	}
	
	//계좌이체 거래 처리(트랜잭션 처리)
	@Transactional
	@RequestMapping(value = "/accountTransfer", method = RequestMethod.POST)
	public String accountTransferPost(Model model, HttpSession session, AccountVO vo, String accountNumber, String flagSw) {
		//음수처리, 잔액보다 출금액이 크면 리턴처리
		if(vo.getMoney() < 0) return "redirect:/message/TminusMoney";
		else if(vo.getBalance() < vo.getMoney()) return "redirect:/message/noMoneyT";
		
		MemberVO mVO = memberService.getAccountSearch(accountNumber);
		if(mVO == null) {
			return "redirect:/message/accountInputNo1";
		}
		
		int res = accountService.setAccountInput(vo);
		
		if(res != 0) return "redirect:/message/accountTransferOk?temp="+vo.getYouId();
		else return "redirect:/message/accountTransferNo";
	}
	
	// 즐겨찾기 계좌등록
	@RequestMapping(value = "/transferInput", method = RequestMethod.POST)
	public String accountInputPost(HttpSession session, String accountNumber, AccountVO aVO,
				 String accountFlag, String youId) {
		String mid = (String) session.getAttribute("sMid");
		
		// 멤버테이블에서 입력한 계좌번호가 실제 존재하는 정보인지 확인
		// 입력한 계좌정보가 멤버테이블에 없으면 리턴 (입력한 정보 없음)
		MemberVO mVO = memberService.getAccountSearch(accountNumber);
		if(mVO == null || !mVO.getMid().equals(youId)) return "redirect:/message/accountInputNo1";
		
		// 내 즐겨찾기 계좌에 이미 존재하는 계좌인지를 검색 (이미 존재한 계좌)
		AccountVO aVo = accountService.getAccountFavorite2(mid, accountNumber);
		if(aVo != null) return "redirect:/message/accountInputNo3";
		
		// 입력한 계좌정보가 멤버테이블에 존재하면 즐겨찾기 계좌에 등록
		aVO.setAccountNumber(accountNumber);
		MemberVO vo = memberService.getMemberIdCheck(mid);
		if(vo != null) {
			int res = accountService.setAccountInputOk(aVO);
			if(res != 0) {
				return "redirect:/message/accountInputOk";
			}
			else {
				return "redirect:/message/accountInputNo2";
			}
		}
		return "";
	}
	
	// 즐겨찾기 계좌번호 삭제처리
	@RequestMapping(value = "/accountDelete", method = RequestMethod.GET)
	public String accountDeleteGet(int idx) {
		int res = accountService.setAccountDelete(idx);
		if(res != 0) return "redirect:/message/accountDeleteOk";
		else return "redirect:/message/accountDeleteNo";
	}
	
	
	//계좌이체 거래 완료 명세서
	@RequestMapping(value = "/accountTransferOk", method = RequestMethod.GET)
		public String accountTransferOkGet(HttpSession session, Model model, String youId) {
		
		String mid = (String) session.getAttribute("sMid");
		AccountVO vo = accountService.getAccInfor(mid);
		
		vo.setYouName(memberService.getMemberIdCheck(youId).getName());
		vo.setBalance(accountService.getBalanceSearch(mid));
		model.addAttribute("vo", vo);
		
		return "account/accountTransferOk";
	}
	 
	//거래내역조회 창 띄우기
	@RequestMapping(value = "/accountview", method = RequestMethod.GET)
		public String accountviewGet(Model model, HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		MemberVO vo = memberService.getMemberIdCheck(mid);
		model.addAttribute("vo", vo);
		return "account/accountview";
	}
	
	// 거래내역조회 내용 출력 
	@ResponseBody
	@RequestMapping(value = "/accountView", method = RequestMethod.POST)
	public Map<String, Object> accountViewPost(HttpSession session, String flagSw) {
		
		String mid = (String) session.getAttribute("sMid");
	    
    List<AccountVO> vos = accountService.getAccountHistory(mid);
    List<AccountVO> vos2 = new ArrayList<>();

    String strFlagSw = "";
    if(flagSw.equals("I")) {
        strFlagSw = "입금";
        vos2 = vos.stream().filter(vo -> "I".equals(vo.getFlagSw())).collect(Collectors.toList());
    } else if(flagSw.equals("C")) {
        strFlagSw = "출금";
        vos2 = vos.stream().filter(vo -> "C".equals(vo.getFlagSw())).collect(Collectors.toList());
    } else if(flagSw.equals("E")) {
        strFlagSw = "계좌이체";
        vos2 = vos.stream().filter(vo -> "E".equals(vo.getFlagSw())).collect(Collectors.toList());
    } else {
        strFlagSw = "전체거래";
        vos2 = vos;
    }
    
    Map<String, Object> response = new HashMap<>();
    response.put("strFlagSw", strFlagSw);
    response.put("vos", vos);
    response.put("vos2", vos2);
    
    return response;
	}

	
}

