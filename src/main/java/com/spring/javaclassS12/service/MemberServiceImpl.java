package com.spring.javaclassS12.service;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageConfig;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.spring.javaclassS12.common.JavaclassProvide;
import com.spring.javaclassS12.dao.MemberDAO;
import com.spring.javaclassS12.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberDAO memberDAO;
	
	@Autowired
	JavaclassProvide javaclassProvide;
	
	@Override
	public MemberVO getMemberIdCheck(String mid) {
		return memberDAO.getMemberIdCheck(mid);
	}

	@Override
	public String fileUpload(MultipartFile fName, String mid) {
		// 파일이름 중복처리를 위해 UUID객체 활용
		UUID uid = UUID.randomUUID();
		String oFileName = fName.getOriginalFilename();
		String sFileName = mid + "_" + uid.toString().substring(0,8) + "_" + oFileName;
		
		// 서버에 파일 올리기
		try {
			javaclassProvide.writeFile(fName, sFileName, "member");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return sFileName;
	}

	@Override
	public int setMemberJoin(MemberVO vo) {
		
		// 계좌번호 발급 (생년월일 6자리 + 난수6자리 -> 총 12자리 / ex.생년월일이 1999.12.31 이라면? 991-231-123456)
		int rand = 0;
		String strRand = "";
	  for(int i=0; i<6; i++) { 
	  	rand = (int)(Math.random()*10);
	  	strRand += rand + "";
  	}
	  
	  // 1999-05-24 : 990-524-123456
	  String accountNumber = vo.getBirth().substring(2,4)+vo.getBirth().substring(5,6)+"-"+vo.getBirth().substring(6,7)+vo.getBirth().substring(8,10)+"-"+strRand;
		vo.setAccountNumber(accountNumber);
		
		return memberDAO.setMemberJoin(vo);
	}

	@Override
	public int setAccountCreate(MemberVO vo) {
		return memberDAO.setAccountCreate(vo);
	}

	@Override
	public void setMemberPasswordUpdate(String mid, String pwd) {
		memberDAO.setMemberPasswordUpdate(mid, pwd);
	}

	@Override
	public MemberVO getMemberNameCheck(String name) {
		return memberDAO.getMemberNameCheck(name);
	}

	@Override
	public int setPwdChangeOk(String mid, String pwd) {
		return memberDAO.setPwdChangeOk(mid, pwd);
	}

	@Override
	public int setMemberUpdate(MemberVO vo) {
		return memberDAO.setMemberUpdate(vo);
	}

	@Override
	public int setUserDel(String mid) {
		return memberDAO.setUserDel(mid);
	}

	@Override
	public String setQrCodeCreate(String realPath, String mid, String qrCodeToken) {
		String qrCodeName = javaclassProvide.newNameCreate(2);
		String qrCodeImage = "";
		try {
			String today = qrCodeName.substring(0, qrCodeName.length()-3);
			
			// QR코드안의 한글 인코딩
			qrCodeName += mid;
			//qrCodeImage = "http://49.142.157.251:9090/javaclassS/member/qrLoginConfirm/"+mid+"/"+qrCodeToken+"/"+today;
			qrCodeImage = "http://192.168.50.60:9090/javaclassS12/member/qrLoginConfirm/"+mid+"/"+qrCodeToken+"/"+today;
			//HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
			//qrCodeImage = request.getContextPath()+"/member/qrLoginConfirm/"+mid+"/"+qrCodeToken+"/"+today;
			qrCodeImage = new String(qrCodeImage.getBytes("UTF-8"), "ISO-8859-1");
			
			// qr 코드 만들기
			QRCodeWriter qrCodeWriter = new QRCodeWriter();
			BitMatrix bitMatrix = qrCodeWriter.encode(qrCodeImage, BarcodeFormat.QR_CODE, 200, 200);
			
			//MatrixToImageConfig matrixToImageConfig = new MatrixToImageConfig();  // 기본컬러(글자색:검정,배경색:흰색)
			int qrCodeColor = 0xFF000000;
			int qrCodeBackColor = 0xFFFFFFFF;
			
			MatrixToImageConfig matrixToImageConfig = new MatrixToImageConfig(qrCodeColor, qrCodeBackColor);
			BufferedImage bufferedImage = MatrixToImageWriter.toBufferedImage(bitMatrix, matrixToImageConfig);
			
			// 랜더링된 QR코드 이미지를 실제 그림파일로 만들어낸다.
			ImageIO.write(bufferedImage, "png", new File(realPath + qrCodeName + ".png"));
			
			// QR코드 생성후, 생성된 정보를 DB에 저장시켜준다.(모바일에서 qr코드 확인시에 아이디가 본회원에 확인되면 DB에 저장한다.) 
			//memberDAO.setQrCodeLogin(mid, qrCodeToken, today);
		} catch (IOException e) {
			e.printStackTrace();
		} catch (WriterException e) {
			e.printStackTrace();
		}
		return qrCodeName;
	}

	@Override
	public void setQrCodeLogin(String mid, String qrCodeToken, String today) {
		memberDAO.setQrCodeLogin(mid, qrCodeToken, today);
	}

	@Override
	public String getQrCodeLoginCheck(String mid, String qrCodeToken) {
		return memberDAO.getQrCodeLoginCheck(mid, qrCodeToken);
	}

	@Override
	public MemberVO getAccountSearch(String accountNumber) {
		return memberDAO.getAccountSearch(accountNumber);
	}

	@Override
	public List<MemberVO> getMemberList(MemberVO vo, int startIndexNo, int pageSize) {
		return memberDAO.getMemberList(vo, startIndexNo, pageSize);
	}

	@Override
	public int getNewMemberCnt() {
		return memberDAO.getNewMemberCnt();
	}

	@Override
	public int getUserNoCnt() {
		return memberDAO.getUserNoCnt();
	}
}
