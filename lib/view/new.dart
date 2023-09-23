import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Shop {
  final String name;
  final String stock;
  final String price;
  final String total;
  int count;

  Shop(this.name, this.stock, this.price, this.total, this.count);
}

class ItemsPage extends StatefulWidget {
  const ItemsPage({Key? key});

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  List<Shop> itemlist = [
    Shop('Soap', '120', '50', '10', 0),
    Shop('lamp', '120', '20', '15', 0),
    Shop('sugar', '120', '20', '15', 5),
    // Add more shop objects here
  ];

  TextEditingController _searchController = TextEditingController();
  List<Shop> filtereditemlist = [];

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
    return filtereditemlist.contains(item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
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
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search Item',
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                updateFilteredShops(value);
              },
            ),
            if (_searchController.text.isNotEmpty && filtereditemlist.isNotEmpty)
              Expanded(
                child: _searchController.text.isEmpty
                    ? Container() // Hide results when the search query is empty
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
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: isItemSelected
                                    ? Colors.grey.withOpacity(0.5)
                                    : Colors.blue,
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                if (isItemSelected) {
                                  // Remove the item from the list
                                  filtereditemlist.remove(item);
                                } else {
                                  // Add the item to the list
                                  filtereditemlist.add(item);
                                }
                              });
                            },
                          ),
                        ),
                        Divider(
                          thickness: 2,
                          color: Colors.blue.withOpacity(.2),
                        ),
                      ],
                    );
                  },
                ),
              ),
            // Text('Selected Shops:'),
            Expanded(
              child: ListView.builder(
                itemCount: filtereditemlist.length,
                itemBuilder: (context, index) {
                  final item = filtereditemlist[index];
                  return Column(
                    children: [
                      ListTile(
                        title: Text(item.name),
                        subtitle: Text(item.stock),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              child: CircleAvatar(
                                child: Text('-', style: TextStyle(color: Colors.white)),
                                backgroundColor: Colors.red,
                              ),
                              onTap: () {
                                setState(() {
                                  if (item.count > 0) {
                                    item.count--;
                                  }
                                });
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                item.count.toString(),
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            GestureDetector(
                              child: CircleAvatar(
                                child: Text('+', style: TextStyle(color: Colors.white)),
                                backgroundColor: Colors.green,
                              ),
                              onTap: () {
                                setState(() {
                                  item.count++;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 2,
                        color: Colors.blue.withOpacity(.2),
                      ),
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

