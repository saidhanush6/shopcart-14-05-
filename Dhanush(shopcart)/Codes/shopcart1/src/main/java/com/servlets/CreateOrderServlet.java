package com.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.razorpay.Order;
import com.razorpay.RazorpayClient;

@WebServlet("/createOrderServlet")
public class CreateOrderServlet extends HttpServlet {

	public void doPost(HttpServletRequest request, HttpServletResponse response) {
		try {
			// Fetch the amount, name, and email from the request
			String amount = request.getParameter("amount");
			String name = request.getParameter("name");
			String email = request.getParameter("email");

			// Your Razorpay API key and secret
			String razorpayKey = "rzp_test_Ts5HUtPqq4vrdx";
			String razorpaySecret = "Sf6tmFGTHO3ZDxgKkIRCxIs2";

			// Create an instance of Razorpay client
			RazorpayClient razorpayClient = new RazorpayClient(razorpayKey, razorpaySecret);

			// Create an order request
			JSONObject orderRequest = new JSONObject();
			orderRequest.put("amount", Integer.parseInt(amount) * 100); // Amount should be in paise
			orderRequest.put("currency", "INR");
			orderRequest.put("receipt", "order_receipt_" + System.currentTimeMillis());
			orderRequest.put("payment_capture", 1); // Auto capture

			// Create the order
			Order order = razorpayClient.orders.create(orderRequest);

			// Send the order details as JSON response
			JSONObject jsonResponse = new JSONObject();
			jsonResponse.put("id", String.valueOf(order.get("id"))); // Explicitly cast to String
			jsonResponse.put("amount", String.valueOf(order.get("amount"))); // Explicitly cast to String

			// Send the JSON response
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(jsonResponse.toString());
		} catch (Exception e) {
			// Handle exceptions
			e.printStackTrace();
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		}
	}
}