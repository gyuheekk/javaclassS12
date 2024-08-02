package com.spring.javaclassS12.service;

import java.util.List;

import com.spring.javaclassS12.vo.AccountVO;
import com.spring.javaclassS12.vo.SavingAccountVO;

public interface AccountService {

	public int setAccountInput(AccountVO vo);

	public int getBalanceSearch(String mid);

	public AccountVO getAccInfor(String mid);

	public int getTotalBalance(String flagSw);

	public int getTotalDeposit(String flagSw);

	public int getTotalWithdraw(String flagSw);

	public int setAccountInputOk(AccountVO aVO);

	public List<AccountVO> getAccountFavorite(String mid);

	public int setAccountDelete(int idx);

	public AccountVO getAccountFavorite2(String mid, String accountNumber);

	public List<AccountVO> getAccountHistory(String mid);

	public int getAccountDaily();

	public int setSavingAccountInput(SavingAccountVO saVo);

	public List<AccountVO> getAccountDailyList(int startIndexNo, int pageSize, String flagSw);

	public int getAccountDailyI(String flagSw);

	public int getAccountDailyC(String flagSw);

	public int getAccountDailyE(String flagSw);
	
	public int getAccountDailyG(String flagSw);





}
