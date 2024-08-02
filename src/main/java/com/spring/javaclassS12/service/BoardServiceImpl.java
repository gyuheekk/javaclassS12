package com.spring.javaclassS12.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.spring.javaclassS12.dao.BoardDAO;
import com.spring.javaclassS12.vo.BoardReplyVO;
import com.spring.javaclassS12.vo.BoardVO;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	BoardDAO boardDAO;

	@Override
	public ArrayList<BoardVO> getBoardList() {
		return boardDAO.getBoardList();
	}

	@Override
	public ArrayList<BoardVO> getBoardList(int startIndexNo, int pageSize, String part) {
		return boardDAO.getBoardList(startIndexNo, pageSize, part);
	}

//content에 이미지가 있다면 이미지를 'ckeditor'폴더에서 'board'폴더로 복사처리한다.
	@Override
	public void imgCheck(String content) {
		// 								0	        1         2         3         4  
		//								01234567890123456789012345678901234567890123456789
		// <p><img alt="" src="/javaclassS/data/ckeditor/240625154024_고얌미.jpg" style="height:500px; width:500px" /></p>
		// <p><img alt="" src="/javaclassS/data/board/240625154024_고얌미.jpg" style="height:500px; width:500px" /></p>
		// <p><img        src="/javaclassS12/data/ckeditor/240711195054_안녕 나 규희.jpg" style="height:640px; width:640px" />
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest(); //절대경로를 가져오기위해 (realPath)
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 33;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String origFilePath = realPath + "ckeditor/" + imgFile; 
			String copyFilePath = realPath + "board/" + imgFile;
			
			fileCopyCheck(origFilePath, copyFilePath); // ckeditor폴더의 그림파일을 board폴더위피로 복사처리하는 메소드.
			
			if(nextImg.indexOf("src=\"/") == -1) sw = false;
			else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
		}
	}

	//파일 복사처리
	private void fileCopyCheck(String origFilePath, String copyFilePath) {
		try {
			FileInputStream fis = new FileInputStream(new File(origFilePath));
			FileOutputStream fos = new FileOutputStream(new File(copyFilePath));
			
			byte[] b = new byte[2048];
			int cnt = 0;
			while((cnt = fis.read(b)) != -1) {
				fos.write(b, 0, cnt);
			}
			fos.flush(); // 남아있는거 다 보냄
			fos.close(); // 끝나면 닫아주기(안 닫으면 에러남. 계속 열고닫고 작업 해야 함)
			fis.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public int setBoardInput(BoardVO vo) {
		return boardDAO.setBoardInput(vo);
	}

	@Override
	public void setReadNumPlus(int idx) {
		boardDAO.setReadNumPlus(idx);
	}

	@Override
	public BoardVO getBoardContent(int idx) {
		return boardDAO.getBoardContent(idx);
	}

	@Override
	public BoardVO getPreNexSearch(int idx, String str) {
		return boardDAO.getPreNexSearch(idx, str);
	}

	@Override
	public List<BoardReplyVO> getBoardReply(int idx) {
		return boardDAO.getBoardReply(idx);
	}

	@Override
	public void imgBackup(String content) {
		// 								0	        1         2         3         4  
		//								01234567890123456789012345678901234567890123456789
		// <p><img alt="" src="/javaclassS/data/board/240625154024_고얌미.jpg" style="height:500px; width:500px" /></p>
		// <p><img alt="" src="/javaclassS/data/ckeditor/240625154024_고얌미.jpg" style="height:500px; width:500px" /></p>
		// <p><img        src="/javaclassS12/data/board/240711195054_안녕 나 규희.jpg" style="height:640px; width:640px" />
		
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest(); //절대경로를 가져오기위해 (realPath)
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 30;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String origFilePath = realPath + "board/" + imgFile; 
			String copyFilePath = realPath + "ckeditor/" + imgFile;
			
			fileCopyCheck(origFilePath, copyFilePath); // ckeditor폴더의 그림파일을 board폴더위피로 복사처리하는 메소드.
			
			if(nextImg.indexOf("src=\"/") == -1) sw = false;
			else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
		}
	}

	@Override
	public void imgDelete(String content) {
		//								0	        1         2         3         4  
		//								01234567890123456789012345678901234567890123456789
		// <p><img alt="" src="/javaclassS/data/board/240625154024_고얌미.jpg" style="height:500px; width:500px" /></p>
		// <p><img alt="" src="/javaclassS/data/ckeditor/240625154024_고얌미.jpg" style="height:500px; width:500px" /></p>
		// <p><img        src="/javaclassS12/data/board/240711195054_안녕 나 규희.jpg" style="height:640px; width:640px" />
		
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest(); //절대경로를 가져오기위해 (realPath)
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 30;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
		String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
		
		String origFilePath = realPath + "board/" + imgFile; 
		
		fileDelete(origFilePath); // board폴더의 그림파일을 삭제한다.
		
		if(nextImg.indexOf("src=\"/") == -1) sw = false;
		else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
		}
	}

	//서버에 존재하는 파일 삭제처리
	private void fileDelete(String origFilePath) {
		File delFile = new File(origFilePath);
		if(delFile.exists()) delFile.delete();
	}

	@Override
	public int setBoardUpdate(BoardVO vo) {
		return boardDAO.setBoardUpdate(vo);
	}

	@Override
	public int setBoardDelete(int idx) {
		return boardDAO.setBoardDelete(idx);
	}

	@Override
	public BoardReplyVO getBoardParentReplyCheck(int boardIdx) {
		return boardDAO.getBoardParentReplyCheck(boardIdx);
	}

	@Override
	public int setBoardReplyInput(BoardReplyVO replyVO) {
		return boardDAO.setBoardReplyInput(replyVO);
	}

	@Override
	public void setReplyOrderUpdate(int boardIdx, int re_order) {
		boardDAO.setReplyOrderUpdate(boardIdx, re_order);
	}

	@Override
	public List<BoardVO> getBoardSearchList(int startIndexNo, int pageSize, String part, String search, String searchString) {
		return boardDAO.getBoardSearchList(startIndexNo, pageSize, part, search, searchString);
	}

	@Override
	public int setBoardReplyDelete(int idx) {
		return boardDAO.setBoardReplyDelete(idx);
	}

	@Override
	public int getBoardCount(String part) {
		return boardDAO.getBoardCount(part);
	}


}
