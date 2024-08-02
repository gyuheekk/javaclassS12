package com.spring.javaclassS12.interceptor;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class NoMemberInterceptor extends HandlerInterceptorAdapter {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		HttpSession session = request.getSession();
		int level = session.getAttribute("sLevel")==null ? 99 : (int) session.getAttribute("sLevel");
		// 로그인한 회원이 아니라면 로그인창으로 보낸다.
		if(level > 5) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/message/noMember");
			dispatcher.forward(request, response);
			return false;
		}
		
		return true;
	}

}
