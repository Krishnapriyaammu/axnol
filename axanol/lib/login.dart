import 'package:axanol/api_service.dart';
import 'package:axanol/edit-profile.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
   final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  void _handleLogin() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await login(_emailController.text, _passwordController.text);
      if (response.containsKey('access_token')) {
        Fluttertoast.showToast(
          msg: "User logged in successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        // Extract user data
        Map<String, dynamic> userData = response['user'];

        // Navigate to EditProfile page with user data
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EditProfile(userData: userData)),
        );
      } else {
        setState(() {
          _errorMessage = response['error'] ?? 'Unknown error';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 40),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: GoogleFonts.suezOne(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: 'SHREE ',
                        style: TextStyle(color: Colors.red),
                      ),
                      TextSpan(
                        text: 'IRA\n',
                        style: TextStyle(color: Colors.orange),
                      ),
                      TextSpan(
                        text: 'EDUCATION',
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    label: RichText(
                      text: TextSpan(
                        text: 'Email address ',
                        style: GoogleFonts.roboto(color: Colors.black),
                        children: [
                          TextSpan(
                            text: '*',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                    filled: true,
                    fillColor: Color(0xFFF3F5F5),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange, width: 2.0),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    label: RichText(
                      text: TextSpan(
                        text: 'Password ',
                        style: GoogleFonts.roboto(color: Colors.black),
                        children: [
                          TextSpan(
                            text: '*',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                    filled: true,
                    fillColor: Color(0xFFF3F5F5),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange, width: 2.0),
                    ),
                    suffixIcon: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot?',
                        style: GoogleFonts.roboto(color: Color(0xFFFF0000)),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                if (_errorMessage != null) ...[
                  Text(
                    _errorMessage!,
                    style: TextStyle(color: Colors.red),
                  ),
                  SizedBox(height: 20),
                ],
                _isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _handleLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Text(
                            'Sign In',
                            style: GoogleFonts.roboto(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {},
                  child: RichText(
                    text: TextSpan(
                      text: 'Not registered yet? ',
                      style: GoogleFonts.roboto(color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Sign up now',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}