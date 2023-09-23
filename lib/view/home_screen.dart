import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_master/const.dart';
import 'package:order_master/widget/main_fields.dart';

import 'items_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> shopNames = [
    'Relince',
    'Bismi',
    'Choice',
    'Relince',
    'Bismi',
    'Choice',

    // Add more shop names here
  ];

  List<String> location = [
    'Alappuzha',
    'Cherthala',
    'Mararikulam'
    // Add more shop names here
  ];

  TextEditingController _locationController = TextEditingController();

  TextEditingController _shopsearch = TextEditingController();
  List<String> filteredShopNames = []; // Filtered list of shop names

  @override
  void initState() {
    super.initState();
    // Initialize the filtered list with all shop names initially.
    filteredShopNames.addAll(shopNames);
  }

  // Function to update the filtered shop list based on the search query.
  void updateFilteredShops(String query) {
    setState(() {
      filteredShopNames = shopNames
          .where((shopName) =>
              shopName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        if (!FocusScope.of(context).hasPrimaryFocus) {
          FocusScope.of(context).unfocus();
        }
      },
      child: Scaffold(
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
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
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
          padding: const EdgeInsets.fromLTRB(15, 50, 15, 0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  Row(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                              border: Border.all(
                                width: 2,
                                color: _locationController.text.isNotEmpty
                                    ? app_color
                                    : Color.fromARGB(255, 31, 65, 188).withOpacity(
                                        .5), // Change border color when selected
                              ),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: TypeAheadField<String>(
                                  textFieldConfiguration:
                                      TextFieldConfiguration(
                                    controller: _locationController,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        // labelText: 'Location',
                                        hintText: 'Location',
                                        suffixIcon: Icon(
                                          Icons.arrow_drop_down_outlined,
                                          color: Colors.grey,
                                        )),
                                  ),
                                  suggestionsCallback: (pattern) {
                                    return location.where((loc) => loc
                                        .toLowerCase()
                                        .contains(pattern.toLowerCase()));
                                  },
                                  itemBuilder: (context, suggestion) {
                                    return ListTile(
                                      title: Text(suggestion,
                                          style: GoogleFonts.poppins(
                                              fontSize: 14)),
                                    );
                                  },
                                  onSuggestionSelected: (suggestion) {
                                    setState(() {
                                      _locationController.text = suggestion;
                                    });
                                  },
                                )),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              // SizedBox(height: 10,),
              TextFieldOne(
                hinttext: 'Customer Search',
                controller: _shopsearch,
                fillcolor: Colors.white,
                onchange: (value) {
                  updateFilteredShops(
                      value); // Update filtered shops when text changes
                },
                obsecuretxt: false,
              ),
              Expanded(
                  child: ListView.builder(
                itemCount: filteredShopNames.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ItemsPage(),
                          ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Container(
                        height: height / 6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: app_color),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        filteredShopNames[index],
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                          width: width / 2,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('Kalarcode,',
                                                  style: GoogleFonts.poppins(
                                                      color: Colors
                                                          .grey.shade600)),
                                              Text('Iravkadu,Alappuzha',
                                                  style: GoogleFonts.poppins(
                                                      color: Colors
                                                          .grey.shade600)),
                                              Text('ph : 985554887',
                                                  style: GoogleFonts.poppins(
                                                      color: Colors
                                                          .grey.shade600)),
                                            ],
                                          )),
                                    ],
                                  ),
                                  Container(
                                    height: 25,
                                    decoration: BoxDecoration(
                                        color: app_color,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Center(
                                        child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 10, 0),
                                      child: Text(
                                        'retail',
                                        style: GoogleFonts.poppins(
                                            color: Colors.white),
                                      ),
                                    )),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )),
              // Expanded(
              //     flex: 1,
              //     child:Container(color: Colors.green,)),
            ],
          ),
        ),
      ),
    );
  }
}
