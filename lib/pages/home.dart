import 'package:flutter/material.dart';
import 'package:food_app/widget/widget_support.dart';
import 'package:food_app/pages/details.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool icecream = false, pizza = false, salad = false, burger = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 60, left: 25, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Hey, Abdul-Rasheed",
                  style: AppWidget.boldTextFieldStyle(),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(Icons.shopping_cart, color: Colors.white),
                ),
              ],
            ),

            const SizedBox(height: 30),
            Text("Delicious Food", style: AppWidget.HeadLineTextFieldStyle()),
            Text(
              "Discover & Get Great Food",
              style: AppWidget.LightTextFieldStyle(),
            ),
            const SizedBox(height: 20),

            // Category Items
            showItem(),
            const SizedBox(height: 30),

            // Horizontal Scroll Cards with navigation
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Details(
                            image: "images/rice.png",
                            name: "Delicious Rice",
                            slogan: "Meat/Chicken",
                            price: 20.0,
                          ),
                        ),
                      );
                    },
                    child: buildFoodCard(
                      image: "images/rice.png",
                      title: "Delicious Rice",
                      subtitle: "Meat/Chicken",
                      price: "\$20",
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Details(
                            image: "images/rice.png",
                            name: "Delicious Rice",
                            slogan: "Meat/Chicken",
                            price: 20,
                          ),
                        ),
                      );
                    },
                    child: buildFoodCard(
                      image: "images/Sausage.png",
                      title: "Tasty Sausage",
                      subtitle: "Cheese Sausage",
                      price: "\$17",
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Details(
                            image: "images/Sausage.png",
                            name: "Tasty Sausage",
                            slogan: "Cheese Sausage",
                            price: 17,
                          ),
                        ),
                      );
                    },
                    child: buildFoodCard(
                      image: "images/salad2.png",
                      title: "Fresh Salad",
                      subtitle: "Cheese Sausage",
                      price: "\$5",
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Example Recommended Section
            Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Image.asset(
                      "images/salad2.png",
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Medterrenain",
                          style: AppWidget.SemiboldTextFieldStyle(),
                        ),
                        Text(
                          "ChickPea Salad",
                          style: AppWidget.SemiboldTextFieldStyle(),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Fresh and Healthy",
                          style: AppWidget.LightTextFieldStyle(),
                        ),
                        const SizedBox(height: 5),
                        Text("\$15", style: AppWidget.SemiboldTextFieldStyle()),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Food Card Widget
  Widget buildFoodCard({
    required String image,
    required String title,
    required String subtitle,
    required String price,
  }) {
    return Container(
      width: 200,
      margin: const EdgeInsets.all(4),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipOval(
                child: Image.asset(
                  image,
                  width: 170,
                  height: 170,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),
              Text(title, style: AppWidget.SemiboldTextFieldStyle()),
              const SizedBox(height: 5),
              Text(subtitle, style: AppWidget.LightTextFieldStyle()),
              const SizedBox(height: 5),
              Text(price, style: AppWidget.SemiboldTextFieldStyle()),
            ],
          ),
        ),
      ),
    );
  }

  // Category Icons (Ice cream, Pizza, Salad, Burger)
  Widget showItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            icecream = true;
            pizza = false;
            salad = false;
            burger = false;
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: icecream ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                "images/ice-cream.png",
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                color: icecream ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            icecream = false;
            pizza = true;
            salad = false;
            burger = false;
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: pizza ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                "images/pizza.png",
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                color: pizza ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            icecream = false;
            pizza = false;
            salad = true;
            burger = false;
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: salad ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                "images/salad.png",
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                color: salad ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            icecream = false;
            pizza = false;
            salad = false;
            burger = true;
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: burger ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                "images/burger.png",
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                color: burger ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
