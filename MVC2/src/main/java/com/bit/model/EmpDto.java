package com.bit.model;

import java.sql.Timestamp;

public class EmpDto {
	private int empno;
	private String ename;
	private int sal;
	private String job;
	private Timestamp hiredate;
	
	
	public String getJob() {
		return job;
	}
	public void setJob(String job) {
		this.job = job;
	}
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
	public Timestamp getHiredate() {
		return hiredate;
	}
	public void setHiredate(Timestamp hiredate) {
		this.hiredate = hiredate;
	}
	@Override
	public String toString() {
		return "EmpDto [empno=" + empno + ", ename=" + ename + ", sal=" + sal + ", job=" + job + ", hiredate="
				+ hiredate + "]";
	}
}
