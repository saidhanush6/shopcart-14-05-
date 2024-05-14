package com.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.db.ConnectionClass;

@WebServlet("/fetchProductsByPrice")
public class FetchProductsByPrice extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int selectedCategory = Integer.parseInt(request.getParameter("category"));
		int selectedPrice = Integer.parseInt(request.getParameter("sortOrder"));

		String change = "";
		try {
			ConnectionClass ob = new ConnectionClass();
			Connection conn = ob.getconnectDb();
			Statement stmt;
			ResultSet rs;
			stmt = conn.createStatement();
			if (selectedCategory == 0) {
				if (selectedPrice == 0) {
					rs = stmt.executeQuery("SELECT * FROM dhanush_products order by prod_price asc");
				} else {
					rs = stmt.executeQuery("SELECT * FROM dhanush_products order by prod_price desc");
				}
			} else {
				if (selectedPrice == 0) {
					rs = stmt.executeQuery("SELECT * FROM dhanush_products WHERE prod_prct_id = " + selectedCategory
							+ " order by prod_price asc");
				} else {
					rs = stmt.executeQuery("SELECT * FROM dhanush_products WHERE prod_prct_id = " + selectedCategory
							+ " order by prod_price desc");
				}
			}
			while (rs.next()) {
				change += "<div class='product'>";
				change += "<img src='" + rs.getString("prod_image") + "' alt='" + rs.getString("prod_title") + "'>";
				change += "<div class='product-details'>";
				change += "<h3>" + rs.getString("prod_title") + "</h3>";
				change += "<p>" + rs.getDouble("prod_price") + "</p>";
				change += "<button>Add to Cart</button>";
				change += "</div>";
				change += "</div>";
			}
			rs.close();
			stmt.close();
			conn.close();
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.println(change);
	}

}
