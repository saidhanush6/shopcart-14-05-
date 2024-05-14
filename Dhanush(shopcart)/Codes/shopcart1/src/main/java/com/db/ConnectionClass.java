package com.db;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class ConnectionClass {
	public Connection getconnectDb() throws ClassNotFoundException, SQLException {
		Properties p = new Properties();
		try {
			FileInputStream input = new FileInputStream(
					"D:\\Users\\rajju\\Downloads\\Dhanush_shopcart\\Dhanush_shopcart\\Codes\\shopcart1\\src\\main\\java\\com\\db\\Credentials.properties");
			p.load(input);
		} catch (IOException e) {
			e.printStackTrace();
		}
		String jdbcUrl = p.getProperty("jdbcUrl");
		String username = p.getProperty("username");
		String password = p.getProperty("password");
		Class.forName("org.postgresql.Driver");
		Connection conn = DriverManager.getConnection(jdbcUrl, username, password);
		return conn;
	}
}
