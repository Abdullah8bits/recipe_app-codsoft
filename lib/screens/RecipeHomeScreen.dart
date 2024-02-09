import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_app_by_scc/screens/recipescreen.dart';
import 'package:recipe_app_by_scc/widgets/recipecard.dart';
import 'dart:math';

class MyAppp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyAppp> {
  List<Map<String, dynamic>> recipeList = [];

  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  randomcooktime(int max) {
    var random = Random();

    int randomNumber = random.nextInt(max);
    return randomNumber;
  }

  randomratings() {
    var random = Random();

    double randomDouble = ((random.nextDouble() * 50).round() / 10) + 5.0;
    return randomDouble;
  }

  Future<void> fetchData([String food = ""]) async {
    try {
      String apiUrl = _buildApiUrl(food);
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          recipeList = data['hits']
              .map<Map<String, dynamic>>((hit) => {
                    'title': hit['recipe']['label'],
                    'image': hit['recipe']['image'],
                    'ingredients': hit['recipe']['ingredientLines'],
                  })
              .toList();
        });
      } else {
        print("Failed to fetch data: ${response.statusCode}");
      }
    } catch (error) {
      print("Error: $error");
    }
  }

  String _buildApiUrl(String food) {
    String baseUrl =
        "https://api.edamam.com/search?q=${food.isEmpty ? 'pasta' : food}&app_id=2cc8d34f&app_key=85a1d4e94d27204aaba428d3e41a345d";
    return baseUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[50],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant_menu),
            Text("Recipe's"),
          ],
        ),
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
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
              height: 50,
              child: TextField(
                onChanged: (value) {},
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(fontSize: 13),
                  prefixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          fetchData(nameController.text);
                        });
                      },
                      icon: Icon(Icons.search)),
                  filled: true,
                  fillColor: Colors.brown[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 10,
              child: ListView.builder(
                itemCount: recipeList.length,
                itemBuilder: (context, index) {
                  return RecipeCard(
                    button: Container(
                      height: double.infinity,
                      width: double.infinity,
                      child: InkWell(
                        onTap: () {
                          print("tapped");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RecsipeScreen(
                                name: recipeList[index]['title'],
                                Ingredientss: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Ingredient's",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    for (var ingredient in recipeList[index]
                                        ['ingredients'])
                                      Text(
                                        '   - $ingredient',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    title: recipeList[index]['title'],
                    cookTime: randomcooktime(120).toString(),
                    rating: randomratings().toString(),
                    thumbnailUrl: recipeList[index]['image'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
