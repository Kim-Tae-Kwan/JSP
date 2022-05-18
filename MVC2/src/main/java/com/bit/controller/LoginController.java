package com.bit.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bit.model.LoginDao;

public class LoginController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		session.invalidate();// 세션 갱신.
		RequestDispatcher rd = req.getRequestDispatcher("index.jsp");
		rd.forward(req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		int empno = Integer.parseInt(req.getParameter("empno"));
		String ename = req.getParameter("ename");
		
		HttpSession session = req.getSession();
		LoginDao dao = new LoginDao();
		if(dao.loginResult(empno, ename)) {
			session.setAttribute("result", true);
			session.setAttribute("id", ename);
		}
		resp.sendRedirect("../");
	}
}
