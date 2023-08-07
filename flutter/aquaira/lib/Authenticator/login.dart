import 'package:aquaira/Authenticator/createAccount.dart';
import 'package:aquaira/navigation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}
final TextEditingController _usernameController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
String err_msg = '';
class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.grey.shade900, Colors.grey.shade900],
          ),
        ),
        child: Center(
          child: Container(

            width: 500,
            height: 550,
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'Assets/Sweepsy Logo 2-notext.png',
                        width: 40,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 13),
                        child: Text('Sweepsy', style: TextStyle(color: Colors.orange, fontSize: 29, fontWeight: FontWeight.bold),),
                      )
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Text(err_msg, style: TextStyle(color: Colors.red, fontSize: 20),),
                  const SizedBox(height: 10,),
                  TextFormField(
                    controller: _usernameController,
                    style: const TextStyle(
                      color: Colors.white, // Set the desired text color
                    ),
                    decoration: InputDecoration(filled: true,
                        fillColor: Colors.grey[850], labelText: 'Email', focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                        ), border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                        ), labelStyle: const TextStyle(color: Colors.white60)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a URL';
                      }
                      return null;
                    },
                    onSaved: (value) {},
                  ),
                  const SizedBox(height: 15,),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    style: const TextStyle(
                      color: Colors.white, // Set the desired text color
                    ),
                    decoration: InputDecoration(filled: true,
                        fillColor: Colors.grey[850], labelText: "Password", focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                        ), border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                        ), labelStyle: const TextStyle(color: Colors.white60)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a URL';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(onTap:(){}, child: const Text('Forget password?', style: TextStyle(color: Colors.white70, decoration: TextDecoration.underline,),)),
                      ],
                    ),
                  ),

                  const SizedBox(height: 15,),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.orange), // Set the desired button color
                      ),
                      onPressed: authenticateUser,
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text('Login'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Not a user? ', style: TextStyle(color: Colors.white70),),
                        InkWell(onTap:(){
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => CreateAccount()));
                        }, child: const Text('Create Account', style: TextStyle(color: Colors.orange,decoration: TextDecoration.underline,),)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void authenticateUser() async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;
    const url = 'http://localhost:3000/api/users/login'; // Replace with your API endpoint
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final Map<String, String> body = {
      'email': username,
      'password': password,
    };

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );
    String jsonResponse = response.body;

// Parse the JSON string into a Map object
    Map<String, dynamic> jsonMap = jsonDecode(jsonResponse);

// Extract the 'username' field from the Map

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final token = responseBody['access_token'];
      // Store the token for future requests
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', token);
      print(token);
      print('Login successful');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DesktopApp()),
      );
    } else {
      setState(() {
        err_msg = "Error in login";
      });
    }

  }


  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

}
