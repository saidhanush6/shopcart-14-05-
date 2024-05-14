<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.models.Product" %>
<%@ page import="com.db.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- Google Fonts -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Josefin Sans">
    <style>
        body {
            font-family: "Josefin Sans", sans-serif;
            background-image:url("sc2.jpg");
            background-repeat:no-repeat;
            background-position: center;
            background-size: cover;
            background-attachment: fixed;
            color: #fff;
        }

        .container {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background-color: #445566;
            border-radius: 10px;
        }

        .btn {
            font-family: "Josefin Sans", sans-serif;
            font-weight: bold;
        }

        .quantity-btn {
            padding: 5px 10px;
            font-size: 16px;
            margin: 0 5px;
            background-color: #a0ced9;
            border: none;
            color: #132334;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.25s;
        }

        .quantity-btn:hover {
            background-color: #132334;
            color: #fff;
        }

        .cart-table {
            width: 100%;
            background-color: #132334;
            color: #fff;
            border-radius: 10px;
        }

        .cart-table th, .cart-table td {
            padding: 10px;
        }

        .cart-table th {
            background-color: #17a2b8;
        }

        .cart-table td {
            border-bottom: 1px solid #445566;
        }

        .btn-continue {
            background-color: #a0ced9;
            color: #132334;
            border: none;
            border-radius: 15px;
            padding: 10px 20px;
            margin-right: 10px;
            transition: background-color 0.25s;
        }

        .btn-continue:hover {
            background-color: #132334;
            color: #fff;
        }

        .btn-checkout {
            background-color: #17a2b8;
            color: #fff;
            border: none;
            border-radius: 15px;
            padding: 10px 20px;
            transition: background-color 0.25s;
        }

        .btn-checkout:hover {
            background-color: #117a8b;
        }
    </style>
</head>
<body>
<div class="container">
    <span class="sp">
        <a href="login.jsp"><img src="https://t4.ftcdn.net/jpg/06/35/99/51/240_F_635995107_mO50hAwcsbKUHoXvla2yDio2lf84KbDM.jpg" alt="shopcart" border="0" width="150px" height="120px"></a>
        <a href="login.jsp"><h1>ShopCart</h1></a>
    </span>
    <h2 class="mt-4 mb-3">Shopping Cart</h2>
    <table class="cart-table">
        <thead>
        <tr>
            <th>Product ID</th>
            <th>Name</th>
            <th>Price (with GST)</th>
            <th>Quantity</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <% 
            List<Product> cartItems = (List<Product>) request.getAttribute("cartItems");
        request.getSession().setAttribute("cart2", cartItems);
            double totalPrice = 0.0;
            if (cartItems != null) {
                // Connection to the database
                try {
                	ConnectionClass cc=new ConnectionClass();
                    Connection con = cc.getconnectDb();
                    PreparedStatement ps = con.prepareStatement("SELECT hsnc_id, hsnc_gstc_percentage FROM HSNCodes");
                    ResultSet rs = ps.executeQuery();
                    
                    HashMap<Integer, Integer> hsnIdMap = new HashMap<>();
                    while (rs.next()) {
                        hsnIdMap.put(rs.getInt("hsnc_id"), rs.getInt("hsnc_gstc_percentage"));
                    }
                    
                    for (Product item : cartItems) {
                        int hsnId = item.getProd_hsnc_id();
                        
                        int gstPercentage = hsnIdMap.containsKey(hsnId) ? hsnIdMap.get(hsnId) : 0;
                        double gstAmount = item.getProd_price() * gstPercentage / 100.0;
                        double itemPrice = item.getProd_price() + gstAmount;
                        totalPrice += itemPrice;
                        
        %>
        <tr>
            <td><%= item.getProd_id() %></td>
            <td><%= item.getProd_title() %></td>
            <td><%= itemPrice %></td>
            <td>
                <button type="button" class="quantity-btn" onclick="decreaseQuantity(this)">-</button>
                <span class="quantity">1</span>
                <button type="button" class="quantity-btn" onclick="increaseQuantity(this)">+</button>
            </td>
            <td><button type="button" class="btn btn-danger" onclick="removeItem('<%= item.getProd_id() %>')">Remove</button></td>
        </tr>
        <% 
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                
            }
        %>
        </tbody>
    </table>
    <br>
    <br>
    <h4>Total Price (with GST): <%= totalPrice %></h4>
    <br>
    <a href="#" class="btn btn-continue" onclick="goback()">Continue Shopping</a>
    <a href="checkout.jsp?totalPrice=<%= totalPrice %>" class="btn btn-checkout">Checkout</a>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
    function goback(){
        window.location.href="LoginServlet#";
    }

    function checkout() {
        window.location.href = "checkout.jsp"; 
    }

    function removeItem(productId) {
        fetch('CartController?productId=' + productId, {
            method: 'DELETE'
        })
        .then(response => {
            if (response.ok) {
                window.location.reload();
            } else {
                console.error('Failed to remove item from cart');
            }
        })
        .catch(error => {
            console.error('Error removing item from cart:', error);
        });
    }

    function decreaseQuantity(button) {
        var quantitySpan = button.nextElementSibling;
        var currentQuantity = parseInt(quantitySpan.textContent);
        if (currentQuantity > 1) {
            quantitySpan.textContent = currentQuantity - 1;
        }
    }

    function increaseQuantity(button) {
        var quantitySpan = button.previousElementSibling;
        var currentQuantity = parseInt(quantitySpan.textContent);
        quantitySpan.textContent = currentQuantity + 1;
    }
</script>
</body>
</html>
