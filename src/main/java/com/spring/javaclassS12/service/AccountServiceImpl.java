package com.spring.javaclassS12.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS12.dao.AccountDAO;
import com.spring.javaclassS12.vo.AccountVO;
import com.spring.javaclassS12.vo.SavingAccountVO;

@Service
public class AccountServiceImpl implements AccountService {

	@Autowired
	AccountDAO accountDAO;

	@Override
	public int setAccountInput(AccountVO vo) {
		return accountDAO.setAccountInput(vo);
	}

	@Override
	public int getBalanceSearch(String mid) {
		return accountDAO.getBalanceSearch(mid);
	}

	@Override
	public AccountVO getAccInfor(String mid) {
		return accountDAO.getAccInfor(mid);
	}

	// 은행 전체 잔고 조회
	@Override
	public int getTotalBalance(String flagSw) {
		return accountDAO.getTotalBalance(flagSw);
	}

	// 은행 전체 입금액 조회
	@Override
	public int getTotalDeposit(String flagSw) {
		return accountDAO.getTotalDeposit(flagSw);
	}

	// 은행 전체 출금액 조회
	@Override
	public int getTotalWithdraw(String flagSw) {
		return accountDAO.getTotalWithdraw(flagSw);
	}

	@Override
	public int setAccountInputOk(AccountVO aVO) {
		return accountDAO.setAccountInputOk(aVO);
	}

	@Override
	public List<AccountVO> getAccountFavorite(String mid) {
		return accountDAO.getAccountFavorite(mid);
	}

	@Override
	public int setAccountDelete(int idx) {
		return accountDAO.setAccountDelete(idx);
	}

	@Override
	public AccountVO getAccountFavorite2(String mid, String accountNumber) {
		return accountDAO.getAccountFavorite2(mid, accountNumber);
	}

	@Override
	public List<AccountVO> getAccountHistory(String mid) {
		return accountDAO.getAccountHistory(mid);
	}

	@Override
	public int getAccountDaily() {
		return accountDAO.getAccountDaily();
	}

	@Override
	public int setSavingAccountInput(SavingAccountVO saVo) {
		return accountDAO.setSavingAccountInput(saVo);
	}

	@Override
	public List<AccountVO> getAccountDailyList(int startIndexNo, int pageSize, String flagSw) {
		return accountDAO.getAccountDailyList(startIndexNo, pageSize, flagSw);
	}

	@Override
	public int getAccountDailyI(String flagSw) {
		return accountDAO.getAccountDailyI(flagSw);
	}

	@Override
	public int getAccountDailyC(String flagSw) {
		return accountDAO.getAccountDailyC(flagSw);
	}

	@Override
	public int getAccountDailyE(String flagSw) {
		return accountDAO.getAccountDailyE(flagSw);
	}

	@Override
	public int getAccountDailyG(String flagSw) {
		return accountDAO.getAccountDailyG(flagSw);
	}


	


}
