import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'restaurant_data.dart';
import 'food_data.dart';
import 'food_menu.dart';

class RestaurantMenu extends StatefulWidget {

  final int index;
  @override
  RestaurantMenu({@required this.index});

  _RestaurantMenu createState() => _RestaurantMenu(index: index);
}

class _RestaurantMenu extends State<RestaurantMenu>{

  final int index;
  @override
  _RestaurantMenu({this.index});
  
  Widget menu(BuildContext context){
    List<Widget> list = new List<Widget>();
    for (var i = 0; i < food_titles.length; i++) {
      String a = food_titles[i];
      list.add(new GestureDetector(
        child: Text(
          '$a  ',
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => new FoodMenu(index: i)
            ),
          );
        },
      ),
      );
    }
    return new Row(children: list,);
  }
  
  Widget build(BuildContext context) {
    final key = new GlobalKey<ScaffoldState>();
    return Scaffold(
      key: key,
      appBar: new AppBar(
        centerTitle: true,
        title: Text(resto_name[index]),
        backgroundColor: Colors.red,
      ),
      body: ListView(
        padding: EdgeInsets.all(30.0),
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              resto_img[index],
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
          Text(
            resto_desc[index],
          ),
          SizedBox(
            height: 20,
            width: 200,
            child: Divider(
              color: Colors.black,
            ),
          ),

          new GestureDetector(
            child: new Text(resto_loc[index]),
            onLongPress: (){
              Clipboard.setData(new ClipboardData(text: resto_loc[index]));
              key.currentState.showSnackBar(
                  new SnackBar(content: new Text("Copied to Clipboard"),));
            },
          ),
          Text(
            '(Hold Location to Copy)'
          ),
          Text(
           '\nMenu : ',
          ),
          menu(context),
        ],
      ),
    );
  }
}
