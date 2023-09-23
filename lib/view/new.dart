// import 'package:flutter/material.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class City {
//   City(this.name);
//   final String name;
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('City Search'),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: CitySearchWidget(),
//         ),
//       ),
//     );
//   }
// }
//
// class CitySearchWidget extends StatefulWidget {
//   @override
//   _CitySearchWidgetState createState() => _CitySearchWidgetState();
// }
//
// class _CitySearchWidgetState extends State<CitySearchWidget> {
//   final TextEditingController _controller = TextEditingController();
//   List<City> _cities = [];
//
//   @override
//   void initState() {
//     super.initState();
//     fetchCities(); // Fetch city data when the widget initializes
//   }
//
//   Future<void> fetchCities() async {
//     final response = await http.get(Uri.parse('YOUR_API_ENDPOINT'));
//
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       final cityList = List<City>.from(data.map((city) => City(city['name'])));
//
//       setState(() {
//         _cities = cityList;
//       });
//     } else {
//       throw Exception('Failed to load cities');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         TypeAheadField<City>(
//           textFieldConfiguration: TextFieldConfiguration(
//             controller: _controller,
//             decoration: InputDecoration(
//               labelText: 'Search for a city',
//               border: OutlineInputBorder(),
//             ),
//           ),
//           suggestionsCallback: (pattern) {
//             return _cities.where((city) {
//               return city.name.toLowerCase().contains(pattern.toLowerCase());
//             });
//           },
//           itemBuilder: (context, City suggestion) {
//             return ListTile(
//               title: Text(suggestion.name),
//             );
//           },
//           onSuggestionSelected: (City suggestion) {
//             // Do something when a suggestion is selected
//             print('Selected city: ${suggestion.name}');
//           },
//         ),
//       ],
//     );
//   }
// }
