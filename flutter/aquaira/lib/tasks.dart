
import 'package:aquaira/select_site_dialog.dart';
import 'package:flutter/material.dart';
import 'package:aquaira/TaskPamelDialog.dart';
import 'package:aquaira/deleteDialog.dart';
import 'package:aquaira/editTaskGroup.dart';
import 'package:aquaira/editTasks.dart';
import 'package:aquaira/sample.dart';
import 'package:flutter/material.dart';
class Tasks extends StatefulWidget {
  const Tasks({Key? key}) : super(key: key);

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  final List<ExpansionItem> _expansionItems = [
    ExpansionItem(
      headerValue: 'Task Group Name 1',
      checked: false,
      expandedValue: [
        ItemData(title: 'Task Name 1', module: 'Module Name', emailList: 'Email List 1', addressList : 'Address List 1', description: '51/100 Successful', color: Colors.green, proxyList: 'ProxyList 1'),
        ItemData(title: 'Task Name 2', module: 'Module Name', emailList: 'Email List 2', addressList : 'Address List 2', description: '78/100 Successful', color: Colors.green, proxyList: 'ProxyList 2'),
        ItemData(title: 'Task Name 3', module: 'Module Name', emailList: 'Email List 3', addressList : 'Address List 3', description: '21/100 Failed' , color: Colors.red, proxyList: 'ProxyList 3'),
      ],
    ),
    ExpansionItem(
      headerValue: 'Task Group Name 2',
      checked: false,
      expandedValue: [
        ItemData(title: 'Task Name 1', module: 'Module Name', emailList: 'Email List 1', addressList : 'Address List 1', description: '2/100 Failed', color: Colors.green, proxyList: 'ProxyList 1'),
        ItemData(title: 'Task Name 2', module: 'Module Name', emailList: 'Email List 2', addressList : 'Address List 2', description: '78/100 Successful', color: Colors.green, proxyList: 'ProxyList 2'),
        ItemData(title: 'Task Name 3', module: 'Module Name', emailList: 'Email List 3', addressList : 'Address List 3', description: '21/100 Failed',  color: Colors.red, proxyList: 'ProxyList 3'),
      ],
    ),
    ExpansionItem(
      headerValue: 'Task Group Name 3',
      checked: false,
      expandedValue: [
        ItemData(title: 'Task Name 1', module: 'Module Name', emailList: 'Email List 1', addressList : 'Address List 1', description: '41/100 Successful', color: Colors.green, proxyList: 'ProxyList 1'),
        ItemData(title: 'Task Name 2', module: 'Module Name', emailList: 'Email List 2', addressList : 'Address List 2', description: '78/100 Successful', color: Colors.green, proxyList: 'ProxyList 2'),
        ItemData(title: 'Task Name 3', module: 'Module Name', emailList: 'Email List 3', addressList : 'Address List 3', description: '21/100 Failed', color: Colors.red, proxyList: 'ProxyList 3'),
        ItemData(title: 'Task Name 4', module: 'Module Name', emailList: 'Email List 4', addressList : 'Address List 4', description: '66/100 Successful', color: Colors.green, proxyList: 'ProxyList 4'),
        ItemData(title: 'Task Name 5', module: 'Module Name', emailList: 'Email List 5', addressList : 'Address List 5', description: '78/100 Successful', color: Colors.green, proxyList: 'ProxyList 5'),
        ItemData(title: 'Task Name 6', module: 'Module Name', emailList: 'Email List 5', addressList : 'Address List 6', description: '17/100 Failed', color: Colors.red, proxyList: 'ProxyList 6'),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[900],
        title: Row(
          children: [
            Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 20, 5, 5),
              child: ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return MyDialogForm();
                    },
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.orange; // Color when button is pressed
                      } else if (states.contains(MaterialState.focused)) {
                        return Colors.orangeAccent; // Color when button is focused
                      }
                      // Default color
                      return Colors.grey.shade800;
                    },
                  ),
                ),
                icon: const Icon(Icons.add),
                label: const Text('Create Task Group'),
              ),),
            Padding(padding: const EdgeInsets.fromLTRB(0, 10, 5, 5),
                child: IconButton(
                  onPressed: () {
                    // Add your onPressed logic here
                  },
                  icon: const Icon(
                    Icons.help_outline,
                    size: 18,
                    color: Colors.white,
                  ),
                )
            )

          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ReorderableListView(
          buildDefaultDragHandles: false,
          children: [
            for (int index = 0; index < _expansionItems.length; index++)
              Column(
                key: Key('ExpansionPanelList_$index'),
                mainAxisSize: MainAxisSize.min,
                children: [
                  ExpansionPanelList(
                    key: Key('ExpansionPanelList_$index'),
                    elevation: 1,
                    expandedHeaderPadding: EdgeInsets.zero,
                    expansionCallback: (int itemIndex, bool isExpanded) {
                      setState(() {
                        _expansionItems[itemIndex].checked = !isExpanded;
                      });
                    },
                    children: [
                      ExpansionPanel(
                        backgroundColor: Colors.grey[850],
                        headerBuilder: (context, isExpanded) {
                          return ListTile(
                            title: InkWell(
                              onTap: (){
                                setState(() {
                                  _expansionItems.forEach((f) => f.checked = false);
                                  _expansionItems[index].checked = true;
                                });
                              },
                              child: ListTile(
                                title: Row(
                                  children: [
                                    Text(_expansionItems[index].headerValue, style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),),
                                    const SizedBox(width: 10,),
                                    Theme(
                                      data: Theme.of(context).copyWith(
                                        unselectedWidgetColor: Colors.white, // Change the check icon color here
                                      ),
                                      child: Checkbox(
                                        checkColor: Colors.orange,
                                        activeColor: Colors.orange,
                                        value: _expansionItems[index].checked,
                                        onChanged: (value) {
                                          setState(() {
                                            _expansionItems[index].checked = value!;
                                          });
                                        },

                                      ),
                                    ),
                                    IconButton(onPressed: (){}, icon: const Icon(Icons.pause_circle_outline, color: Colors.white,size: 20)),
                                    IconButton(onPressed: (){}, icon: const Icon(Icons.timer_outlined, size: 20, color: Colors.white70,)),
                                    const SizedBox(width: 10,),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey[900],
                                      ),

                                      child: Padding(padding: const EdgeInsets.all(9),
                                        child: InkWell(
                                          onTap: (){},
                                          child: Text('44/100 Running', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, backgroundColor: Colors.grey[900], fontSize: 10),),
                                        ),),
                                    ),
                                    const SizedBox(width: 5,),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey[900],
                                      ),
                                      child: Padding(padding: const EdgeInsets.all(9),
                                        child: InkWell(
                                          onTap: (){},
                                          child: Text('517 Successful', style: TextStyle(color: Colors.greenAccent[700],fontWeight: FontWeight.bold, backgroundColor: Colors.grey[900],fontSize: 10,)),
                                        ),),
                                    ),
                                    const SizedBox(width: 5,),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey[900],
                                      ),
                                      child: Padding(padding: const EdgeInsets.all(9),
                                        child: InkWell(
                                          onTap: (){},
                                          child: Text('103 Failed', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red, backgroundColor: Colors.grey[900],fontSize: 10),),
                                        ),),
                                    )
                                  ],
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      alignment: Alignment.center,
                                      icon:  Image.asset(
                                        'Assets/add.png',
                                        width: 24,
                                        height: 24,
                                      ),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return ImageGridDialog(variable: _expansionItems[index].headerValue,);
                                          },
                                        );
                                      },
                                    ),
                                    IconButton(
                                      alignment: Alignment.center,
                                      icon:  Image.asset(
                                        'Assets/edit.png',
                                        width: 24,
                                        height: 24,
                                      ),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return MyDialogTaskGroupEdit(variable: _expansionItems[index].headerValue, idM: '', onDeleteSuccess: () {  },);
                                          },
                                        );
                                      },
                                    ),
                                    IconButton(
                                      alignment: Alignment.center,
                                      icon:  Image.asset(
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
                                      icon:  Image.asset(
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
                                      icon:  Image.asset(
                                        'Assets/delete.png',
                                        width: 24,
                                        height: 24,
                                      ),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return MyDialogTaskGroupDelete(variable: _expansionItems[index].headerValue, idM: '', onDeleteSuccess: () {  },);
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                  leading: ReorderableDragStartListener(
                                    key: ValueKey<int>(index),
                                    index: index,
                                    child: const Icon(Icons.drag_handle, color: Colors.white,),
                                  ),

                              ),
                            ),
                          );
                        },
                        body: Column(
                          children: _expansionItems[index].expandedValue.map<Widget>((ItemData value) {
                            return Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 29, right: 29),
                                  child: Opacity(
                                    opacity: 0.2,
                                    child: Divider(
                                      height: 0.4,
                                      color: Colors.orange,
                                    ),
                                  ),
                                ),
                                ListTile(
                                  leading: IconButton(onPressed: (){}, icon: const Icon(Icons.crop_square_rounded, color: Colors.white,)),
                                  title: Row(
                                    children: [
                                      Text(value.title, style: const TextStyle(color: Colors.orange, fontSize: 14,fontWeight: FontWeight.bold,),),
                                      const SizedBox(width: 20,),
                                      IconButton(
                                        alignment: Alignment.center,
                                        icon:  Image.asset(
                                          'Assets/play.png',
                                          width: 24,
                                          height: 24,
                                        ),
                                        onPressed: () {
                                          // Handle account icon press
                                        },
                                      ),
                                      IconButton(onPressed: (){}, icon: const Icon(Icons.crop_square_rounded, color: Colors.white,size: 20)),
                                      const SizedBox(width: 40,),
                                      Text(value.module, style: TextStyle(color: Colors.white, fontSize: 14),),
                                      const SizedBox(width: 10,),
                                      const Text('|', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold ),),
                                      const SizedBox(width: 10,),
                                      Text(value.emailList, style: TextStyle(color: Colors.white, fontSize: 14),),
                                      const SizedBox(width: 10,),
                                      const Text('|', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),),
                                      const SizedBox(width: 10,),
                                      Text(value.proxyList, style: TextStyle(color: Colors.white, fontSize: 14),),
                                      const SizedBox(width: 10,),
                                      const Text('|', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),),
                                      const SizedBox(width: 10,),
                                      Text(value.addressList, style: TextStyle(color: Colors.white, fontSize: 14),),


                                      const SizedBox(width: 25,),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.grey[900],
                                        ),
                                        child: Padding(padding: const EdgeInsets.all(9),
                                          child: InkWell(
                                            onTap: (){},
                                            child: Text(value.description, style: TextStyle(color: value.color,fontWeight: FontWeight.bold, backgroundColor: Colors.grey[900],fontSize: 10,)),
                                          ),),
                                      ),

                                    ],
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        alignment: Alignment.center,
                                        icon:  Image.asset(
                                          'Assets/edit.png',
                                          width: 24,
                                          height: 24,
                                        ),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return MyDialogTasksEdit(variable: value.title,);
                                            },
                                          );
                                        },
                                      ),
                                      IconButton(
                                        alignment: Alignment.center,
                                        icon:  Image.asset(
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
                                        icon:  Image.asset(
                                          'Assets/delete.png',
                                          width: 24,
                                          height: 24,
                                        ),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return MyDialogTaskGroupDelete(variable: value.title, idM: '', onDeleteSuccess: () {  },);
                                            },
                                          );
                                        },
                                      ),
                                      const SizedBox(width: 70,)
                                    ],
                                  ),

                                ),
                              ],
                            );

                          }).toList(),
                        ),
                        isExpanded: _expansionItems[index].checked,
                      ),
                    ],
                  ),
                ],
              ),
          ],
          onReorder: (oldIndex, newIndex) {
            setState(() {
              if (newIndex > oldIndex) {
                newIndex -= 1;
              }
              final item = _expansionItems.removeAt(oldIndex);
              _expansionItems.insert(newIndex, item);
            });
          },
        ),
      ),
    );
  }
}

class ExpansionItem {
  ExpansionItem({
    required this.headerValue,
    required this.checked,
    required this.expandedValue,
    this.isExpanded = false,
  });

  bool checked;
  String headerValue;
  List<ItemData> expandedValue;
  bool isExpanded;
}

class ItemData {
  ItemData({
    required this.title,
    required this.module,
    required this.emailList,
    required this.addressList,
    required this.description,
    required this.color,
    required this.proxyList

  });

  Color color;
  String proxyList;
  String title;
  String module;
  String description;
  String emailList;
  String addressList;
}
