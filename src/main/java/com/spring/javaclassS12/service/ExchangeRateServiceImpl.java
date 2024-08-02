package com.spring.javaclassS12.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.lang.reflect.Type;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.spring.javaclassS12.vo.ExchangeRateVO;

@Service
public class ExchangeRateServiceImpl implements ExchangeRateService {

	private String authkey = "https://www.koreaexim.go.kr/site/program/financial/exchangeJSON?authkey=5wwuTWVo28tdVcpsD2HidBhEH5PS6b1f&data=AP01&searchdate=";
	
	@Override
	public List<ExchangeRateVO> getExchangeRateUnit(String searchdate) {
		List<ExchangeRateVO> unitVos = new ArrayList<ExchangeRateVO>();
		String json = "";
		URL url;
		try {
			url = new URL(authkey+searchdate);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setDefaultUseCaches(false);
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
			conn.setRequestProperty("Content-Type", "application/json");
			
			BufferedReader br = new BufferedReader(new InputStreamReader((conn.getInputStream())));
			String output;
			if ((output = br.readLine()) != null) {
				json += output;
			}
			conn.disconnect();
			// (방법2) DTO(VO)를 이용하는 방법
			Gson gson = new Gson();
			// JSON 문자열을 List<Person> 객체로 변환
			Type type = new TypeToken<List<ExchangeRateVO>>() {}.getType();
			List<ExchangeRateVO> vos = gson.fromJson(json, type);
			
			// 리스트 내의 각 객체 처리
			for (ExchangeRateVO vo : vos) {
				
				ExchangeRateVO resVo = new ExchangeRateVO();
				resVo.setCur_nm(vo.getCur_nm());
				resVo.setCur_unit(vo.getCur_unit());
				unitVos.add(resVo);
			}
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return unitVos;
	}
	
	@Override
	public String getCurrencyRate(String receiveCountry, String searchdate) {
    String json = "";
    String tts = "";
    
		URL url;
		try {
			url = new URL(authkey+searchdate);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setDefaultUseCaches(false);
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
			conn.setRequestProperty("Content-Type", "application/json");
			
			BufferedReader br = new BufferedReader(new InputStreamReader((conn.getInputStream())));
			String output;
			if ((output = br.readLine()) != null) {
			  json += output;
			}
			conn.disconnect();
			
			// api로 담아온 자료는 json형식의 문자열이기에 json객체로 바꿔준후 각각의 자료를 변수에 담아서 사용(DB의 저장등..)할수 있게한다.
			
	    // (방법1) JSON 배열로 변환
	    JSONArray jsonArray = new JSONArray(json);
	
	    // 배열 내의 각 JSON 객체 처리
	    for (int i = 0; i < jsonArray.length(); i++) {
	      JSONObject jsonObject = jsonArray.getJSONObject(i);
	      String cur_unit = jsonObject.getString("cur_unit");
	      tts = jsonObject.getString("tts");
//	      String deal_bas_r = jsonObject.getString("deal_bas_r");
	
	      // 출력
//	      System.out.println("result " + result);
//	      System.out.println("cur_nm: " + cur_nm);
//	      System.out.println("ttb: " + ttb);
//	      System.out.println("deal_bas_r: " + deal_bas_r);
//	      System.out.println();
	      
	      if(cur_unit.equals(receiveCountry)) {
	      	//System.out.println("tts : " + tts);
	      	break; 
	      }
	    }
	    
	    // (방법2) DTO(VO)를 이용하는 방법
//			Gson gson = new Gson();
      // JSON 문자열을 List<Person> 객체로 변환
//      Type type = new TypeToken<List<ExchangeRateVO>>() {}.getType();
//      List<ExchangeRateVO> vos = gson.fromJson(json, type);

      // 리스트 내의 각 객체 처리
//      for (ExchangeRateVO vo : vos) {
//      	System.out.println("cur_unit: " + vo.getCur_unit());
//				System.out.println("cur_nm: " + vo.getCur_nm());
//				System.out.println("ttb: " + vo.getTtb());
//				System.out.println("tts: " + vo.getTts());
//				System.out.println("deal_bas_r: " + vo.getDeal_bas_r());
//				System.out.println();
//      }
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
			
    return json + "@" + tts;
	}

	@Override
	public String getCurrencyRateCompute(String receiveCountry, String sendAmount, String searchdate) {
//    Date today = new Date();
//    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//    String strToday = sdf.format(today);
//		System.out.println("searchdate..: " + searchdate);
    String json = "";
    String tts = "";
		URL url;
		try {
			url = new URL(authkey+searchdate);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setDefaultUseCaches(false);
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
			conn.setRequestProperty("Content-Type", "application/json");
			
			BufferedReader br = new BufferedReader(new InputStreamReader((conn.getInputStream())));
			String output;
			if ((output = br.readLine()) != null) {
			  json += output;
			}
			conn.disconnect();
			
	    JSONArray jsonArray = new JSONArray(json);
	
	    for (int i = 0; i < jsonArray.length(); i++) {
	      JSONObject jsonObject = jsonArray.getJSONObject(i);
	      String cur_unit = jsonObject.getString("cur_unit");
	      tts = jsonObject.getString("tts");
	      
	      if(cur_unit.equals(receiveCountry)) break; 
	    }
	    
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		//System.out.println("tts : " + tts);
		//System.out.println("receiveCountry : " + receiveCountry);
		// 환율계산공식 = (송금액 / 그나라 환율)  , 단, 100원단위로 환율을 제공하는 나라는 ((송금액*100)/그나라환율) 로 계산한다.
		double doubleTts = 0.0;
		if(receiveCountry.indexOf("(100)") != -1)	doubleTts = (100.0 / Double.parseDouble(tts.replaceAll(",", ""))) * Double.parseDouble(sendAmount);
		else doubleTts = Double.parseDouble(sendAmount) / Double.parseDouble(tts.replaceAll(",", ""));
		//System.out.println("doubleTts : " + doubleTts);
		return doubleTts + "";
	}
	


}
