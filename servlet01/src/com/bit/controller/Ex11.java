package com.bit.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Ex11 extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		String id = req.getParameter("id");
		String pw = req.getParameter("pw");
		String[] chk = req.getParameterValues("chk");
		String ra = req.getParameter("ra");
		String sel = req.getParameter("sel");
		String ta = req.getParameter("ta");
		
		PrintWriter out = null;
		try{
			out = resp.getWriter();
			out.println("<html>");
			out.println("<meta charset = \"utf-8\">");
			
			out.println("<body>");
			out.println("<h1>result page</h1>");
			
			out.println("<div>");
			out.println("id:" + id);
			out.println("</div>");
			
			out.println("<div>");
			out.println("pw:" + pw);
			out.println("</div>");
			
			out.println("<div>");
			out.println("checkbox:" + Arrays.toString(chk));
			out.println("</div>");
			
			out.println("<div>");
			out.println("radio:" + ra);
			out.println("</div>");
			
			out.println("<div>");
			out.println("select:" + sel);
			out.println("</div>");
			
			out.println("<div>");
			out.println("<pre>" + ta + "</pre>");
			//out.println("textarea:" + ta.replace("\n", "<br/>"));
			out.println("</div>");
			
			out.println("</body>");
			out.println("</html>");
			
			
			
			
		}finally {
			out.close();
		}
	}
}
