import 'package:aquaira/Authenticator/createAccount.dart';
import 'package:aquaira/Authenticator/login.dart';
import 'package:aquaira/navigation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}


final TextEditingController _usernameController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
final TextEditingController _nameController = TextEditingController();
String err_msg = '';


class _CreateAccountState extends State<CreateAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
              color: Colors.grey[900]
          ),
          width: 500,
          height: 600,
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
                const SizedBox(height: 25,),
                TextFormField(
                  controller: _nameController,
                  style: const TextStyle(
                    color: Colors.white, // Set the desired text color
                  ),
                  decoration: InputDecoration(filled: true,
                      fillColor: Colors.grey[850], labelText: 'Fullname', focusedBorder: const OutlineInputBorder(
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
                const SizedBox(height: 15,),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  style: const TextStyle(
                    color: Colors.white, // Set the desired text color
                  ),
                  decoration: InputDecoration(filled: true,
                      fillColor: Colors.grey[850], labelText: "Confirm password", focusedBorder: const OutlineInputBorder(
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
                const Padding(
                  padding: EdgeInsets.all(8.0),

                ),

                const SizedBox(height: 15,),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.orange), // Set the desired button color
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text('Create Account'),
                    ),
                    onPressed: authenticateUser
                  ),
                ),
                const SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already a user? ', style: TextStyle(color: Colors.white70),),
                      InkWell(onTap:(){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Login()));
                      }, child: const Text('Login', style: TextStyle(color: Colors.orange,decoration: TextDecoration.underline,),)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void authenticateUser() async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;
    final String name = _passwordController.text;

    const url = 'http://localhost:3000/api/users/create'; // Replace with your API endpoint
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final Map<String, String> body = {
      'email': username,
      'password': password,
      'name':name
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
      err_msg =' ';
      Navigator.push(context, MaterialPageRoute(builder: (context) => const Login()));
    } else {
      setState(() {
        err_msg = 'Login Error';
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
