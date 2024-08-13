package com.spring.javaclassS12.pagination;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS12.dao.AccountDAO;
import com.spring.javaclassS12.dao.BoardDAO;
import com.spring.javaclassS12.dao.MemberDAO;
import com.spring.javaclassS12.dao.QnaDAO;
import com.spring.javaclassS12.vo.PageVO;

@Service
public class PageProcess {

	@Autowired
	BoardDAO boardDAO;
	
	@Autowired
	MemberDAO memberDAO;
	
	@Autowired
	AccountDAO accountDAO;
	
	@Autowired
	QnaDAO qnaDAO;
	
	public PageVO totRecCnt(int pag, int pageSize, String section, String part, String searchString) {
		PageVO pageVO = new PageVO();
		
		int totRecCnt = 0;
		String search = "";
		
		if(section.equals("board")) {
			if(searchString.equals("")) {
				totRecCnt = boardDAO.totRecCnt(part);
			}
			else {
				search = searchString.split("/")[0];
				searchString = searchString.split("/")[1];
				totRecCnt = boardDAO.totRecCntSearch(search, searchString, part);
			}
		}
		else if(section.equals("member")) {
			totRecCnt = memberDAO.totRecCnt();
		}
		else if(section.equals("dailyAccount")) {
			String flagSw = part;
			//System.out.println("flagSw : " + flagSw);
			totRecCnt = accountDAO.totRecCnt(flagSw);
		}
		else if(section.equals("qna")) totRecCnt = qnaDAO.totRecCnt();
		
		int totPage = (totRecCnt % pageSize) == 0 ? (totRecCnt / pageSize) : (totRecCnt / pageSize) + 1;
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage - 1) / blockSize;
		
		pageVO.setPag(pag);
		pageVO.setPageSize(pageSize);
		pageVO.setTotRecCnt(totRecCnt);
		pageVO.setTotPage(totPage);
		pageVO.setStartIndexNo(startIndexNo);
		pageVO.setCurScrStartNo(curScrStartNo);
		pageVO.setBlockSize(blockSize);
		pageVO.setCurBlock(curBlock);
		pageVO.setLastBlock(lastBlock);
		pageVO.setSearch(search);
		pageVO.setSearchString(searchString);
		pageVO.setPart(part);
				
		return pageVO;
	}
	
	
}
