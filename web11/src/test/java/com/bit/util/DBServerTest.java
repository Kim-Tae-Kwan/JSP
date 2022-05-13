package com.bit.util;

import static org.junit.Assert.*;

import java.sql.SQLException;

import org.junit.Test;

public class DBServerTest {

	@Test
	public void test() throws SQLException {
		assertNotNull(DBServer.getConnection());
	}

}
