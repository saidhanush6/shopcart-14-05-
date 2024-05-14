package com.servlets;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.dal.ProductListDAL;
import com.models.Product;

@WebServlet("/fetchProductsByPage")
public class FetchProductsByPageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int page = Integer.parseInt(request.getParameter("page"));
		int pageSize = Integer.parseInt(request.getParameter("pageSize"));
		int offset = (page - 1) * pageSize;

		ProductListDAL pdal = new ProductListDAL();

		// Logic to fetch products for the specified page with pagination
		List<Product> products = pdal.getProductsByPage(page, pageSize, offset);

		// Convert products to HTML
		StringBuilder productsHtml = new StringBuilder();
		for (Product product : products) {
			productsHtml.append("<div class='product'>");
			productsHtml.append("<img src='" + product.getProd_image() + "' alt='Product Image'>");
			productsHtml.append("<div class='product-details'>");
			productsHtml.append("<h3>" + product.getProd_title() + "</h3>");
			productsHtml.append("<p>$" + product.getProd_price() + "</p>");
			productsHtml.append("<button class='add-to-cart-btn' onclick='addItemToCart(\"" + product.getProd_id() + "\", \"" + product.getProd_title() + "\", \"" + product.getProd_price() + "\", \"" + product.getProd_hsnc_id() + "\")'>Add to Cart</button>");

			productsHtml.append("</div></div>");
		}

		// Send products HTML as the response
		response.setContentType("text/html");
		response.getWriter().write(productsHtml.toString());
	}

}
