import 'package:flutter/material.dart';
class Verifiers extends StatefulWidget {
  const Verifiers({Key? key}) : super(key: key);

  @override
  State<Verifiers> createState() => _VerifiersState();
}

class _VerifiersState extends State<Verifiers> {
  final _formKey = GlobalKey<FormState>();

  List<String> proxyList = [
    'Proxy 1',
    'Proxy 2',
    'Proxy 3',
  ];

  String selectedProxy = 'Proxy 1';

  List<String> confirmationUrls = [];
  int successfulTasks = 0;
  int failedTasks = 0;
  double progressValue = 0.0;
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top:88.0),
          child: Container(
            width: 800,
            color: Colors.grey[900],
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            style: const TextStyle(
                              color: Colors.white, // Set the desired text color
                            ),
                            decoration: InputDecoration(filled: true,
                                fillColor: Colors.grey[850], labelText: 'Confirmation URLs', focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.orange),
                                ), border: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.orange),
                                ), labelStyle: const TextStyle(color: Colors.white60)),
                            maxLines: null,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter at least one URL.';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                confirmationUrls = value.split('\n');
                              });
                            },
                          ),
                          SizedBox(height: 16.0),
                          DropdownButtonFormField<String>(
                            dropdownColor: Colors.grey[850],
                            style: const TextStyle(
                              color: Colors.white, // Set the desired text color
                            ),
                            value: selectedProxy,
                            decoration: InputDecoration(filled: true,
                              fillColor: Colors.grey[850], labelText: 'Select proxy', focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                          ), border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                          ), labelStyle: const TextStyle(color: Colors.white60)),
                            items: proxyList.map((proxy) {
                              return DropdownMenuItem<String>(
                                value: proxy,
                                child: Text(proxy),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedProxy = value!;
                              });
                            },
                          ),
                          SizedBox(height: 16.0),
                          Container(
                            height: 40,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.orange, // Set the background color to orange
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  // Start verification process
                                  _startVerification();
                                }
                              },
                              child: Text('Start Verification'),
                            ),
                          ),
                          SizedBox(height: 16.0),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: LinearProgressIndicator(
                              value: progressValue,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                              backgroundColor: Colors.grey[900],
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            'Progress: ${confirmationUrls.length} links',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Successful Tasks: $successfulTasks',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Failed Tasks: $failedTasks',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.red.shade400,
                              fontWeight: FontWeight.bold,
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
        ),
      ),
    );
  }
  void _startVerification() {
    successfulTasks = 0;
    failedTasks = 0;
    progressValue = 0.0;
    _updateProgress();

    Future.forEach(confirmationUrls, (url) {
      return Future.delayed(Duration(seconds: 1), () {
        if (confirmationUrls.indexOf(url) % 2 == 0) {
          successfulTasks++;
        } else {
          failedTasks++;
        }

        progressValue =
            (successfulTasks + failedTasks) / confirmationUrls.length;
        _updateProgress();
      });
    });
  }

  void _updateProgress() {
    setState(() {});
  }
}
