import 'package:flutter/material.dart';
import 'restaurant_data.dart';
import 'food_data.dart';
import 'restaurant_menu.dart';

TabController _tabController;

class FoodMenu extends StatefulWidget {

  final int index;

  @override
  FoodMenu({@required this.index});

  _FoodMenu createState() => _FoodMenu(index: index);
}

class _FoodMenu extends State<FoodMenu> with SingleTickerProviderStateMixin{

  final List<Tab> myTabs = <Tab>[
    Tab(
      icon: Icon(Icons.description),
      text: 'Description',
    ),
    Tab(icon: Icon(Icons.receipt), text: 'Ingredients'),
    Tab(
      icon: Icon(Icons.restaurant_menu),
      text: 'How to Eat',
    ),
  ];
  final int index;

  void initState() {
    super.initState();
    _tabController = TabController(length: myTabs.length, vsync: this);
  }

  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  _FoodMenu({this.index});
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: Text(food_titles[index]),
        backgroundColor: Colors.red,
        bottom: TabBar(
          controller: _tabController,
          tabs: myTabs,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(30.0),
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              food_images[index],
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            height: 20,
            width: 200,
            child: Divider(
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 500,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: myTabs.map((Tab tab) {
                      final String label = tab.text.toLowerCase();
                      if (label == 'description') {
                        return ListView(
                          children: <Widget>[
                            Text(
                                food_descs[index]
                            ),
                            Text(
                                '\nAvailable in :'
                            ),
                            GestureDetector(
                              child: Text(
                                resto_name[index],
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => new RestaurantMenu(index: index)
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      } else if (label == 'ingredients') {
                        return ListView(
                          children: <Widget>[
                            Text(
                                food_ingredients[index]
                            ),
                            Text(
                                '\nAvailable in :'
                            ),
                            GestureDetector(
                              child: Text(
                                resto_name[index],
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => new RestaurantMenu(index: index)
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      } else {
                        return ListView(
                          children: <Widget>[
                            Text(
                                food_howtoeat[index]
                            ),
                            Text(
                                '\nAvailable in :'
                            ),
                            GestureDetector(
                              child: Text(
                                resto_name[index],
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => new RestaurantMenu(index: index)
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      }
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
