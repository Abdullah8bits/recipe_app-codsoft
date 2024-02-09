import 'package:flutter/material.dart';

class RecsipeScreen extends StatelessWidget {
  final Ingredientss;
  final name;
  const RecsipeScreen(
      {super.key, required this.Ingredientss, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[50],
        title: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text("Ingredients of $name")),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
              Color.fromARGB(255, 0, 0, 0).withOpacity(0.10),
              BlendMode.multiply,
            ),
            image: NetworkImage(
                'https://images.pexels.com/photos/349610/pexels-photo-349610.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.6),
                      offset: Offset(
                        10.0,
                        10.0,
                      ),
                      blurRadius: 8.0,
                      spreadRadius: -3.0,
                    ),
                  ],
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                      const Color.fromARGB(255, 0, 0, 0).withOpacity(0.50),
                      BlendMode.multiply,
                    ),
                    image: NetworkImage(
                        'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Ingredientss,
              ),
            )
          ],
        ),
      ),
    );
  }
}
