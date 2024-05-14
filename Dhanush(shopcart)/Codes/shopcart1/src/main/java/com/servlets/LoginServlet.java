package com.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.db.ConnectionClass;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		PrintWriter out = response.getWriter();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			// Get connection from connection pool
			ConnectionClass cc = new ConnectionClass();
			conn = cc.getconnectDb();

			String qry = "SELECT password FROM dhanush_customers WHERE username=?";
			ps = conn.prepareStatement(qry);
			ps.setString(1, username);
			rs = ps.executeQuery();

			if (rs.next()) {
				String actualPassword = rs.getString("password");
				if (password.equals(actualPassword)) {

					RequestDispatcher rd = request.getRequestDispatcher("/HomeServlet");
					rd.forward(request, response);
					return;
				}
			}

			response.setContentType("text/html");
			out.println("Invalid username or password!!");
			RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
			rd.include(request, response);

		} catch (SQLException e) {
			e.printStackTrace();

		} catch (ClassNotFoundException e) {

			e.printStackTrace();
		} finally {

			try {
				if (rs != null) {
					rs.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				if (ps != null) {
					ps.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			out.close();
		}
	}
}
