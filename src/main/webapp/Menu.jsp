  <!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>Yummy Bootstrap Template - Index</title>
  <meta content="" name="description">
  <meta content="" name="keywords">

  <!-- Favicons -->
  <link href="assets/img/favicon.png" rel="icon">
  <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Google Fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,600;1,700&family=Amatic+SC:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&family=Inter:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="assets/vendor/aos/aos.css" rel="stylesheet">
  <link href="assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
  <link href="assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">

  <!-- Template Main CSS File -->
  <link href="assets/css/main.css" rel="stylesheet">

  <!-- =======================================================
  * Template Name: Yummy
  * Updated: Sep 18 2023 with Bootstrap v5.3.2
  * Template URL: https://bootstrapmade.com/yummy-bootstrap-restaurant-website-template/
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
</head>

<body>

  <!-- ======= Header ======= -->
  <header id="header" class="header fixed-top d-flex align-items-center">
    <div class="container d-flex align-items-center justify-content-between">

      <a href="index.html" class="logo d-flex align-items-center me-auto me-lg-0">
        <!-- Uncomment the line below if you also wish to use an image logo -->
        <!-- <img src="assets/img/logo.png" alt=""> -->
        <h1>Yummy<span>.</span></h1>
      </a>

      <nav id="navbar" class="navbar">
        <ul>
          <li><a class="nav-link" href="Home.jsp">Home</a></li>
          <li><a class="nav-link" href="Menu.jsp">Menu</a></li>
        </ul>
      </nav><!-- .navbar -->
      
           <a class="btn-book-a-table" href="#book-a-table">Book a Table</a>
      <i class="mobile-nav-toggle mobile-nav-show bi bi-list"></i>
      <i class="mobile-nav-toggle mobile-nav-hide d-none bi bi-x"></i>

    </div>
  </header><!-- End Header -->
  
  <!-- ======= Menu Section ======= -->
    <section id="menu" class="menu">
      <div class="container" data-aos="fade-up">

        <div class="section-header">
          <h2>Our Menu</h2>
          <p>Check Our <span>Yummy Menu</span></p>
        </div>

        <ul class="nav nav-tabs d-flex justify-content-center" data-aos="fade-up" data-aos-delay="200">

          <li class="nav-item">
            <a class="nav-link active show" data-bs-toggle="tab" data-bs-target="#menu-starters">
              <h4>Classic Pizzas</h4>
            </a>
          </li><!-- End tab nav item -->

          <li class="nav-item">
            <a class="nav-link" data-bs-toggle="tab" data-bs-target="#menu-breakfast">
              <h4>Meat Lovers' Pizzas</h4>
            </a><!-- End tab nav item -->

          <li class="nav-item">
            <a class="nav-link" data-bs-toggle="tab" data-bs-target="#menu-lunch">
              <h4>Vegetarian Pizzas</h4>
            </a>
          </li><!-- End tab nav item -->

          <li class="nav-item">
            <a class="nav-link" data-bs-toggle="tab" data-bs-target="#menu-dinner">
              <h4>Gourmet Pizzas</h4>
            </a>
          </li><!-- End tab nav item -->

        </ul>

        <div class="tab-content" data-aos="fade-up" data-aos-delay="300">

          <div class="tab-pane fade active show" id="menu-starters">

            <div class="tab-header text-center">
              <p>Menu</p>
              <h3>Classic Pizzas</h3>
            </div>

            <div class="row gy-5">

              <div class="col-lg-4 menu-item">
                <a href="assets/img/menu/menu-item-1.png" class="glightbox"><img src="menu/img/margherita.jpg" class="menu-img img-fluid" alt=""></a>
                <h4>Margherita</h4>
                <p class="ingredients">
                  Tomato sauce, fresh mozzarella, basil
                </p>
                <p class="price">
                 9 DT
                </p>
              </div><!-- Menu Item -->

              <div class="col-lg-4 menu-item">
                <a href="assets/img/menu/menu-item-2.png" class="glightbox"><img src="menu/img/pepperoni.jpg" class="menu-img img-fluid" alt=""></a>
                <h4>Pepperoni</h4>
                <p class="ingredients">
                  Tomato sauce, mozzarella, lots of pepperoni
                </p>
                <p class="price">
                  11 DT
                </p>
              </div><!-- Menu Item -->

              <div class="col-lg-4 menu-item">
                <a href="assets/img/menu/menu-item-3.png" class="glightbox"><img src="menu/img/Cheese.jpg" class="menu-img img-fluid" alt=""></a>
                <h4>Cheese</h4>
                <p class="ingredients">
                 A blend of mozzarella, cheddar, and parmesan cheeses on a tomato base
                </p>
                <p class="price">
                 14 DT
                </p>
              </div><!-- Menu Item -->


            </div>
          </div><!-- End Starter Menu Content -->

          <div class="tab-pane fade active show" id="menu-breakfast">

            <div class="tab-header text-center">
              <p>Menu</p>
              <h3>Meat Lovers' Pizzas</h3>
            </div>

            <div class="row gy-5">

              <div class="col-lg-4 menu-item">
                <a href="assets/img/menu/menu-item-1.png" class="glightbox"><img src="menu/img/BBQChicken.jpg" class="menu-img img-fluid" alt=""></a>
                <h4>BBQ Chicken</h4>
                <p class="ingredients">
                  BBQ sauce, grilled chicken, red onions, cilantro, mozzarella, smoked gouda
                </p>
                <p class="price">
                  11 DT
                </p>
              </div><!-- Menu Item -->

              <div class="col-lg-4 menu-item">
                <a href="assets/img/menu/menu-item-2.png" class="glightbox"><img src="menu/img/MeatFeast.jpg" class="menu-img img-fluid" alt=""></a>
                <h4>Meat Feast</h4>
                <p class="ingredients">
                  Pepperoni, ham, bacon, sausage, mozzarella on a tomato base
                </p>
                <p class="price">
                  17 DT
                </p>
              </div><!-- Menu Item -->

              <div class="col-lg-4 menu-item">
                <a href="assets/img/menu/menu-item-3.png" class="glightbox"><img src="menu/img/SpicyItalian.jpg" class="menu-img img-fluid" alt=""></a>
                <h4>Spicy Italian</h4>
                <p class="ingredients">
                  Spicy Italian sausage, jalapeños, red onions, tomato sauce, mozzarella
                </p>
                <p class="price">
                  14 DT
                </p>
              </div><!-- Menu Item -->

        </div><!-- End Breakfast Menu Content -->
        </div>

          <div class="tab-pane fade" id="menu-lunch">

            <div class="tab-header text-center">
              <p>Menu</p>
              <h3>Vegetarian Pizzas</h3>
            </div>

            <div class="row gy-5">

              <div class="col-lg-4 menu-item">
                <a href="assets/img/menu/menu-item-1.png" class="glightbox"><img src="menu/img/VegetarianDelight.jpg" class="menu-img img-fluid" alt=""></a>
                <h4>Vegetarian Delight</h4>
                <p class="ingredients">
                 Mushrooms, bell peppers, onions, black olives, tomatoes, mozzarella
                </p>
                <p class="price">
                  11 DT
                </p>
              </div><!-- Menu Item -->

              <div class="col-lg-4 menu-item">
                <a href="assets/img/menu/menu-item-2.png" class="glightbox"><img src="menu/img/SpinachFeta.jpg" class="menu-img img-fluid" alt=""></a>
                <h4>Spinach & Feta</h4>
                <p class="ingredients">
                  Creamy garlic sauce, spinach, feta, onions, mozzarella
                </p>
                <p class="price">
                 9 DT
                </p>
              </div><!-- Menu Item -->

              <div class="col-lg-4 menu-item">
                <a href="assets/img/menu/menu-item-3.png" class="glightbox"><img src="menu/img/Caprese.jpg" class="menu-img img-fluid" alt=""></a>
                <h4>Caprese</h4>
                <p class="ingredients">
                  Tomato slices, fresh mozzarella, basil, balsamic glaze
                </p>
                <p class="price">
                  14 DT
                </p>
              </div><!-- Menu Item -->


            </div>
          </div><!-- End Lunch Menu Content -->

          <div class="tab-pane fade" id="menu-dinner">

            <div class="tab-header text-center">
              <p>Menu</p>
              <h3>Gourmet Pizzas</h3>
            </div>

            <div class="row gy-5">

              <div class="col-lg-4 menu-item">
                <a href="assets/img/menu/menu-item-1.png" class="glightbox"><img src="menu/img/TruffleOilMushroom.jpg" class="menu-img img-fluid" alt=""></a>
                <h4>Truffle Oil & Mushroom</h4>
                <p class="ingredients">
                 Creamy white sauce, wild mushrooms, truffle oil, mozzarella, thyme
                </p>
                <p class="price">
                  6 DT
                </p>
              </div><!-- Menu Item -->

              <div class="col-lg-4 menu-item">
                <a href="assets/img/menu/menu-item-2.png" class="glightbox"><img src="menu/img/ProsciuttoandArugula.jpg" class="menu-img img-fluid" alt=""></a>
                <h4>Prosciutto and Arugula</h4>
                <p class="ingredients">
                  Thinly sliced prosciutto, arugula, parmesan, white sauce
                </p>
                <p class="price">
                  11 DT
                </p>
              </div><!-- Menu Item -->

              <div class="col-lg-4 menu-item">
                <a href="assets/img/menu/menu-item-3.png" class="glightbox"><img src="menu/img/BuffaloChicken.jpg" class="menu-img img-fluid" alt=""></a>
                <h4>Buffalo Chicken</h4>
                <p class="ingredients">
                  Spicy buffalo sauce, chicken, celery bits, blue cheese, mozzarella
                </p>
                <p class="price">
                  14 DT
                </p>
              </div><!-- Menu Item -->

            </div>
          </div><!-- End Dinner Menu Content -->

        </div>

      </div>
    </section><!-- End Menu Section -->
    
 
    
  <!-- ======= Footer ======= -->
  <footer id="footer" class="footer">

    <div class="container">
      <div class="row gy-3">
        <div class="col-lg-3 col-md-6 d-flex">
          <i class="bi bi-geo-alt icon"></i>
          <div>
            <h4>Address</h4>
            <p>
              Sfax <br>
              Route Tanyour KM 9<br>
            </p>
          </div>

        </div>

        <div class="col-lg-3 col-md-6 footer-links d-flex">
          <i class="bi bi-telephone icon"></i>
          <div>
            <h4>Reservations</h4>
            <p>
              <strong>Phone:</strong> +216 70 748 223<br>
              <strong>Email:</strong> info@example.com<br>
            </p>
          </div>
        </div>

        <div class="col-lg-3 col-md-6 footer-links d-flex">
          <i class="bi bi-clock icon"></i>
          <div>
            <h4>Opening Hours</h4>
            <p>
              <strong>Mon-Sat: 11AM</strong> - 23PM<br>
              Sunday: Closed
            </p>
          </div>
        </div>

        <div class="col-lg-3 col-md-6 footer-links">
          <h4>Follow Us</h4>
          <div class="social-links d-flex">
            <a href="#" class="twitter"><i class="bi bi-twitter"></i></a>
            <a href="#" class="facebook"><i class="bi bi-facebook"></i></a>
            <a href="#" class="instagram"><i class="bi bi-instagram"></i></a>
            <a href="#" class="linkedin"><i class="bi bi-linkedin"></i></a>
          </div>
        </div>

      </div>
    </div>

    <div class="container">
      <div class="copyright">
        &copy; Copyright <strong><span>Yummy</span></strong>. All Rights Reserved
      </div>


  </footer><!-- End Footer -->
  <!-- End Footer -->
  
  
  
  <div id="preloader"></div>

  <!-- Vendor JS Files -->
  <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="assets/vendor/aos/aos.js"></script>
  <script src="assets/vendor/glightbox/js/glightbox.min.js"></script>
  <script src="assets/vendor/purecounter/purecounter_vanilla.js"></script>
  <script src="assets/vendor/swiper/swiper-bundle.min.js"></script>
  <script src="assets/vendor/php-email-form/validate.js"></script>

  <!-- Template Main JS File -->
  <script src="assets/js/main.js"></script>
  
     </body>
    </html>