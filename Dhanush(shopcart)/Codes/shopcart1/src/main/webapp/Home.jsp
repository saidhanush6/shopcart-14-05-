<%@ page language="java" import="java.util.List, com.models.Product" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Page</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- Google Fonts -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Josefin Sans">
    <style>
    
    .pagination-buttons {
    text-align: center;
}

.pagination-buttons button {
    margin: 0 5px;
}
    
    
    
        body {
            font-family: "Josefin Sans", sans-serif;
            background-image:url("sc2.jpg");
background-repeat:no-repeat;
 background-position: center;
 background-size: cover;
 background-attachment: fixed;
        }

        header {
            background-color: #232f3e;
            color: #fff;
            padding: 20px;
        }

        header a {
            color: #fff;
            text-decoration: none;
            margin-right: 20px;
            font-weight: bold;
        }
#logreg{
padding-left:1070px;
}
        .container {
            margin-top: 20px;
        }

        .sort-options {
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px;
            background-color: #a0ced9;
            border-radius: 10px;
        }

        select {
            width: 200px;
            padding: 10px;
            border-radius: 12px;
            border: 1px solid #132334;
            box-sizing: border-box;
            font-size: 15px;
            font-family: "Josefin Sans", sans-serif;
            margin-right: 20px;
        }

        .product-list {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            grid-gap: 20px;
            padding: 20px;
        }

        .product {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            text-align: center;
            padding: 20px;
        }

        .product img {
            max-width: 100%;
            height: 200px;
            border-bottom: 1px solid #eee;
        }

        .product-details {
            padding: 20px;
        }

        .product h3 {
            margin-top: 0;
            font-size: 18px;
            margin-bottom: 10px;
        }

        .product p {
            margin-bottom: 0;
            color: #777;
            font-size: 16px;
        }

        .product button {
            display: block;
            width: 100%;
            padding: 10px;
            background-color: #17a2b8;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            font-family: "Josefin Sans", sans-serif;
            font-weight: bold;
            color: #fff;
            transition: background-color 0.25s;
        }

        .product button:hover {
            background-color: #117a8b;
        }
    </style>
</head>
<body>
<header>
    <a href="login.jsp">ShopCart</a>
    <div id="logreg">
        <a href="#" class="btn btn-light">Login</a>
        <a href="#" class="btn btn-light">Register</a>
        <a href="#" class="btn btn-light" onclick="viewCart()">Cart</a>
    </div>
</header>
<div class="container">
    <div class="sort-options">
        <div>
            <label for="category">Filter by Category:</label>
            <select id="category" class="form-control">
                <option value="0" selected hidden>All Categories</option>
                <option value="1">Shoes</option>
                <option value="2">Watches</option>
                <option value="3">Perfumes</option>
                
            </select>
        </div>
        <div>
            <label for="price">Sort by Price:</label>
            <select name="price" id="pricee" class="form-control">
                <option selected hidden disabled>--sort---</option>
                <option value="0">Low to High</option>
                <option value="1">High to Low</option>
            </select>
        </div>
    </div>

    <div class="product-list">
    <% List<Product> products = (List<Product>) request.getAttribute("products");
    for (Product p : products) { %>
    <div class="product">
        <img src="<%= p.getProd_image() %>" alt="<%= p.getProd_title() %>">
        <div class="product-details">
            <h3><%= p.getProd_title() %></h3>
            <p>$<%= p.getProd_price() %></p>
            <br>
<button class="add-to-cart-btn" onclick="addItemToCart('<%= p.getProd_id() %>', '<%= p.getProd_title() %>', '<%= p.getProd_price() %>','<%= p.getProd_hsnc_id() %>')">Add to Cart</button>

        </div>
    </div>
    <% } %>
</div>

</div>


