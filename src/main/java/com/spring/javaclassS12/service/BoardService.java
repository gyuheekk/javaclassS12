package com.spring.javaclassS12.service;

import java.util.ArrayList;
import java.util.List;

import com.spring.javaclassS12.vo.BoardReplyVO;
import com.spring.javaclassS12.vo.BoardVO;

public interface BoardService {

	public ArrayList<BoardVO> getBoardList();
	
	public ArrayList<BoardVO> getBoardList(int startIndexNo, int pageSize, String part);

	public void imgCheck(String content);

	public int setBoardInput(BoardVO vo);

	public void setReadNumPlus(int idx);

	public BoardVO getBoardContent(int idx);

	public BoardVO getPreNexSearch(int idx, String string);

	public List<BoardReplyVO> getBoardReply(int idx);

	public void imgBackup(String content);

	public void imgDelete(String content);

	public int setBoardUpdate(BoardVO vo);

	public int setBoardDelete(int idx);

	public BoardReplyVO getBoardParentReplyCheck(int boardIdx);

	public int setBoardReplyInput(BoardReplyVO replyVO);

	public void setReplyOrderUpdate(int boardIdx, int re_order);

	public List<BoardVO> getBoardSearchList(int startIndexNo, int pageSize, String part, String search, String searchString);

	public int setBoardReplyDelete(int idx);

	public int getBoardCount(String part);

}
