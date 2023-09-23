import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../const.dart';
import '../widget/main_fields.dart';

class Shop {
  final String name;
  final String stock;
  final String price;
  final String total;

  Shop(this.name, this.stock, this.price, this.total);
}

class ItemsPage extends StatefulWidget {
  const ItemsPage({Key? key});

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  List<Shop> itemlist = [
    Shop('Soap', '120', '50', '10'),
    Shop('lamp', '120', '20', '15'),
    Shop('sugar', '120', '20', '15'),
    // Add more shop objects here
  ];

  List<Shop> selecteditemlist = [];

  TextEditingController _searchController = TextEditingController();
  List<Shop> filtereditemlist = [];

  var count = 1;

  void Add(){
    setState(() {
      count++;
    });
  }
  void Sub(){
    setState(() {
      count--;
    });
  }

  void updateFilteredShops(String query) {
    setState(() {
      filtereditemlist = itemlist
          .where((shop) =>
      shop.name.toLowerCase().contains(query.toLowerCase()) ||
          shop.stock.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  bool isItemAlreadySelected(Shop item) {
    return selecteditemlist.contains(item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text(
                'Orders',
                style: GoogleFonts.poppins(),
              ),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text(
                'Logout',
                style: GoogleFonts.poppins(),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
        child: Column(
          children: [
            Row(
              children: [
                Builder(
                  builder: (BuildContext context) {
                    return IconButton(
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      icon: Icon(Icons.menu, color: app_color, size: 35),
                    );
                  },
                ),
              ],
            ),
            TextFieldOne(
              sufix: Icons.search,
              hinttext: 'Search Item',
              controller: _searchController,
              onchange: (value) {
                updateFilteredShops(value);
              },
              obsecuretxt: false,
            ),
            if (_searchController.text.isNotEmpty &&
                filtereditemlist.isNotEmpty)
              Expanded(
                child: _searchController.text.isEmpty
                    ? Container() // Hide results when search query is empty
                    : ListView.builder(
                  itemCount: filtereditemlist.length,
                  itemBuilder: (context, index) {
                    final item = filtereditemlist[index];
                    final isItemSelected = isItemAlreadySelected(item);
                    return Column(
                      children: [
                        ListTile(
                          title: Text(item.name),
                          subtitle: Text(item.stock),
                          trailing: GestureDetector(
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    5, 0, 5, 0),
                                child: Text(
                                  isItemSelected ? 'Added' : 'Add',
                                  style: isItemSelected
                                      ? TextStyle(color: Colors.grey)
                                      : smallbutton,
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: isItemSelected
                                    ? Colors.grey.withOpacity(0.5)
                                    : app_color,
                              ),
                            ),
                            onTap: () {
                              if (!isItemSelected) {
                                setState(() {
                                  selecteditemlist.add(item);
                                });
                              }
                            },
                          ),
                        ),
                        Divider(
                          thickness: 2,
                          color: app_color.withOpacity(.2),
                        )
                      ],
                    );
                  },
                ),
              ),
            // Text('Selected Shops:'),
            Expanded(
              child: ListView.builder(
                itemCount: selecteditemlist.length,
                itemBuilder: (context, index) {
                  final item = selecteditemlist[index];
                  return Column(
                    children: [
                      Dismissible(
                        key: Key(item.name), // Use a unique key
                        onDismissed: (direction) {
                          // Remove the item from the list and rebuild the widget.
                          setState(() {
                            selecteditemlist.removeAt(index);
                          });
                          // Then show a snackbar.
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${item.name} canceled'),
                            ),
                          );
                        },
                        // Show a red background as the item is swiped away.
                        background: Container(
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                child: Text(
                                  'Cancel',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                          ),
                          color: Colors.red,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10,10,10,10),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Text(overflow:TextOverflow.fade ,item.name, style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.bold),),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      Text(item.stock, style: GoogleFonts.poppins()),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(25,0,25,0),
                                        child: Text(item.price, style: GoogleFonts.poppins()),
                                      ),
                                      Text(item.total, style: GoogleFonts.poppins()),
                                    ],
                                  ),

                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    child: CircleAvatar(
                                      child: Text('-',style: b_w_p),
                                    ),
                                    onTap: () => Sub(),
                                  ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20,0,20,0),
                                child: Text('${count}',style:button_home,),
                              ),
                              GestureDetector(
                                child: CircleAvatar(
                                  child: Text('+',style: b_w_p,),
                                ),
                                onTap: () => Add(),
                              )
                                ],
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                        ),
                      ),
                      Divider(thickness: 2,color: app_color.withOpacity(.2),)
                    ],
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
