import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../const.dart';
import '../widget/main_fields.dart';

class Shop {
  final String name;
  final int stock;
  final num price;
  num count = 1;

  Shop(this.name, this.stock, this.price);
}

class ItemsPage extends StatefulWidget {
  const ItemsPage({Key? key}) : super(key: key);

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  List<Shop> itemlist = [
    Shop('Soap', 120, 50),
    Shop('lamp', 120, 50),
    Shop('sugar', 120, 20),
    Shop('sugar1', 120, 20),
    Shop('sugar2', 120, 20),
    Shop('sugar3', 120, 20),
    Shop('sugar5', 120, 20),
    // Add more shop objects here
  ];

  double calculateTotal() {
    double total = 0;
    for (Shop item in selecteditemlist) {
      total += item.price * item.count;
    }
    return total;
  }

  List<Shop> selecteditemlist = [];

  final TextEditingController _searchController = TextEditingController();
  List<Shop> filtereditemlist = [];

  // Create a map to hold TextEditingControllers for each item
  final Map<Shop, TextEditingController> itemControllers = {};

  void updateFilteredShops(String query) {
    setState(() {
      filtereditemlist = itemlist
          .where((shop) =>
          shop.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();

    // Initialize TextEditingControllers for each item
    for (final item in itemlist) {
      itemControllers[item] = TextEditingController(text: item.count.toString());
    }
  }

  @override
  void dispose() {
    // Dispose of TextEditingControllers to prevent memory leaks
    for (final controller in itemControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: BottomAppBar(
          elevation: 0,
          child: SizedBox(
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: app_color, // Set the background color of the button
              ),
              onPressed: () {},
              child: Text('Total:  ₹${calculateTotal().toStringAsFixed(2)}'),
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
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
              leading: const Icon(Icons.shopping_cart),
              title: Text(
                'Orders',
                style: GoogleFonts.poppins(),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
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
            if (_searchController.text.isNotEmpty && filtereditemlist.isNotEmpty)
              ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height / 8,
                  maxHeight: MediaQuery.of(context).size.height / 4,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26),
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: filtereditemlist.length,
                    itemBuilder: (context, index) {
                      final item = filtereditemlist[index];
                      final isItemSelected = selecteditemlist.contains(item);
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: Text(item.name),
                            subtitle: Text('${item.stock}'),
                            trailing: GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: isItemSelected
                                      ? Colors.grey.withOpacity(0.5)
                                      : app_color,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  child: Text(
                                    isItemSelected ? 'Added' : 'Add',
                                    style: isItemSelected
                                        ? const TextStyle(color: Colors.grey)
                                        : smallbutton,
                                  ),
                                ),
                              ),
                              onTap: () {
                                if (!isItemSelected) {
                                  setState(() {
                                    selecteditemlist.add(item);
                                    _searchController.clear();
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
              ),
            Expanded(
              child: ListView.builder(
                itemCount: selecteditemlist.length,
                itemBuilder: (context, index) {
                  final item = selecteditemlist[index];
                  return Column(
                    children: [
                      Dismissible(
                        key: Key(item.name),
                        onDismissed: (direction) {
                          setState(() {
                            selecteditemlist.removeAt(index);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${item.name} canceled'),
                            ),
                          );
                        },
                        background: Container(
                          color: Colors.red,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.name, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),),
                                  const SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      Text('${item.stock - item.count}', style: GoogleFonts.poppins()),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                                        child: Text('${item.price}', style: GoogleFonts.poppins()),
                                      ),
                                      Text('${item.price * item.count}', style: GoogleFonts.poppins()),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    child: CircleAvatar(
                                      backgroundColor: app_color,
                                      child: const Text('-', style: TextStyle(color: Colors.white)),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        if (item.count > 1) {
                                          item.count--;
                                          itemControllers[item]!.text = item.count.toString();
                                        }
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    width: 70,
                                    child: TextField(
                                      controller: itemControllers[item], // Use the controller for this item
                                      onChanged: (value) {
                                        setState(() {
                                          var newValue = int.tryParse(value);
                                          if (newValue != null) {
                                            if (newValue <= item.stock) {
                                              // Update the count if it's within the stock limit
                                              item.count = newValue;
                                            } else {
                                              // Show an alert dialog if the count exceeds the stock
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text('Invalid Count'),
                                                    content: Text('Count cannot exceed stock (${item.stock})'),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context).pop();
                                                        },
                                                        child: Text('OK'),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                              // Reset the TextField value to the current item count
                                              itemControllers[item]!.text = item.count.toString();
                                            }
                                          }
                                        });
                                      },
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        border: UnderlineInputBorder(borderSide: BorderSide.none),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    child: CircleAvatar(
                                      backgroundColor: app_color,
                                      child: const Text('+', style: TextStyle(color: Colors.white)),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        if (item.count < item.stock) {
                                          item.count++;
                                          itemControllers[item]!.text = item.count.toString();
                                        } else {
                                          // Show an alert dialog if the count exceeds the stock
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text('Invalid Count'),
                                                content: Text('Count cannot exceed stock (${item.stock})'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: Text('OK'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }
                                      });
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Divider(thickness: 2, color: app_color.withOpacity(.2),),
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
