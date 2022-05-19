package com.bit.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.Servlet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class step01 implements Servlet{
	ServletConfig config;
	
	@Override
	public void destroy() {
		System.out.println("서블릿 객체 소멸");
	}
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		System.out.println("서블릿 객체 생성");
		this.config = config;
	}

	@Override
	public ServletConfig getServletConfig() {
		System.out.println("getServletConfig");
		return this.config;
	}

	@Override
	public String getServletInfo() {
		System.out.println("getServletInfo");
		return "servlet info...";
	}

	@Override
	public void service(ServletRequest req, ServletResponse res) throws ServletException, IOException {
		System.out.println("service");
		OutputStream os = res.getOutputStream();
//		out.println("<h1>hello world</h1>");
//		out.println("<p><a href=\"ex02.html\">link</a></p>");
		
		File file = new File("D:/Development/webbook/servlet01/logo.jpg");
		FileInputStream fis = new FileInputStream(file);
		while(true) {
			int su = fis.read();
			if(su==1) break;
			os.write(su);
		}
		
		
		fis.close();
		os.close();
	}
}
