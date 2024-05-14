<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Page</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<!-- Custom CSS -->
<link rel="stylesheet" href="style.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Josefin Sans">
<style>
body{
background-image:url("sc2.jpg");
background-repeat:no-repeat;
 background-position: center;
 background-size: cover;
 background-attachment: fixed;
}
</style>
'

<body >
    <div class="container">
        <div class="row justify-content-center align-items-center vh-100">
            <div class="col-md-6">
                <div class="text-center mb-4">
                    <a href="login.jsp"><img src="https://t4.ftcdn.net/jpg/06/35/99/51/240_F_635995107_mO50hAwcsbKUHoXvla2yDio2lf84KbDM.jpg" alt="shopcart" class="img-fluid" style="max-width: 150px;"></a>
                    <h1 class="font-weight-bold text-white">ShopCart</h1>
                </div>
                <div class="login-form bg-white p-4">
                    <h2 class="text-center mb-4">Login</h2>
                    <form action="LoginServlet" method="post">
                        <div class="form-group">
                            <label for="username" class="font-weight-bold">Username</label>
                            <input type="text" class="form-control" id="username" name="username">
                        </div>
                        <div class="form-group">
                            <label for="password" class="font-weight-bold">Password</label>
                            <input type="password" class="form-control" id="password" name="password">
                        </div>
                        <div class="form-group">
                            <a href="registration.jsp" class="font-weight-bold">Register here</a>
                        </div>
                        <div class="form-group">
                            <button type="submit" class="btn btn-primary btn-block">Login</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
