package com.spring.javaclassS12.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS12.vo.MemberVO;

public interface MemberDAO {

	public MemberVO getMemberIdCheck(@Param("mid") String mid);

	public int setMemberJoin(@Param("vo") MemberVO vo);

	public int setAccountCreate(@Param("vo") MemberVO vo);

	public void setMemberPasswordUpdate(@Param("mid") String mid, @Param("pwd") String pwd);

	public MemberVO getMemberNameCheck(@Param("name") String name);

	public int setPwdChangeOk(@Param("mid") String mid, @Param("pwd") String pwd);

	public int setMemberUpdate(@Param("vo") MemberVO vo);

	public int setUserDel(@Param("mid") String mid);

	public void setQrCodeLogin(@Param("mid") String mid, @Param("qrCodeToken") String qrCodeToken, @Param("today") String today);
	
	public String getQrCodeLoginCheck(@Param("mid") String mid, @Param("qrCodeToken") String qrCodeToken);

	public MemberVO getAccountSearch(@Param("accountNumber") String accountNumber);

	public List<MemberVO> getMemberList(@Param("vo") MemberVO vo, @Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public int totRecCnt();

	public int getNewMemberCnt();

	public int getUserNoCnt();
}
