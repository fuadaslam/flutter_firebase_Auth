import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List _items = [];

  @override
  void initState() {
    super.initState();
    readJson();
  }

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/data/user.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["Users"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
            height: MediaQuery.of(context).size.height ,
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            _items.isNotEmpty
                ? Expanded(
                    child: GridView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: _items.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / - 220)),
                      itemBuilder: (context, index) {
                        return Card(
                          key: ValueKey(_items[index]["Email"]),
                          margin: const EdgeInsets.all(10),
                          child: Container(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 0.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              color: Colors.white,
                            ),
                            child: Column(children: [
                              Stack(children: [
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        scale: 1.5,
                                        image: NetworkImage(
                                            _items[index]["image"]),
                                        fit: BoxFit.cover),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50.0)),
                                    color: Colors.white,
                                  ),
                                ),
                                if (_items[index]["isOnline"] == true)
                                  Positioned(
                                      right: 10,
                                      top: 80,
                                      child: Container(
                                        margin: EdgeInsets.only(top: 10),
                                        width: 20,
                                        height: 20,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50.0)),
                                          color: Colors.green,
                                        ),
                                      )),
                              ]),
                              Container(
                                color: Colors.grey[300],
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.only(top: 10),
                                width: MediaQuery.of(context).size.width,
                                child: Column(children: [
                                  Text(
                                    _items[index]["Name"],
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    _items[index]["Email"],
                                    style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ]),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                child: Column(children: [
                                  Text(
                                      '${_items[index]["region"]}${_items[index]["mobile"]}'),
                                  Text(_items[index]["zone"]),
                                ]),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.only(top: 10),
                                width: MediaQuery.of(context).size.width,
                                height: 10,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(50.0),
                                      bottomRight: Radius.circular(50.0)),
                                  color: Colors.red,
                                ),
                              )
                            ]),
                          ),
                        );
                      },
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
