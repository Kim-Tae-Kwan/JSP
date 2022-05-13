package com.bit.module01.mysql;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class BitMysql {
	// Singleton Pattern
	private static Connection conn = null;
	static String diver = "com.mysql.cj.jdbc.Driver";
	static String url ="jdbc:mysql://localhost:3306/scott";
	static String user = "user01";
	static String password = "1234";
	
	private BitMysql() {}
	
	public static Connection getConnection() throws ClassNotFoundException, SQLException {
		if(conn == null || conn.isClosed()) {
			Class.forName(diver);
			conn = DriverManager.getConnection(url, user, password);
		}
		
		return conn;
	}
}
