package com.bit.util;

import static org.junit.Assert.*;

import java.sql.Connection;
import java.sql.SQLException;

import org.junit.Test;

public class MysqlTest {

	@Test
	public void testGetConnection() throws Exception {
		Connection conn = Mysql.getConnection();
		
		// conn
		assertNotNull(conn);
		
		// close
		assertFalse(conn.isClosed());
		
		// singleton
		assertEquals(conn, Mysql.getConnection());
		
		// close
		conn.close();
		assertNotNull(Mysql.getConnection());
		assertFalse(Mysql.getConnection().isClosed());
		assertNotEquals(conn, Mysql.getConnection());
		
		Mysql.getConnection().close();
	}
}
