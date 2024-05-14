package com.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.models.Product;

@WebServlet("/CartController")
public class CartController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Extract product information from the request
		String productId = request.getParameter("productId");
		String productName = request.getParameter("productName");
		String productPrice = request.getParameter("productPrice");
		String hsncid = request.getParameter("hsncid");
		System.out.println(productId + "" + productName + "" + productPrice+""+hsncid);

		Product pro = new Product();
		pro.setProd_id(Integer.parseInt(productId));
		pro.setProd_title(productName);
		pro.setProd_price(Integer.parseInt(productPrice));
		pro.setProd_hsnc_id(Integer.parseInt(hsncid));

		// Retrieve the current cart items from session or create a new list
		List<Product> cartItems = getCartItemsFromSession(request);
		// Add the new product to the cart
		cartItems.add(pro);
		// Update the cart in session
		updateCartInSession(request, cartItems);
		// Redirect to index.jsp after adding to cart

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Display the cart contents
		List<Product> cartItems = getCartItemsFromSession(request);
		request.setAttribute("cartItems", cartItems);
		// Forward the request to the cart.jsp page
		request.getRequestDispatcher("cart.jsp").forward(request, response);

	}

	protected void doDelete(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Extract product ID to be removed from the request
		String productIdToRemove = request.getParameter("productId");
		if (productIdToRemove != null) {
			int productId = Integer.parseInt(productIdToRemove);
			// Retrieve the current cart items from session
			List<Product> cartItems = getCartItemsFromSession(request);
			// Remove the item with the specified ID from the cart
			cartItems.removeIf(item -> item.getProd_id() == productId);
			// Update the cart in session
			updateCartInSession(request, cartItems);
			// Respond with success status
			response.setStatus(HttpServletResponse.SC_OK);
		} else {
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
		}
	}

	private List<Product> getCartItemsFromSession(HttpServletRequest request) {
		// Retrieve cart items from session or create a new list if not present
		List<Product> cartItems = (List<Product>) request.getSession().getAttribute("cart");
		if (cartItems == null) {
			cartItems = new ArrayList<>();
			request.getSession().setAttribute("cart", cartItems);
		}
		return cartItems;
	}

	private void updateCartInSession(HttpServletRequest request, List<Product> cartItems) {
		// Update cart items in session
		request.getSession().setAttribute("cart", cartItems);
	}
}
