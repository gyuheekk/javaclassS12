package com.spring.javaclassS12.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MessageController {

	@RequestMapping(value = "/message/{msgFlag}", method = RequestMethod.GET)
	public String getMessage(Model model,
			@PathVariable String msgFlag,
			@RequestParam(name="mid", defaultValue = "", required = false) String mid,
			@RequestParam(name="temp", defaultValue = "", required = false) String temp,
			@RequestParam(name="idx", defaultValue = "", required = false) String idx,
			@RequestParam(name="pag", defaultValue = "1", required = false) String pag,
			@RequestParam(name="pageSize", defaultValue = "5", required = false) String pageSize) {
		if(msgFlag.equals("memberJoinOk")) {
			model.addAttribute("msg", "회원에 가입되셨습니다.\\n가입한 회원정보로 로그인해주세요.");
			model.addAttribute("url", "/member/memberLogin");
		}
		else if(msgFlag.equals("memberJoinNo")) {
			model.addAttribute("msg", "회원 가입 실패.");
			model.addAttribute("url", "/member/memberJoin");
		}
		else if(msgFlag.equals("memberLoginOk")) {
			model.addAttribute("msg", mid+"님 로그인 되셨습니다.");
			model.addAttribute("url", "/");
		}
		else if(msgFlag.equals("memberLoginNo")) {
			model.addAttribute("msg", "입력하신 회원정보가 없습니다.\\n회원정보를 확인하고 다시 로그인해주세요.");
			model.addAttribute("url", "/member/memberLogin");
		}
		else if(msgFlag.equals("memberLogout")) {
			model.addAttribute("msg", mid+"님 로그아웃 되셨습니다.");
			model.addAttribute("url", "/");
		}
		else if(msgFlag.equals("DminusMoney")) {
			model.addAttribute("msg", "입금액은 0원 이상이어야 합니다. 다시 입력해 주세요.");
			model.addAttribute("url", "/account/accountDeposit");
		}
		else if(msgFlag.equals("accountDepositOk")) {
			model.addAttribute("msg", "입금이 완료되었습니다.");
			model.addAttribute("url", "/account/accountDepositOk");
		}
		else if(msgFlag.equals("accountDepositNo")) {
			model.addAttribute("msg", "입금 실패");
			model.addAttribute("url", "/account/accountDeposit");
		}
		else if(msgFlag.equals("WminusMoney")) {
			model.addAttribute("msg", "출금액은 0원 이상이어야 합니다. 다시 입력해 주세요.");
			model.addAttribute("url", "/account/accountWithdraw");
		}
		else if(msgFlag.equals("noMoneyW")) {
			model.addAttribute("msg", "잔액을 초과한 금액은 출금할 수 없습니다");
			model.addAttribute("url", "/account/accountWithdraw");
		}
		else if(msgFlag.equals("noMoneyT")) {
			model.addAttribute("msg", "잔액을 초과한 금액은 출금할 수 없습니다");
			model.addAttribute("url", "/account/accountTransfer");
		}
		else if(msgFlag.equals("accountWithdrawOk")) {
			model.addAttribute("msg", "출금이 완료되었습니다.");
			model.addAttribute("url", "/account/accountWithdrawOk");
		}
		else if(msgFlag.equals("accountWithdrawNo")) {
			model.addAttribute("msg", "출금실패");
			model.addAttribute("url", "/account/accountWithdraw");
		}
		else if(msgFlag.equals("TminusMoney")) {
			model.addAttribute("msg", "계좌이체 할 금액은 0원 이상이어야 합니다. 다시 입력해 주세요.");
			model.addAttribute("url", "/account/accountTransfer");
		}
		else if(msgFlag.equals("accountInputOk")) {
			model.addAttribute("msg", "즐겨찾기 계좌에 등록되었습니다.");
			model.addAttribute("url", "/account/accountTransfer");
		}
		else if(msgFlag.equals("accountInputNo1")) {
			model.addAttribute("msg", "입력하신 계좌정보가 없습니다.");
			model.addAttribute("url", "/account/accountTransfer");
		}
		else if(msgFlag.equals("accountInputNo2")) {
			model.addAttribute("msg", "계좌등록 실패");
			model.addAttribute("url", "/account/accountTransfer");
		}
		else if(msgFlag.equals("accountInputNo3")) {
			model.addAttribute("msg", "이미 등록된 계좌번호입니다.");
			model.addAttribute("url", "/account/accountTransfer");
		}
		else if(msgFlag.equals("accountTransferOk")) {
			model.addAttribute("msg", "계좌이체가 완료되었습니다.");
			model.addAttribute("url", "/account/accountTransferOk?youId="+temp);
		}
		else if(msgFlag.equals("accountTransferNo")) {
			model.addAttribute("msg", "계좌이체 실패");
			model.addAttribute("url", "/account/accountTransfer");
		}
		else if(msgFlag.equals("accountDeleteOk")) {
			model.addAttribute("msg", "즐겨찾기 계좌번호가 삭제되었습니다.");
			model.addAttribute("url", "/account/accountTransfer");
		}
		else if(msgFlag.equals("accountDeleteNo")) {
			model.addAttribute("msg", "즐겨찾기 계좌번호 삭제 실패.");
			model.addAttribute("url", "/account/accountTransfer");
		}
		else if(msgFlag.equals("cardOk")) {
			model.addAttribute("msg", "카드 발급이 완료되었습니다.\\n발급받은 카드 확인을 위해 내 카드 확인 페이지로 이동합니다.");
			model.addAttribute("url", "/card/cardCheck");
		}
		else if(msgFlag.equals("cardNo")) {
			model.addAttribute("msg", "카드 발급 실패");
			model.addAttribute("url", "/card/cardSignup");
		}
		else if(msgFlag.equals("memberUpdateOk")) {
			model.addAttribute("msg", "회원 정보가 수정되었습니다.");
			model.addAttribute("url", "/member/memberMyProfile");
		}
		else if(msgFlag.equals("memberUpdateNo")) {
			model.addAttribute("msg", "회원 정보 수정 실패");
			model.addAttribute("url", "/member/memberUpdate");
		}
		else if(msgFlag.equals("qrLoginMemberNo")) {
			model.addAttribute("msg", "회원정보가 없습니다.\\n아이디 확인후 다시 로그인해 주세요.");
			model.addAttribute("url", "/member/memberLogin");
		}
		else if(msgFlag.equals("qrLoginTimeOver")) {
			model.addAttribute("msg", "시간이 경과했습니다.\\n다시 로그인해 주세요.");
			model.addAttribute("url", "/member/memberLogin");
		}
		else if(msgFlag.equals("boardInputOk")) {
			model.addAttribute("msg", "게시글이 등록되었습니다.");
			model.addAttribute("url", "/board/boardList");
		}
		else if(msgFlag.equals("boardInputNo")) {
			model.addAttribute("msg", "게시글 등록 실패");
			model.addAttribute("url", "/board/boardInput");
		}
		else if(msgFlag.equals("noMember")) {
			model.addAttribute("msg", "로그인이 필요한 서비스입니다.");
			model.addAttribute("url", "/member/memberLogin");
		}
		else if(msgFlag.equals("boardUpdateOk")) {
			model.addAttribute("msg", "게시글이 수정되었습니다.");
			model.addAttribute("url", "/board/boardContent?idx="+idx+"&pag="+pag+"&pageSize="+pageSize);
		}
		else if(msgFlag.equals("boardUpdateNo")) {
			model.addAttribute("msg", "게시글 수정 실패");
			model.addAttribute("url", "/board/boardContent?idx="+idx+"&pag="+pag+"&pageSize="+pageSize);
		}
		else if(msgFlag.equals("boardDeleteOk")) {
			model.addAttribute("msg", "게시글이 삭제되었습니다.");
			model.addAttribute("url", "/board/boardList");
		}
		else if(msgFlag.equals("boardDeleteNo")) {
			model.addAttribute("msg", "게시글 삭제 실패");
			model.addAttribute("url", "/board/boardContent?idx="+idx+"&pag="+pag+"&pageSize="+pageSize);
		}
		else if(msgFlag.equals("boardReplyDeleteOk")) {
			model.addAttribute("msg", "댓글이 삭제되었습니다.");
			model.addAttribute("url", "/board/boardContent?idx="+idx+"&pag="+pag+"&pageSize="+pageSize);
		}
		else if(msgFlag.equals("boardReplyDeleteNo")) {
			model.addAttribute("msg", "댓글 삭제 실패");
			model.addAttribute("url", "/board/boardContent?idx="+idx+"&pag="+pag+"&pageSize="+pageSize);
		}
		else if(msgFlag.equals("savingOk")) {
			model.addAttribute("msg", "예적금 신청이 성공적으로 완료되었습니다.");
			model.addAttribute("url", "/saving/savingCheck");
		}
		else if(msgFlag.equals("savingNo")) {
			model.addAttribute("msg", "예적금 신청실패");
			model.addAttribute("url", "/saving/savingSignup");
		}
		else if(msgFlag.equals("savingInforYes")) {
			model.addAttribute("msg", "이미 가입된 정보가 있습니다.");
			model.addAttribute("url", "/saving/savingSignup");
		}
		else if(msgFlag.equals("savingNoMoney")) {
			model.addAttribute("msg", "잔액이 부족합니다.");
			model.addAttribute("url", "/saving/savingSignup");
		}
		else if(msgFlag.equals("loanSMoneyNo")) {
			model.addAttribute("msg", "고객님의 월 소득 기준이 맞지 않아 대출 신청이 불가능합니다.");
			model.addAttribute("url", "/loan/loanProduct");
		}
		else if(msgFlag.equals("loanSOk")) {
			model.addAttribute("msg", "신용대출 신청이 완료되었습니다.");
			model.addAttribute("url", "/");
		}
		else if(msgFlag.equals("loanSNo")) {
			model.addAttribute("msg", "신용대출 신청실패");
			model.addAttribute("url", "/loan/loanProduct");
		}
		
		
		return "include/message";
	}
	
}
