import 'package:flutter/material.dart';
import 'package:order_master/const.dart';
import 'package:order_master/widget/main_fields.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController _shopsearch = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;


    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: app_color,
              ),
              child: Text(
                'Agent Name',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Orders'),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10,30,10,0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Builder(
                  builder: (BuildContext context) {
                    return IconButton(
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      icon: Icon(Icons.menu, color: app_color,size: 35),
                    );
                  },
                ),
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width/3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          border: Border.all(color: app_color)),
                      child: Row(
                        children: [
                          Container(
                              width:  MediaQuery.of(context).size.width/4,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Center(child: TextField()),
                              )),
                          // Icon(Icons.arrow_drop_down_sharp)
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          TextFieldOne(hinttext: '', controller: _shopsearch, onchange: (value) {}, obsecuretxt: false),

        ],
      ),
    );
  }
}
