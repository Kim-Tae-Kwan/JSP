package com.bit.module01.mysql;

import static org.junit.Assert.*;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;

import org.apache.log4j.Logger;
import org.junit.Test;

public class BitEmpTest {
	Logger log = Logger.getLogger(this.getClass());
	
	@Test
	public void test() throws ClassNotFoundException, SQLException {
		BitEmp emp = new BitEmp();
		ArrayList<EmpBean> list = emp.getList();
		for(EmpBean item : list) log.debug(item);
		HashSet<EmpBean> set = new HashSet<EmpBean>(list);
		for(EmpBean item : set) log.debug(item);
		assertNotNull(list);
		assertTrue(list.size() > 0);
	}
}