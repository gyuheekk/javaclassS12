package com.spring.javaclassS12.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS12.vo.AccountVO;
import com.spring.javaclassS12.vo.SavingAccountVO;

public interface AccountDAO {

	public int setAccountInput(@Param("vo") AccountVO vo);

	public int getBalanceSearch(@Param("mid") String mid);

	public AccountVO getAccInfor(@Param("mid") String mid);

	public int getTotalBalance(@Param("flagSw") String flagSw);

	public int getTotalDeposit(@Param("flagSw") String flagSw);

	public int getTotalWithdraw(@Param("flagSw") String flagSw);

	public int setAccountInputOk(@Param("aVo") AccountVO aVO);

	public List<AccountVO> getAccountFavorite(@Param("mid") String mid);

	public int setAccountDelete(@Param("idx") int idx);

	public AccountVO getAccountFavorite2(@Param("mid") String mid, @Param("accountNumber") String accountNumber);

	public List<AccountVO> getAccountHistory(@Param("mid") String mid);

	public int totRecCnt(@Param("flagSw") String flagSw);

	public int getAccountDaily();

	public int setSavingAccountInput(@Param("saVo") SavingAccountVO saVo);

	public List<AccountVO> getAccountDailyList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("flagSw") String flagSw);

	public int getAccountDailyI(@Param("flagSw") String flagSw);

	public int getAccountDailyC(@Param("flagSw") String flagSw);

	public int getAccountDailyE(@Param("flagSw") String flagSw);
	
	public int getAccountDailyG(@Param("flagSw") String flagSw);

	public int getDTotalDeposit(@Param("flagSw") String flagSw);

	public int getDTotalWithdraw(@Param("flagSw") String flagSw);




}