<div class="pagination-buttons mt-4">
        <button id="prevPageBtn" class="btn btn-light mr-2" disabled>Previous</button>
        <button id="nextPageBtn" class="btn btn-light">Next</button>
    </div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
    $(document).ready(function() {
        // Event listener for category selection
        $("#category").change(function() {
            // Get the selected category value
            var selectedCategory = $(this).val();
     
            // Make AJAX request to fetch products based on selected category
            $.ajax({
                type: "GET",
                url: "fetchProductsByCategory",
                data: { category: selectedCategory },
                success: function(response) {
                    // Update the products container with the fetched products
                	 $(".product-list").html(response);
                },
                error: function(xhr, status, error) {
                    console.error('Error:', status, error);
                }
            });
        });
        
     // Event listener for price selection
        $('#pricee').change(function(){
			var selectedPriceOrder_val=$(this).val();
			var selectedCategory = $("#category").val();
			console.log(typeof(selectedCategory));
			console.log(typeof(selectedPriceOrder_val));
			
				$.ajax({
	                type: "GET",
	                url: "fetchProductsByPrice",
	                data: { sortOrder: selectedPriceOrder_val, 
							category:selectedCategory	
	                },
	                success: function(response) {
	                    // Update the products container with the fetched products
	                    $(".product-list").html(response);
	                },
	                error: function(xhr, status, error) {
	                    console.error('Error:', status, error);
	                }
	            });
			
        });
    });
    
    function addItemToCart(id, name, price,hsncid) {
        var pincode = prompt("Enter your pin code:");
        if (pincode === null || pincode === "") {
            alert("Please enter a valid pin code.");
            return;
        }

        // Perform AJAX request to check pin code serviceability
        $.ajax({
            type: "GET",
            url: "checkPinCodeServiceability",
            data: { productId: id, pincode: pincode },
            success: function(response) {
                if (response === "true") {
                    // Item is serviceable, proceed to add to cart
                    var data = {
                        productId: id,
                        productName: name,
                        productPrice: price,
                        hsncid:hsncid
                    };
                    $.ajax({
                        type: "POST",
                        url: "CartController",
                        data: data,
                        success: function(response) {
                            console.log("Item added to cart");
                            alert("Item added to cart");
                        },
                        error: function(xhr, status, error) {
                            console.error("Error adding item to cart:", error);
                            alert("Error adding item to cart");
                        }
                    });
                } else {
                    // Item is not serviceable, display error message
                    alert("This item is not serviceable to the provided pin code.");
                }
            },
            error: function(xhr, status, error) {
                console.error("Error checking pin code serviceability:", error);
                alert("Error checking pin code serviceability");
            }
        });
    }

    
    
    function viewCart() {
        window.location.href = "CartController";
    }
    
    
    $(document).ready(function() {
        var currentPage = 1; // Initialize current page
        var pageSize = 4; // Number of products per page

        // Function to fetch products for a specific page
        function fetchProducts(page) {
            $.ajax({
                type: "GET",
                url: "fetchProductsByPage",
                data: { page: page, pageSize: pageSize },
                success: function(response) {
                    $(".product-list").html(response);
                    currentPage = page; // Update current page
                    updatePaginationButtons(); // Update pagination buttons
                },
                error: function(xhr, status, error) {
                    console.error('Error:', status, error);
                }
            });
        }

        // Event listener for previous page button
        $("#prevPageBtn").click(function() {
            if (currentPage > 1) {
                fetchProducts(currentPage - 1); // Fetch previous page
            }
        });

        // Event listener for next page button
        $("#nextPageBtn").click(function() {
            fetchProducts(currentPage + 1); // Fetch next page
        });

        // Update pagination buttons based on current page
        function updatePaginationButtons() {
            if (currentPage <= 1) {
                $("#prevPageBtn").prop("disabled", true); // Disable previous button for first page
            } else {
                $("#prevPageBtn").prop("disabled", false); // Enable previous button
            }
        }

        // Fetch products for the initial page
        fetchProducts(currentPage);
    });
</script>
</body>
</html>
