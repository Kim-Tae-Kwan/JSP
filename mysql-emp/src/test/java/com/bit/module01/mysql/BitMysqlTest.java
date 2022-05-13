package com.bit.module01.mysql;

import static org.junit.Assert.*;

import java.sql.Connection;
import java.sql.SQLException;

import org.junit.Test;

public class BitMysqlTest {

	@Test
	public void testGetConnection() throws ClassNotFoundException, SQLException {
		Connection conn = BitMysql.getConnection();
		assertNotNull("is null",conn);
		conn.close();
	}
}
