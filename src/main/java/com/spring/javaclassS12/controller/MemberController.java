package com.spring.javaclassS12.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS12.service.MemberService;
import com.spring.javaclassS12.vo.MemberVO;

@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired
	MemberService memberService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	JavaMailSender mailSender;
	
	//일반 로그인 폼
	@RequestMapping(value = "/memberLogin", method = RequestMethod.GET)
	public String memberLoginGet(HttpServletRequest request) {
		// 로그인창에 아이디 체크 유무에 대한 처리
		// 쿠키를 검색해서 cMid가 있을때 가져와서 아이디입력창에 뿌릴수 있게 한다.
		Cookie[] cookies = request.getCookies();

		if(cookies != null) {
			for(int i=0; i<cookies.length; i++) {
				if(cookies[i].getName().equals("cMid")) {
					request.setAttribute("mid", cookies[i].getValue());
					break;
				}
			}
		}
		return "member/memberLogin";
	}
	
	//일반로그인 처리하기
	@RequestMapping(value = "/memberLogin", method = RequestMethod.POST)
	public String memberLoginPost(HttpServletRequest request, HttpServletResponse response, HttpSession session,
			@RequestParam(name="mid", defaultValue = "admin", required = false) String mid,
			@RequestParam(name="pwd", defaultValue = "1234", required = false) String pwd,
			@RequestParam(name="idSave", defaultValue = "1234", required = false) String idSave
		) {
		//  로그인 인증처리(스프링 시큐리티의 BCryptPasswordEncoder객체를 이용한 암호화되어 있는 비밀번호 비교하기)
		MemberVO vo = memberService.getMemberIdCheck(mid);
		
		if(vo != null && vo.getUserDel().equals("NO") && passwordEncoder.matches(pwd, vo.getPwd())) {
			// 로그인 인증완료시 처리할 부분(1.세션, 2.쿠키)
			// 1.세션처리
			String strLevel = "";
			if(vo.getLevel() == 0) strLevel = "관리자";
			else if(vo.getLevel() == 1) strLevel = "VVIP";
			else if(vo.getLevel() == 2) strLevel = "VIP";
			else if(vo.getLevel() == 3) strLevel = "우수회원";
			else if(vo.getLevel() == 4) strLevel = "일반회원";
			
			session.setAttribute("sMid", mid);
			session.setAttribute("sName", vo.getName());
			session.setAttribute("sLevel", vo.getLevel());
			session.setAttribute("strLevel", strLevel);
			
			// 2.쿠키 저장/삭제
			if(idSave.equals("on")) {
				Cookie cookieMid = new Cookie("cMid", mid);
				cookieMid.setPath("/");
				cookieMid.setMaxAge(60*60*24*7);		// 쿠키의 만료시간을 7일로 지정
				response.addCookie(cookieMid);
			}
			else {
				Cookie[] cookies = request.getCookies();
				if(cookies != null) {
					for(int i=0; i<cookies.length; i++) {
						if(cookies[i].getName().equals("cMid")) {
							cookies[i].setMaxAge(0);
							response.addCookie(cookies[i]);
							break;
						}
					}
				}
			}
			
			return "redirect:/message/memberLoginOk?mid="+mid;
		}
		else {
			return "redirect:/message/memberLoginNo";
		}
	}
	
	//QR 로그인 폼(새창으로 띄우기)
	@RequestMapping(value = "/qrLogin", method = RequestMethod.GET)
	public String memberLoginGet(Model model, String mid, HttpServletRequest request) {
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/qrCode/");
		String qrCodeToken = RandomStringUtils.randomAlphanumeric(16);
		String qrCodeName = memberService.setQrCodeCreate(realPath, mid, qrCodeToken);
		model.addAttribute("mid", mid);
		model.addAttribute("qrCodeName", qrCodeName);
		model.addAttribute("qrCodeToken", qrCodeToken);
		return "member/qrLogin";
	}
	
	//QR 로그인(QR코드 확인후 호출시 실행)
	@RequestMapping(value = "/qrLoginConfirm/{mid}/{qrCodeToken}/{today}", method = RequestMethod.GET)
	public String qrLoginConfirmGet(
			@PathVariable String mid,
			@PathVariable String qrCodeToken,
			@PathVariable String today) {
		MemberVO vo = memberService.getMemberIdCheck(mid);
		if(vo == null) return "redirect:/message/qrLoginMemberNo";
		memberService.setQrCodeLogin(mid, qrCodeToken, today);
		return "member/qrLoginConfirm";
	}
	
	//QR 로그인(QR코드 확인후 윈도우 새창(QR코드창)에서 '로그인 확인'버튼클릭시 실행)
	@RequestMapping(value = "/qrLoginCheck/{mid}/{qrCodeToken}", method = RequestMethod.GET)
	public String qrLoginCheckGet(Model model, HttpSession session,
			@PathVariable String mid,
			@PathVariable String qrCodeToken) {
		String strToday = memberService.getQrCodeLoginCheck(mid, qrCodeToken);
		if(strToday == null) return "redirect:/message/qrLoginMemberNo";
		
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
		long intToday = Long.parseLong(sdf.format(today));
		long intStrToday = Long.parseLong(strToday);
		if((intStrToday - intToday) > 3) return "redirect:/message/qrLoginTimeOver";
		
		
		// 로그인 확인후 필요한 정보를 세션에 저장후 memberMain창으로 보낸다.
		MemberVO vo = memberService.getMemberIdCheck(mid);
		
		// 로그인 인증완료시 처리할 부분(1.세션, 2.쿠키)
		// 1.세션처리
		String strLevel = "";
		if(vo.getLevel() == 0) strLevel = "관리자";
		else if(vo.getLevel() == 1) strLevel = "VVIP";
		else if(vo.getLevel() == 2) strLevel = "VIP";
		else if(vo.getLevel() == 3) strLevel = "우수회원";
		else if(vo.getLevel() == 4) strLevel = "일반회원";
		
		session.setAttribute("sMid", mid);
		session.setAttribute("sName", vo.getName());
		session.setAttribute("sLevel", vo.getLevel());
		session.setAttribute("strLevel", strLevel);
		
		return "redirect:/message/memberLoginOk?mid="+vo.getMid();
	}
	
	
	@RequestMapping(value = "/memberJoin", method = RequestMethod.GET)
	public String memberJoinGet() {
		return "member/memberJoin";
	}
	
	@RequestMapping(value = "/memberJoin", method = RequestMethod.POST)
	public String memberJoinPost(MemberVO vo, MultipartFile fName) {
		// 아이디 중복체크
		if(memberService.getMemberIdCheck(vo.getMid()) != null) return "redirect:/message/idCheckNo";
		
		// 비밀번호 암호화	
		vo.setPwd(passwordEncoder.encode(vo.getPwd()));
		
		// 회원 사진 처리(service객체에서 처리후 DB에 저장한다.)
		if(!fName.getOriginalFilename().equals("")) vo.setPhoto(memberService.fileUpload(fName, vo.getMid()));
		else vo.setPhoto("noimage.jpg");
		
		int res1 = memberService.setMemberJoin(vo);
		int res2 = memberService.setAccountCreate(vo);
		
		if(res1 != 0 && res2 != 0) return "redirect:/message/memberJoinOk";
		else return "redirect:/message/memberJoinNo";
	}
	
	@ResponseBody
	@RequestMapping(value = "/memberIdCheck", method = RequestMethod.GET)
	public String memberIdCheckGet(String mid) {
		MemberVO vo = memberService.getMemberIdCheck(mid);
		if(vo != null) return "1";
		else return "0";
	}
	
	// 임시 비밀번호 메일 발급 처리
	@ResponseBody
	@RequestMapping(value = "/memberNewPassword", method = RequestMethod.POST)
	public String memberNewPasswordPost(String mid, String email, HttpSession session) throws MessagingException {
		MemberVO vo = memberService.getMemberIdCheck(mid);
		if(vo != null && vo.getEmail().equals(email)) {
			// 정보확인후 정보가 맞으면 임시 비밀번호를 발급받아서 메일로 전송처리한다.
			UUID uid = UUID.randomUUID();
			String pwd = uid.toString().substring(0,8);
			
			// 새로 발급받은 비밀번호를 암호화 한후, DB에 저장한다.
			memberService.setMemberPasswordUpdate(mid, passwordEncoder.encode(pwd));
			
			// 발급받은 비밀번호를 메일로 전송처리한다.
			String title = "[GH Bank] 비밀번호 재설정 안내";
			String mailFlag = "임시 비밀번호 : " + pwd;
			String part = "newPassword";
			String res = mailSend(email, title, mailFlag, part);
			
			// 새 비밀번호를 발급하였을시에 sLogin이란 세션을 발생시키고, 2분안에 새 비밀번호로 로그인 후 비밀번호를 변경처리 할 수 있도록 처리(sLogin)
			// 숙제
			session.setAttribute("sLogin", "OK");
			
			if(res == "1") return "1";
		}
		
		return "0";
	}

	//메일 전송하기(아이디찾기, 비밀번호 찾기)
	private String mailSend(String toMail, String title, String mailFlag, String part) throws MessagingException {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String content = "";
		
		// 메일 전송을 위한 객체 : MimeMessage(), MimeMessageHelper()
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
		
		// 메일보관함에 작성한 메세지들의 정보를 모두 저장시킨후 작업처리
		messageHelper.setTo(toMail);			// 받는 사람 메일 주소
		messageHelper.setSubject(title);	// 메일 제목
		//messageHelper.setText(content);		// 메일 내용
		
		// 메세지 보관함의 내용(content)에 , 발신자의 필요한 정보를 추가로 담아서 전송처리한다.
		// 아이디찾기
		if(part.equals("findMid")) {
	    content = content.replace("\n", "<br>");
	    content += "<div style=\"max-width:900px; margin: 0 auto; border: 1px solid #ddd; padding: 20px;\">";
	    content += "<div style=\"text-align: center; border-bottom: 1px solid #ddd; padding-bottom: 20px;\">";
	    content += "<img src=\"cid:Logo.png\"><br>";
	    content += "</div>";
	    content += "<div style=\"padding: 20px;\">";
	    content += "<p><h4>안녕하세요, GH Bank입니다.</h4></p>";
	    content += "<p>언제나 GH Bank를 이용해 주시는 고객님께 감사드립니다. 요청하신 아이디 찾기 결과를 안내해드립니다.</p>";
	    content += "<div style=\"border: 1px solid #ddd; padding: 20px; margin: 20px 0;\">";
	    content += "<h3>아이디 찾기 결과</h3>";
	    content += "<br><hr><h3>고객님의 아이디는 ["+mailFlag+"] 입니다.</h3><hr><br>";
	    content += "</div>";
	    content += "<p>추가적으로 문의사항이 있으시면 홈페이지 문의사항 게시판 이용 부탁드립니다.</p>";
	    content += "<p>감사합니다.</p>";
	    content += "<p><h4>[GH Bank] 드림</h4></p>";
	    content += "</div>";
	    content += "<div style=\"text-align: center; font-size: 12px; color: #888; border-top: 1px solid #ddd; padding-top: 20px;\">";
	    content += "<p>※ 본 메일은 발신 전용 메일입니다. 문의사항이 있으시면 <a href=\"http://localhost:9090/javaclassS12/board/boardList?part=문의사항\">[GH Bank 문의사항 게시판]</a>을 이용해주시기 바랍니다.</p>";
	    content += "</div>";
	    content += "</div>";
		}
		
		// 비밀번호 재설정
		else if(part.equals("newPassword")) {
	    content = content.replace("\n", "<br>");
	    content += "<div style=\"max-width:900px; margin: 0 auto; border: 1px solid #ddd; padding: 20px;\">";
	    content += "<div style=\"text-align: center; border-bottom: 1px solid #ddd; padding-bottom: 20px;\">";
	    content += "<img src=\"cid:Logo.png\"><br>";
	    content += "</div>";
	    content += "<div style=\"padding: 20px;\">";
	    content += "<p><h4>안녕하세요, GH Bank입니다.</h4></p>";
	    content += "<p>언제나 GH Bank를 이용해 주시는 고객님께 감사드립니다. 요청하신 비밀번호 재설정 결과를 안내해드립니다.</p>";
	    content += "<div style=\"border: 1px solid #ddd; padding: 20px; margin: 20px 0;\">";
	    content += "<h3>비밀번호 재설정 안내</h3>";
	    content += "<p>고객님의 비밀번호 재설정 요청이 성공적으로 처리되었습니다. 아래의 임시 비밀번호를 사용하여 로그인하신 후,</p>";
	    content	+= "<p>즉시 새로운 비밀번호로 변경해 주시기 바랍니다.</p>";
	    content += "<br><hr><h3>"+mailFlag+"</h3><hr><br>";
	    content += "<p>보안을 위해 임시 비밀번호를 타인과 공유하지 마시고, 새로운 비밀번호는 이전에 사용한 적 없는 비밀번호로 설정해 주시기 바랍니다.</p>";
	    content += "</div>";
	    content += "<p>추가적으로 문의사항이 있으시면 홈페이지 문의사항 게시판 이용 부탁드립니다.</p>";
	    content += "<p>감사합니다.</p>";
	    content += "<p><h4>[GH Bank] 드림</h4></p>";
	    content += "</div>";
	    content += "<div style=\"text-align: center; font-size: 12px; color: #888; border-top: 1px solid #ddd; padding-top: 20px;\">";
	    content += "<p>※ 본 메일은 발신 전용 메일입니다. 문의사항이 있으시면 <a href=\"http://localhost:9090/javaclassS12/board/boardList?part=문의사항\">[GH Bank 문의사항 게시판]</a>을 이용해주시기 바랍니다.</p>";
	    content += "</div>";
	    content += "</div>";
	}
		messageHelper.setText(content, true);
		
		
		request.getSession().getServletContext().getRealPath("/resources/images/Logo.png");
		FileSystemResource file = new FileSystemResource(request.getSession().getServletContext().getRealPath("/resources/images/Logo.png"));
		messageHelper.addInline("Logo.png", file);
		
		// 메일 전송하기
		mailSender.send(message);
		
		return "1";
	}
	
	@ResponseBody
  @RequestMapping(value = "/memberFindMid", method = RequestMethod.POST)
  public String memberFindMid(String name, String email, HttpSession session) throws MessagingException {
      MemberVO vo = memberService.getMemberNameCheck(name);
      if(vo != null && vo.getEmail().equals(email)) {
          String mid = vo.getMid();
          
      // 회원정보와 일치하는 아이디를 메일로 전송처리한다.
      String part = "findMid";
      String title = "[GH Bank] 아이디 찾기 안내";
      String mailFlag = mid;
      String res = mailSend(email, title, mailFlag, part);
      
          
          if(res == "1") return "1";
      }
      
      return "0";
  }

	@RequestMapping(value = "/memberLogout", method = RequestMethod.GET)
	public String memberMainGet(HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		session.invalidate();
		return "redirect:/message/memberLogout?mid="+mid;
	}
	
	@RequestMapping(value = "/memberMyProfile", method = RequestMethod.GET)
	public String memberMyProfileGet(HttpSession session, Model model) {
		String mid = (String) session.getAttribute("sMid");
		
		MemberVO vo = memberService.getMemberIdCheck(mid);
		
		model.addAttribute("vo", vo);
		
		return "member/memberMyProfile";
	}
	
	//회원정보수정
	@RequestMapping(value = "/memberPwdCheck/{pwdFlag}", method = RequestMethod.GET)
	public String memberPwdCheckGet(@PathVariable String pwdFlag, Model model) {
		model.addAttribute("pwdFlag", pwdFlag);
		return "member/memberPwdCheck";
	}
	
	@ResponseBody
	@RequestMapping(value = "/memberPwdCheck", method = RequestMethod.POST)
	public String memberPwdCheckPost(String mid, String pwd) {
		MemberVO vo = memberService.getMemberIdCheck(mid);
		
		if(passwordEncoder.matches(pwd, vo.getPwd())) return "1";
		return "0";
	}
	
	@ResponseBody
	@RequestMapping(value = "/memberPwdChangeOk", method = RequestMethod.POST)
	public String memberPwdChangeOkPost(String mid, String pwd) {
		return memberService.setPwdChangeOk(mid, passwordEncoder.encode(pwd)) + "";
	}
	
	@RequestMapping(value = "/memberUpdate", method = RequestMethod.GET)
	public String memberUpdateGet(HttpSession session, Model model) {
		String mid = (String) session.getAttribute("sMid");
		MemberVO vo = memberService.getMemberIdCheck(mid);
		model.addAttribute("vo", vo);
		return "member/memberUpdate";
	}
	
	@RequestMapping(value = "/memberUpdate", method = RequestMethod.POST)
	public String memberUpdatePost(MemberVO vo, MultipartFile fName) {
		// 회원 사진 처리(service객체에서 처리후 DB에 저장한다.)
		if(!fName.getOriginalFilename().equals("")) vo.setPhoto(memberService.fileUpload(fName, vo.getMid()));
		else vo.setPhoto(vo.getPhoto());
		
		int res = memberService.setMemberUpdate(vo);
		
		if(res != 0) return "redirect:/message/memberUpdateOk";
		else return "redirect:/message/memberUpdateNo";
	}
	
	//회원 탈퇴신청
	@ResponseBody
	@RequestMapping(value = "/userDel", method = RequestMethod.POST)
	public String userDelPost(HttpSession session, HttpServletRequest request) {
		String mid = (String) session.getAttribute("sMid");
		int res = memberService.setUserDel(mid);
		
		if(res == 1) {
			session.invalidate();
			return "1";
		}
		else return "0";
	}
}
