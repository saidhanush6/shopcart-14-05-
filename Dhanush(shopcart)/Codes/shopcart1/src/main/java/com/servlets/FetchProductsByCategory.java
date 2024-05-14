package com.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.db.ConnectionClass;

@WebServlet("/fetchProductsByCategory")
public class FetchProductsByCategory extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		int selectedCategory = Integer.parseInt(request.getParameter("category"));
		String change = "";
		try {
			ConnectionClass ob = new ConnectionClass();
			Connection conn = ob.getconnectDb();
			PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM dhanush_products WHERE prod_prct_id = ?");
			pstmt.setInt(1, selectedCategory);
			ResultSet rs = pstmt.executeQuery();
			

			while (rs.next()) {
				change += "<div class='product'>";
				change += "<img src='" + rs.getString("prod_image") + "' alt='" + rs.getString("prod_title") + "'>";
				change += "<div class='product-details'>";
				change += "<h3>" + rs.getString("prod_title") + "</h3>";
				change += "<p>" + rs.getInt("prod_price") + "</p>";
				change += "<button>Add to Cart</button>";
				change += "</div>";
				change += "</div>";
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.println(change);
	}

}
