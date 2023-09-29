import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_master/widget/main_fields.dart';
import '../const.dart';
import '../service/apis.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

bool isPressed = false;
String? username;
String? password;
String? usercode;

Future<void> Loginapi(// String username,
    // String password,
    // String usercode,
    ) async {
  try {
    final response = await http.post(Uri.parse('${api}/?username=qwerty'));
// http://ordereasy.000.pe/?i=1
//   &password=romario@123&usercode=romi
    // final response = await http.post(
    //   uri,
    //   body: {
    //     'username': username,
    //     'password': password,
    //     'usercode': usercode,
    //   },
    // );

    if (response.statusCode == 200) {
      // Successful response
      final Map<String, dynamic> data = json.decode(response.body);
      // Handle the response data as needed
      print('Login Success');
    } else {
      // Error response
      print('Error: ${response.statusCode}');
    }
  } catch (e) {
    // Handle exceptions
    print('Error: $e');
  }
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _usercode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!FocusScope.of(context).hasPrimaryFocus) {
          FocusScope.of(context).unfocus();
        }
      },
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * .3,
                    width: MediaQuery.of(context).size.width * .7,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 31, 65, 188).withOpacity(.03),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(300),
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Login here',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          fontSize: 30,
                          color: app_color,
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            'Welcome back you’ve ',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            'been missed! ',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          TextFieldOne(
                            hinttext: 'Username',
                            controller: _username,
                            obsecuretxt: false,
                            onchange: (value) {
                              username = value;
                            },
                          ),
                          TextFieldOne(
                            hinttext: 'Password',
                            controller: _password,
                            obsecuretxt: true,
                            onchange: (value) {
                              password = value;
                            },
                          ),
                          TextFieldOne(
                            hinttext: 'User Code',
                            controller: _usercode,
                            obsecuretxt: false,
                            onchange: (value) {
                              usercode = value;
                            },
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            if (_formKey.currentState!.validate()) {
                              isPressed = !isPressed;
                              Loginapi();
                            }
                          });
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: isPressed
                                ? LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [Colors.blue, Colors.blueAccent],
                                  )
                                : LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [Colors.blueAccent, Colors.blue],
                                  ),
                            boxShadow: isPressed
                                ? [
                                    BoxShadow(
                                      color: Colors.black26,
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: Offset(2, 2),
                                    ),
                                  ]
                                : [
                                    BoxShadow(
                                      color: Colors.transparent,
                                    ),
                                  ],
                          ),
                          child: Center(
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
