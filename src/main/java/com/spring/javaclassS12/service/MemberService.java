package com.spring.javaclassS12.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS12.vo.MemberVO;

public interface MemberService {

	public MemberVO getMemberIdCheck(String mid);

	public String fileUpload(MultipartFile fName, String mid);

	public int setMemberJoin(MemberVO vo);

	public int setAccountCreate(MemberVO vo);

	public void setMemberPasswordUpdate(String mid, String pwd);

	public MemberVO getMemberNameCheck(String name);

	public int setPwdChangeOk(String mid, String pwd);

	public int setMemberUpdate(MemberVO vo);

	public int setUserDel(String mid);

	public String setQrCodeCreate(String realPath, String mid, String qrCodeToken);

	public void setQrCodeLogin(String mid, String qrCodeToken, String today);

	public String getQrCodeLoginCheck(String mid, String qrCodeToken);

	public MemberVO getAccountSearch(String accountNumber);

	public List<MemberVO> getMemberList(MemberVO vo, int startIndexNo, int pageSize);

	public int getNewMemberCnt();

	public int getUserNoCnt();


}
