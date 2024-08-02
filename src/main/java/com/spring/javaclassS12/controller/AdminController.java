package com.spring.javaclassS12.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.javaclassS12.pagination.PageProcess;
import com.spring.javaclassS12.service.AccountService;
import com.spring.javaclassS12.service.BoardService;
import com.spring.javaclassS12.service.MemberService;
import com.spring.javaclassS12.vo.AccountVO;
import com.spring.javaclassS12.vo.BoardReplyVO;
import com.spring.javaclassS12.vo.BoardVO;
import com.spring.javaclassS12.vo.MemberVO;
import com.spring.javaclassS12.vo.PageVO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	AccountService accountService;
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	PageProcess pageProcess;
	
	@RequestMapping(value = "/adminMain", method = RequestMethod.GET)
	public String adminMainGet() {
		return "admin/adminMain";
	}
	
	@RequestMapping(value = "/adminLeft", method = RequestMethod.GET)
	public String adminLeftGet() {
		return "admin/adminLeft";
	}
	
	@RequestMapping(value = "/adminContent", method = RequestMethod.GET)
	public String adminContentGet(Model model,
			@RequestParam(name="part", defaultValue = "문의사항", required = false) String part) {
		// 문의사항에 새로 올라온 글 건수 구하기
		int boardCnt = boardService.getBoardCount(part);
		
		// 일주일 이내 신규가입회원 
		int newMemberCnt = memberService.getNewMemberCnt();
		
		// 탈퇴 신청 회원
		int userNoCnt = memberService.getUserNoCnt();
		
		// 일일 거래 횟수
		int accountDaily = accountService.getAccountDaily();
		
		model.addAttribute("boardCnt", boardCnt);
		model.addAttribute("newMemberCnt", newMemberCnt);
		model.addAttribute("userNoCnt", userNoCnt);
		model.addAttribute("accountDaily", accountDaily);
		
		return "admin/adminContent";
	}
	
	//관리자 화면에서 은행 총 잔액 보여주기
	@RequestMapping(value = "/bankBalance", method = RequestMethod.GET)
	public String bankBalanceGet(Model model) {
		String flagSw = "";
		
		int totalBalance = accountService.getTotalBalance(flagSw); 
		model.addAttribute("totalBalance", totalBalance);
		
		int totalDeposit = accountService.getTotalDeposit(flagSw); 
		model.addAttribute("totalDeposit", totalDeposit);
		
		int totalWithdraw = accountService.getTotalWithdraw(flagSw); 
		model.addAttribute("totalWithdraw", totalWithdraw);
		
		
		return "admin/bankBalance";
	}
	
	@RequestMapping(value = "/board/boardList", method = RequestMethod.GET)
	public String boardListGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize,
			@RequestParam(name="part", defaultValue = "전체게시판", required = false) String part) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "board", part, "");
		
		ArrayList<BoardVO> vos = boardService.getBoardList(pageVO.getStartIndexNo(), pageSize, part);
		
		model.addAttribute("part", part);
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return "admin/board/boardList";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/board/boardContent", method = RequestMethod.GET)
	public String boardContentPost(int idx, Model model, HttpServletRequest request,
			@RequestParam(name="search", defaultValue = "", required = false) String search,
			@RequestParam(name="searchString", defaultValue = "", required = false) String searchString,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize,
			@RequestParam(name="part", defaultValue = "전체 게시판", required = false) String part) {
		
		HttpSession session = request.getSession();
		ArrayList<String> contentReadNum = (ArrayList<String>) session.getAttribute("sContentIdx");
		if(contentReadNum == null) contentReadNum = new ArrayList<String>();
		String imsiContentReadNum = "board" + idx;
		if(!contentReadNum.contains(imsiContentReadNum)) {
			boardService.setReadNumPlus(idx);
			contentReadNum.add(imsiContentReadNum);
		}
		session.setAttribute("sContentIdx", contentReadNum);
		
		BoardVO vo = boardService.getBoardContent(idx);
		model.addAttribute("vo", vo);
		model.addAttribute("search", search);
		model.addAttribute("searchString", searchString);
		model.addAttribute("part", part);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		
		// 이전글/다음글 가져오기
		BoardVO preVo = boardService.getPreNexSearch(idx, "preVo");
		BoardVO nextVo = boardService.getPreNexSearch(idx, "nextVo");
		model.addAttribute("preVo", preVo);
		model.addAttribute("nextVo", nextVo);
		
		// 댓글(대댓글) 추가 입력처리
		List<BoardReplyVO> replyVos = boardService.getBoardReply(idx);
		model.addAttribute("replyVos", replyVos);
		
		return "admin/board/boardContent";
	}
	
	@RequestMapping(value = "/member/memberList", method = RequestMethod.GET)
	public String memberListGet(HttpSession session, Model model, MemberVO vo,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "member", "", "");
		List<MemberVO> vos = memberService.getMemberList(vo, pageVO.getStartIndexNo(), pageSize);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return "admin/member/memberList";
	}
	
	@RequestMapping(value = "/dailyAccount", method = RequestMethod.GET)
	public String dailyAccountGet(HttpSession session, Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize,
			@RequestParam(name="flagSw", defaultValue = "", required = false) String flagSw) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "dailyAccount", flagSw, "");
		
		List<AccountVO> vos = accountService.getAccountDailyList(pageVO.getStartIndexNo(), pageSize, flagSw);
		
		// 일일 거래 횟수
		int accountDaily = accountService.getAccountDaily();
		
		// 총 입금/출금/계좌이체/계좌입금 건수
		int accountDailyI = accountService.getAccountDailyI(flagSw);
		int accountDailyC = accountService.getAccountDailyC(flagSw);
		int accountDailyE = accountService.getAccountDailyE(flagSw);
		int accountDailyG = accountService.getAccountDailyG(flagSw);
		
		model.addAttribute("vos", vos);
		model.addAttribute("flagSw", flagSw);
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("accountDaily", accountDaily);
		model.addAttribute("accountDailyI", accountDailyI);
		model.addAttribute("accountDailyC", accountDailyC);
		model.addAttribute("accountDailyE", accountDailyE);
		model.addAttribute("accountDailyG", accountDailyG);
		return "admin/dailyAccount";
	}
	
	@RequestMapping(value = "/bankAllAccount", method = RequestMethod.GET)
	public String bankAllAccountGet() {
		return "admin/bankAllAccount";
	}
	
	
}

