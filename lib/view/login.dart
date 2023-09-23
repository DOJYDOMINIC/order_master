import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_master/widget/main_fields.dart';
import '../const.dart';
import 'home_screen.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController  _usercode= TextEditingController();
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
        body: Stack(
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
                          obsecuretxt: false, onchange: (value) {  },
                        ),
                        TextFieldOne(
                          hinttext: 'Password',
                          controller: _password,
                          obsecuretxt: true, onchange: (value) {  },
                        ),
                        TextFieldOne(
                          hinttext: 'User Code',
                          controller: _usercode,
                          obsecuretxt: false, onchange: (value) {  },
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
                      },
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 31, 65, 188)
                                  .withOpacity(.3),
                              spreadRadius: 5,
                              blurRadius: 10,
                              offset: Offset(5, 3),
                            ),
                          ],
                          color: app_color,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'Sign in',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
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
    );
  }
}
