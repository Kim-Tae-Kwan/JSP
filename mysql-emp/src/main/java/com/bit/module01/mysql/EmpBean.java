package com.bit.module01.mysql;

public class EmpBean {
	// java Bean class
	private int empno;
	private String ename;
	private int sal;
	
	// Getter & Setter
	public int getEmpno() {
		return empno;
	}
	public void setEmpno(int empno) {
		this.empno = empno;
	}
	public String getEname() {
		return ename;
	}
	public void setEname(String ename) {
		this.ename = ename;
	}
	public int getSal() {
		return sal;
	}
	public void setSal(int sal) {
		this.sal = sal;
	}

	@Override
	public String toString() {
		return "empno : " + empno + ", ename : " + ename + ", sal : "+sal;
	}
}
