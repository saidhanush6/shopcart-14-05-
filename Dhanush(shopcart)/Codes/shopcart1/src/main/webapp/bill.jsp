<!DOCTYPE html>
<%@ page import="java.util.List" %>
<%@ page import="com.models.Product" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bill</title>
    <link href="//netdna.bootstrapcdn.com/bootstrap/3.1.0/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
            background-color: #f8f9fa;
            color: #333;
        }
        .container {
            max-width: 800px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 40px;
            margin: 40px auto;
        }
        .invoice-title {
            margin-bottom: 30px;
        }
        .invoice-title h2 {
            font-size: 36px;
            color: #007bff;
        }
        .invoice-title h3 {
            font-size: 24px;
            color: #6c757d;
        }
        .billed-to {
            margin-top: 20px;
            font-size: 16px;
            line-height: 1.5;
        }
        .order-summary {
            margin-top: 40px;
        }
        .order-summary h3 {
            font-size: 22px;
            margin-bottom: 20px;
            color: #343a40;
        }
        
        .table-bordered {
            border: 1px solid #dee2e6;
        }
        .table-bordered th,
        .table-bordered td {
            border: 1px solid #dee2e6;
            padding: 8px; /* Adjust padding as needed */
            text-align: center; /* Center align text by default */
        }
        .table-bordered th {
            background-color: #007bff;
            color: #fff;
        }
        .table-bordered tbody tr:nth-child(even) {
            background-color: #f2f2f2; /* Alternate row color */
        }
        .table-bordered tbody tr:hover {
            background-color: #ddd; /* Hover row color */
        }
        .text-right {
            text-align: right; /* Align text to the right */
        }
        /* Align price column to the right */
        .price-column {
            text-align: right; /* Align text to the right */
        } 
        .btn-print {
            margin-top: 30px;
        }
        @media print {
            body * {
                visibility: hidden;
            }
            .container, .container * {
                visibility: visible;
            }
            .container {
                position: absolute;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                margin: 0;
                padding: 0;
            }
        }
    </style>
</head>
<body>
<%!
    // Define the generateOrderID() method here
    String generateOrderID() {
        return "ORD" + (int) (Math.random() * 1000);
    }
%>
<div class="container">
    <div class="row">
        <div class="col-xs-6">
            <h2 class="invoice-title">Shopping Bill</h2>
        </div>
        <div class="col-xs-6">
           <h3 class="pull-right">ORDER ID: <%= generateOrderID() %></h3>
        </div>
    </div>
    <hr/>
    <div class="row">
        <div class="col-xs-6">
            <address class="billed-to">
                <strong>Billed To:</strong><br>
                <%= "Dhanush" %><br>
                Pennant Technology Pvt Ltd<br>
                Hill No. 2<br>
                Vizag, Madhurawada
            </address>
        </div>
    </div>
    <div class="row order-summary">
        <div class="col-xs-12">
            <h3>Order Summary</h3>
            <div class="table-responsive">
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Item</th>
                            <th>ID</th>
                            <th>Quantity</th>
                            <th class="text-right">Price</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            List<Product> cartItems = (List<Product>) session.getAttribute("cartItems");
                            
                            Double totalPrice = (Double) session.getAttribute("totalPrice");
                            if (totalPrice == null) totalPrice = 0.0;
                            
                            Double shippingCharges = (Double) session.getAttribute("shippingCharges");
                            if (shippingCharges == null) shippingCharges = 0.0;
                            
                            Double shippingTax = (Double) session.getAttribute("shippingTax");
                            if (shippingTax == null) shippingTax = 0.0;
                            
                 
                            String couponDiscount = request.getParameter("couponDiscount");
                            // Check if the coupon discount value is null or empty, and set it to "0" if so
                            if (couponDiscount == null || couponDiscount.isEmpty()) {
                                couponDiscount = "0";
                            }
                            
                            // Parse the coupon discount value to Double if needed
                            Double couponDiscountAmount = Double.parseDouble(couponDiscount);

                            
                            
                            String totalAmountAfterCoupon = request.getParameter("totalAmountAfterCoupon");
                            // Check if the total amount after coupon applied value is null or empty, and set it to "0" if so
                            if (totalAmountAfterCoupon == null || totalAmountAfterCoupon.isEmpty()) {
                                totalAmountAfterCoupon = "0";
                            }
                            
                            // Parse the total amount after coupon applied value to Double if needed
                            Double totalAmountAfterCouponValue = Double.parseDouble(totalAmountAfterCoupon);
                            
                            

                            for (Product p : cartItems) {
                        %>
                        <tr>
                            <td><%= p.getProd_title() %></td>
                            <td><%= p.getProd_id() %></td>
                            <td><%= 1 %></td>
                            <!-- Add the class to align price column to the right -->
                            <td class="price-column">$<%= p.getProd_price() %></td>
                        </tr>
                        <% } %>
                        <tr>
                            <td colspan="3" class="text-right"><strong>Subtotal(With GST):</strong></td>
                            <td>$<%= totalPrice %></td>
                        </tr>
                        <tr>
                            <td colspan="3" class="text-right"><strong>Shipping and Handling:</strong></td>
                            <td>$<%= shippingCharges %></td>
                        </tr>
                        <tr>
                            <td colspan="3" class="text-right"><strong>Tax:</strong></td>
                            <td>$<%= shippingTax %></td>
                        </tr>
                        <tr>
                            <td colspan="3" class="text-right"><strong>Coupon Applied:</strong></td>
                            <td>$<%= couponDiscountAmount %></td>
                        </tr>
                        <tr>
                            <td colspan="3" class="text-right"><strong>Total:</strong></td>
                            <td>$<%= totalAmountAfterCouponValue %></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <button class="btn btn-primary btn-print" onclick="print()">PRINT BILL</button>
</div>
</body>
</html>
