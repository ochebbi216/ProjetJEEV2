<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Admin Login </title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        
        <!-- MATERIAL DESIGN ICONIC FONT -->
        <link rel="stylesheet" href="adminlogin/fonts/material-design-iconic-font/css/material-design-iconic-font.min.css">

        <!-- STYLE CSS -->
        <link rel="stylesheet" href="adminlogin/css/style.css">
    </head>

    <body>

        <div class="wrapper" style="background-image: url('adminlogin/images/fond.jpg');">
            <div class="inner">
                <div class="image-holder">
                    <img src="adminlogin/images/adminregister.jpg" alt="">
                </div>
                <form action="admin?action=login" method="post">

                    <h3>Login Form</h3>

                    <div class="form-wrapper">
                        <input type="text" placeholder="Email Address" class="form-control" name="email">
                        <i class="zmdi zmdi-email"></i>
                    </div>
                    <div class="form-wrapper">
                        <input type="password" placeholder="Password" class="form-control" name ="motDePasse">
                        <i class="zmdi zmdi-lock"></i>
                    </div>

                    <button type="submit" name="login"> Login  <i class="zmdi zmdi-arrow-right"></i>
                    </button>
                </form>
            </div>
        </div>
        
    </body><!-- This templates was made by Colorlib (https://colorlib.com) -->
</html>