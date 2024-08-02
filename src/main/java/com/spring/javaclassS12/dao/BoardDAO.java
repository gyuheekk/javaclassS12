package com.spring.javaclassS12.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS12.vo.BoardReplyVO;
import com.spring.javaclassS12.vo.BoardVO;

public interface BoardDAO {

	public ArrayList<BoardVO> getBoardList();

	public int setBoardInput(@Param("vo") BoardVO vo);

	public BoardVO getBoardContent(@Param("idx") int idx);

	public int totRecCnt(@Param("part") String part);
	
	public ArrayList<BoardVO> getBoardList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("part") String part);

	public void setReadNumPlus(@Param("idx") int idx);

	public BoardVO getPreNexSearch(@Param("idx") int idx, @Param("str") String str);

	public int setBoardUpdate(@Param("vo") BoardVO vo);

	public int setBoardDelete(@Param("idx") int idx);

	public BoardReplyVO getBoardParentReplyCheck(@Param("boardIdx") int boardIdx);

	public int setBoardReplyInput(@Param("replyVO") BoardReplyVO replyVO);

	public List<BoardReplyVO> getBoardReply(@Param("idx") int idx);

	public void setReplyOrderUpdate(@Param("boardIdx") int boardIdx, @Param("re_order") int re_order);

	public List<BoardVO> getBoardSearchList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("part") String part, @Param("search") String search, @Param("searchString") String searchString);

	public int totRecCntSearch(@Param("search") String search, @Param("searchString") String searchString, @Param("part") String part);

	public int setBoardReplyDelete(@Param("idx") int idx);

	public int getBoardCount(@Param("part") String part);

}
