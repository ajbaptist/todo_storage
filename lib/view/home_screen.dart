import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../controller/controller.dart';
import '../module/location_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TodoController todoController = Get.put(TodoController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () async {
                LocationPermission permission;
                permission = await Geolocator.checkPermission();
                if (permission == LocationPermission.denied) {
                  permission = await Geolocator.requestPermission();
                  if (permission == LocationPermission.denied) {
                    return Future.error('Location permissions are denied');
                  }
                } else {
                  getUserLocation();
                  Fluttertoast.showToast(msg: "location enbled");
                }
              },
              icon: Icon(Icons.location_on_sharp))
        ],
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: todoController.rxList.length,
          itemBuilder: (context, index) {
            final title = todoController.rxList[index]["title"];
            final location = todoController.rxList[index]["location"];
            bool check = todoController.rxList[index]["check"];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: check == true ? Colors.greenAccent : Colors.grey,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(
                            title,
                            style: TextStyle(
                              decoration: check == true
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          leading: Checkbox(
                              value: check,
                              onChanged: (value) {
                                todoController.changeCheckList(index, value);
                              }),
                          trailing: IconButton(
                              onPressed: (() =>
                                  todoController.removeTodo(index)),
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              )),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Location :$location",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bottomSheet();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<void> bottomSheet() async {
    return showModalBottomSheet<void>(
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        builder: (BuildContext context) {
          final h = MediaQuery.of(context).size.height;

          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              height: h / 2.8,
              color: Colors.transparent,
              child: WillPopScope(
                onWillPop: () async => false,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("ADD TODO",
                          style: TextStyle(
                              fontSize: h * 0.030,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: h * 0.035),
                      TextField(
                        controller: todoController.textEditingController,
                        autofocus: true,
                        decoration: InputDecoration(
                            hintText: "Add todo here",
                            border: OutlineInputBorder()),
                      ),
                      SizedBox(height: h * 0.020),
                      TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.blue,
                            primary: Colors.white),
                        onPressed: () {
                          todoController.addTodo(
                              todoController.textEditingController.text);
                          todoController.textEditingController.clear();
                        },
                        child: const Text('ADD'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
