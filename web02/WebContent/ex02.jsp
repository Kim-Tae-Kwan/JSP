<%@ page language="java" 
		contentType="text/html; charset=UTF-8"
    	pageEncoding="UTF-8" 
    	session="true"
    	info="페이지 설명. 디렉티브에 주석을 사용할 수 없어 info 사용."
    	import="java.util.*"
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
	<%! //선언부 - 메소드정의 부분
	
	//필드
	int su = 1234;
	
	// 내부 클래스
	static class Inner01{}
	class Inner02{}
	
	//메소드	
	public Date func(){
		//out.println("화면에..") -> out 객체는 선언부에서 사용 불가능.
		System.out.println("메서드 호출");
		return new Date();
	}
	public static void func2(){}
	%>
<body>
	<h1>jsp 페이지</h1>
	
	<%=func() %><br>
	<%=new Inner01() %><br>
	<%=new Inner02() %><br>
	<%=su %>
</body>
</html>