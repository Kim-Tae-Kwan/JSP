package com.bit.emp.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.bit.util.Mysql;

public class EmpDao {
	
	private boolean test;
	
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public void setTest(boolean test) {
		this.test = test;
	}
	
	public List<EmpDto> getList() throws SQLException {
		List<EmpDto> list = new ArrayList<>();
		String sql = "select * from emp order by empno";
		
		try {
			pstmt = Mysql.getConnection().prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				EmpDto bean = new EmpDto();
				bean.setEmpno(rs.getInt("empno"));
				bean.setEname(rs.getString("ename"));
				bean.setDeptno(rs.getInt("deptno"));
				bean.setHiredate(rs.getDate("hiredate"));
				bean.setJob(rs.getString("job"));
				bean.setSal(rs.getInt("sal"));
				list.add(bean);
			}
			
		}finally {
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(Mysql.getConnection() != null) Mysql.getConnection().close();
		}
		return list;
	}
	public EmpDto getOne(int empno) throws SQLException {
		EmpDto bean = null;
		String sql = "select * from emp where empno = ?";
		
		try {
			pstmt = Mysql.getConnection().prepareStatement(sql);
			pstmt.setInt(1, empno);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean = new EmpDto();
				bean.setEmpno(rs.getInt("empno"));
				bean.setEname(rs.getString("ename"));
				bean.setDeptno(rs.getInt("deptno"));
				bean.setHiredate(rs.getDate("hiredate"));
				bean.setJob(rs.getString("job"));
				bean.setSal(rs.getInt("sal"));
			}
			
		}finally {
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(Mysql.getConnection() != null) Mysql.getConnection().close();
		}
		return bean;
	}
	public boolean insertOne(EmpDto bean) throws SQLException {
		String sql = "insert into emp (empno,ename,sal,hiredate) values (?,?,?,now())";
		
		try {
			//Mysql.getConnection().setAutoCommit(false);
			pstmt = Mysql.getConnection().prepareStatement(sql);
			pstmt.setInt(1, bean.getEmpno());
			pstmt.setString(2, bean.getEname());
			pstmt.setInt(3, bean.getSal());
			return pstmt.executeUpdate() > 0;
		}finally {
//			if(test) Mysql.getConnection().rollback();
//			else Mysql.getConnection().commit();
			if(pstmt != null) pstmt.close();
			if(Mysql.getConnection() != null) Mysql.getConnection().close();
		}
	}
	public int updateOne(EmpDto bean) throws SQLException {
		String sql = "update emp set ename=?, sal=?, hiredate=now() where empno = ?";
		try {
			pstmt = Mysql.getConnection().prepareStatement(sql);
			pstmt.setString(1, bean.getEname());
			pstmt.setInt(2, bean.getSal());
			pstmt.setInt(3, bean.getEmpno());
			return pstmt.executeUpdate();
		}finally {
			if(pstmt != null) pstmt.close();
			if(Mysql.getConnection() != null) Mysql.getConnection().close();
		}
	}
	public int deleteOne(int empno) throws SQLException {
		String sql = "delete from emp where empno=?";
		try {
			pstmt = Mysql.getConnection().prepareStatement(sql);
			pstmt.setInt(1, empno);
			return pstmt.executeUpdate();
		}finally {
			if(pstmt != null) pstmt.close();
			if(Mysql.getConnection() != null) Mysql.getConnection().close();
		}
	}
}