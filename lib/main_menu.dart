import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'food_data.dart';
import 'food_menu.dart';
import 'search_menu.dart';
import 'restaurant_data.dart';
import 'restaurant_menu.dart';

TabController _tabController;
int index;
final globalKey = new GlobalKey<ScaffoldState>();
final TextEditingController _controller = new TextEditingController();
List<dynamic> _list;
bool _isSearching;
String _searchText = "";
List searchresult = new List();

class MainMenu extends StatefulWidget {
  static String tag = 'main-menu';
  @override
  _MainMenuState createState() => new _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: '/', routes: {
      '/': (ctx) => ImageCarousel(),
    });
  }
}

class ImageCarousel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ImageCarouselState();
  }
}

class _ImageCarouselState extends State<ImageCarousel>
    with SingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    Tab(
      icon: Icon(Icons.check_circle),
      text: 'Recommendation',
    ),
    Tab(icon: Icon(Icons.star), text: 'Most Popular'),
    Tab(
      icon: Icon(Icons.new_releases),
      text: 'New Releases',
    ),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      food_images.forEach((imageUrl) {
        precacheImage(AssetImage(imageUrl), context);
      });
    });
    _tabController = TabController(length: myTabs.length, vsync: this);
  }

  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => new SearchMenu()
                ),
              );
            },
          )
        ],
        title: Text('Japanese Food Expert'),
        backgroundColor: Colors.red,
        bottom: TabBar(
          controller: _tabController,
          tabs: myTabs,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CarouselSlider.builder(
            itemCount: food_images.length,
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
            ),
            itemBuilder: (context, index) {
              return Container(
                child: Center(
                  child: Image.asset(food_images[index],
                      fit: BoxFit.cover, width: 1000),
                ),
              );
            },
          ),
          Center(
            child: Text(
              'Explore Japanese Food',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25, shadows: [
                Shadow(
                  blurRadius: 1.0,
                  color: Colors.grey,
                  offset: Offset(2.0, 2.0),
                )
              ]),
            ),
          ),
          Divider(),
          Flexible(
            child: TabBarView(
              controller: _tabController,
              children: myTabs.map((Tab tab) {
                final String label = tab.text.toLowerCase();
                List<Widget> list = new List<Widget>();
                if (label == 'recommendation') {
                  for (var i = 0; i < resto_img.length; i++) {
                    list.add(new GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => new FoodMenu(index: i)
                            ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.0)),
                            ),
                            child: Column(
                              children: <Widget>[
                                Stack(
                                  alignment: Alignment.topRight,
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          topLeft: Radius.circular(10)),
                                      child: Image.asset(
                                        food_images[i],
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              food_titles[i],
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ));
                  }
                  return ListView(
                    children: list,
                  );
                } else if (label == 'most popular') {
                  for (var i = 0; i < resto_img.length; i++) {
                    list.add(new GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => new RestaurantMenu(index: i)
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.0)),
                            ),
                            child: Column(
                              children: <Widget>[
                                Stack(
                                  alignment: Alignment.topRight,
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          topLeft: Radius.circular(10)),
                                      child: Image.asset(
                                        resto_img[i],
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              resto_name[i],
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              resto_short_desc[i],
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ));
                  }
                  return ListView(
                    children: list,
                  );
                } else {
                  for (var i = 0; i < resto_img.length; i++) {
                    list.add(new GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => new RestaurantMenu(index: i)
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.0)),
                            ),
                            child: Column(
                              children: <Widget>[
                                Stack(
                                  alignment: Alignment.topRight,
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          topLeft: Radius.circular(10)),
                                      child: Image.asset(
                                        resto_img[i],
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              resto_name[i],
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              resto_short_desc[i],
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ));
                  }
                  return ListView(
                    children: list,
                  );
                }
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
