package com.bit.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bit.model.EmpDto;

public class Ex12 extends HttpServlet {
	public static ArrayList<EmpDto> list = new ArrayList<>();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//DB select 가정함.
//		for (int i = 1; i < 5; i++) {
//			EmpDto bean = new EmpDto();
//			bean.setEmpno(1111 * i);
//			bean.setEname("test" + i);
//			bean.setSal(1000 * i);
//			list.add(bean);
//		}
		
		//
		PrintWriter out = null;
		try {
			out = resp.getWriter();
			out.println("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
			out.println("<emp>");
			for(EmpDto bean : list) {
				out.println("	<row>");
				out.println("		<empno>" + bean.getEmpno() + "</empno>");
				out.println("		<ename>" + bean.getEname() + "</ename>");
				out.println("		<sal>" + bean.getSal() + "</sal>");
				out.println("	</row>");
			}
			out.println("</emp>");
		}finally {
			out.close();
		}
	}
}
