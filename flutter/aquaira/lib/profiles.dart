import 'dart:convert';
import 'package:aquaira/EmailList.dart';
import 'package:aquaira/EmailListDialog.dart';
import 'package:aquaira/editEmailList.dart';
import 'package:aquaira/editTaskGroup.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'deleteDialog.dart';

class Group {
  final String id;
  final String groupName;
  final List<String> emailLists;
  bool isExpanded; // Added isExpanded property

  Group({
    required this.id,
    required this.groupName,
    required this.emailLists,
    this.isExpanded = false, // Initialize isExpanded with default value
  });
}

class Email {
  final String id;
  final String listName;
  final List<String> emails;
  final String emailGroup;

  Email({
    required this.id,
    required this.listName,
    required this.emails,
    required this.emailGroup,
  });
}

class Profiles extends StatefulWidget {
  @override
  _ProfilesState createState() => _ProfilesState();
}

class _ProfilesState extends State<Profiles> {
  List<Group> groups = [];
  Map<String, List<Email>> emailMap = {};

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> onDeleteSuccess2() async {
    await fetchData(); // Fetch the data again after deletion
    // Other actions or state updates after successful deletion
  }
  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');

  }
  Future<void> fetchData() async {
    final String? token = await getAccessToken();
    // Fetch data from the first API
    final groupResponse = await http.get(
      Uri.parse('http://localhost:3000/api/emails/all'),
      headers: {'Authorization': 'Bearer $token'},
    );
    final groupData = json.decode(groupResponse.body) as List<dynamic>;
    final List<Group> fetchedGroups = groupData.map((item) {
      final id = item['_id'] as String;
      final groupName = item['GroupName'] as String;
      final emailLists = (item['EmailLists'] as List<dynamic>)
          .map((e) => e as String)
          .toList();
      return Group(id: id, groupName: groupName, emailLists: emailLists);
    }).toList();

    // Fetch data from the second API
    final emailResponse =
        await http.get(Uri.parse('http://localhost:3000/api/emails/list/all'));
    final emailData =
        json.decode(emailResponse.body)['email_List'] as List<dynamic>;
    final List<Email> fetchedEmails = emailData.map((item) {
      final id = item['_id'] as String;
      final listName = item['ListName'] as String;
      final emails =
          (item['Emails'] as List<dynamic>).map((e) => e as String).toList();
      final emailGroup = item['EmailGroup'] as String;
      return Email(
          id: id, listName: listName, emails: emails, emailGroup: emailGroup);
    }).toList();

    // Group emails by group ID
    emailMap = {};
    for (final email in fetchedEmails) {
      if (!emailMap.containsKey(email.emailGroup)) {
        emailMap[email.emailGroup] = [];
      }
      emailMap[email.emailGroup]?.add(email);
    }

    setState(() {
      groups = fetchedGroups;
    });
  }

  @override
  Widget build(BuildContext context) {
    var _currentIndex;
    return Container(
      color: Colors.grey[900],
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 25, 5, 5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: _currentIndex == 0
                            ? Colors.orange
                            : Colors.grey[850]),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 9, 15, 9),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _currentIndex = 0;
                          });
                        },
                        child: Row(
                          children: [
                            const Icon(Icons.email, color: Colors.white70),
                            Text(
                              ' Email',
                              style: _currentIndex == 0
                                  ? const TextStyle(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.bold,
                                      backgroundColor: Colors.orange,
                                      fontSize: 14)
                                  : const TextStyle(
                                      color: Colors.white70, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: _currentIndex == 1
                            ? Colors.orange
                            : Colors.grey[850]),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 9, 15, 9),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _currentIndex = 1;
                          });
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.home,
                              color: Colors.white70,
                            ),
                            Text(
                              ' Address',
                              style: _currentIndex == 1
                                  ? const TextStyle(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.bold,
                                      backgroundColor: Colors.orange,
                                      fontSize: 14)
                                  : const TextStyle(
                                      color: Colors.white70, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: _currentIndex == 2
                            ? Colors.orange
                            : Colors.grey[850]),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 9, 15, 9),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.switch_account,
                            color: Colors.white70,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _currentIndex = 2;
                              });
                            },
                            child: Text(
                              ' Accounts',
                              style: _currentIndex == 2
                                  ? const TextStyle(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.bold,
                                      backgroundColor: Colors.orange,
                                      fontSize: 14)
                                  : const TextStyle(
                                      color: Colors.white70, fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 20, 5, 5),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return MyDialogEmail(onDeleteSuccess: onDeleteSuccess2);
                          },
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors
                                  .orange; // Color when button is pressed
                            } else if (states.contains(MaterialState.focused)) {
                              return Colors
                                  .orangeAccent; // Color when button is focused
                            }
                            // Default color
                            return Colors.grey.shade800;
                          },
                        ),
                      ),
                      icon: const Icon(Icons.add),
                      label: const Text('Create Email Group'),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 5, 5),
                      child: IconButton(
                        onPressed: () {
                          // Add your onPressed logic here
                        },
                        icon: const Icon(
                          Icons.help_outline,
                          size: 18,
                          color: Colors.white,
                        ),
                      )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18.0, right: 18),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: groups.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(
                    color: Colors.grey[900],
                    thickness: 0.1,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final group = groups[index];
                    final emails = emailMap[group.id] ?? [];

                    return ExpansionPanelList(
                      elevation: 1,
                      expandedHeaderPadding: const EdgeInsets.all(8),
                      expansionCallback: (panelIndex, isExpanded) {
                        setState(() {
                          group.isExpanded = !isExpanded;
                        });
                      },
                      children: [
                        ExpansionPanel(
                          backgroundColor: Colors.grey[850],
                          headerBuilder: (ctx, isExpanded) {
                            return ListTile(
                              title: Row(
                                children: [
                                  Text(
                                    group.groupName,
                                    style: const TextStyle(
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey[900],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(9),
                                      child: InkWell(
                                        onTap: () {},
                                        child: Text(
                                          group.groupName,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              backgroundColor: Colors.grey[900],
                                              fontSize: 10),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    alignment: Alignment.center,
                                    icon: Image.asset(
                                      'Assets/add.png',
                                      width: 24,
                                      height: 24,
                                    ),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return MyDialogForm2(
                                              variable: group.groupName, idM: group.id, onDeleteSuccess: onDeleteSuccess2, catogory: '',);
                                        },
                                      );
                                    },
                                  ),
                                  IconButton(
                                    alignment: Alignment.center,
                                    icon: Image.asset(
                                      'Assets/edit.png',
                                      width: 24,
                                      height: 24,
                                    ),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return MyDialogTaskGroupEdit(
                                              variable: group.groupName, idM: group.id, onDeleteSuccess: onDeleteSuccess2,);
                                        },
                                      );
                                    },
                                  ),
                                  IconButton(
                                    alignment: Alignment.center,
                                    icon: Image.asset(
                                      'Assets/list.png',
                                      width: 22,
                                      height: 20,
                                    ),
                                    onPressed: () {
                                      // Handle account icon press
                                    },
                                  ),
                                  IconButton(
                                    alignment: Alignment.center,
                                    icon: Image.asset(
                                      'Assets/message.png',
                                      width: 24,
                                      height: 24,
                                    ),
                                    onPressed: () {
                                      // Handle account icon press
                                    },
                                  ),
                                  IconButton(
                                    alignment: Alignment.center,
                                    icon: Image.asset(
                                      'Assets/delete.png',
                                      width: 24,
                                      height: 24,
                                    ),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return MyDialogTaskGroupDelete(
                                            variable: group.groupName, idM: group.id, onDeleteSuccess: onDeleteSuccess2
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                              leading:
                                  const Icon(Icons.menu, color: Colors.white),
                            );
                          },
                          body: ListView.builder(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemCount: emails.length,
                            itemBuilder: (ctx, index) {
                              final email = emails[index];
                              return Column(
                                children: [
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(left: 29, right: 29),
                                    child: Opacity(
                                      opacity: 0.2,
                                      child: Divider(
                                        height: 0.4,
                                        color: Colors.orange,
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    // title: Text(email.listName),
                                    title: Row(
                                      children: [
                                        Text(
                                          email.listName,
                                          style: const TextStyle(
                                            color: Colors.orange,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),

                                        // Container(
                                        //   decoration: BoxDecoration(
                                        //     borderRadius: BorderRadius.circular(10),
                                        //     color: Colors.grey[900],
                                        //   ),
                                        //   child: Padding(padding: const EdgeInsets.all(9),
                                        //     child: InkWell(
                                        //       onTap: (){},
                                        //       child: Text(email.listName, style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold, backgroundColor: Colors.grey[900],fontSize: 10,)),
                                        //     ),),
                                        // ),
                                      ],
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          alignment: Alignment.center,
                                          icon: Image.asset(
                                            'Assets/list.png',
                                            width: 24,
                                            height: 24,
                                          ),
                                          onPressed: () {
                                            // Handle account icon press
                                          },
                                        ),
                                        IconButton(
                                          alignment: Alignment.center,
                                          icon: Image.asset(
                                            'Assets/edit.png',
                                            width: 24,
                                            height: 24,
                                          ),
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return editEmailListDialog(
                                                  variable: email.listName, idM: email.id, onDeleteSuccess: onDeleteSuccess2, emailLists: email.emails,
                                                );
                                              },
                                            );
                                          },
                                        ),
                                        IconButton(
                                          alignment: Alignment.center,
                                          icon: Image.asset(
                                            'Assets/delete.png',
                                            width: 24,
                                            height: 24,
                                          ),
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return MyDialogTaskGroupDelete(
                                                  variable: email.listName, idM: email.id, onDeleteSuccess: () {  },
                                                );
                                              },
                                            );
                                          },
                                        ),
                                        const SizedBox(
                                          width: 70,
                                        )
                                      ],
                                    ),
                                    leading: const Icon(Icons.square_outlined,
                                        color: Colors.white),
                                  ),
                                ],
                              );
                            },
                          ),
                          isExpanded: group.isExpanded ?? false,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
