import 'package:flutter/material.dart';
import 'package:flutter_terminchi/constants/data.dart';
import 'package:flutter_terminchi/constants/router.dart';
import 'package:flutter_terminchi/models/data_model.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //sort data

  List<Map<String, dynamic>> _foundData = [];
  @override
  void initState() {
    super.initState();
    _foundData = data;
  }

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      results = data;
    } else {
      results = data
          .where((word) => word['title']
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundData = results;
    });
  }



  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _foundData.sort((a, b) => a['title'].compareTo(b['title']));
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        drawer: Drawer(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  child: Text(
                    'Terminchi',
                  ),
                ),
                ListTile(
                  title: const Text(
                    'Bosh sahifa',
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text(
                    'Biz haqimizda',
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.about);
                  },
                ),
                SizedBox(height: size.height * 0.5),
                Text("v1.0.0",
                    style: TextStyle(color: Colors.black.withOpacity(.5)),
                    textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Terminchi',
            style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5),
          ),
        ),
        body: Column(
          children: [
            //search bar
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
              child: TextField(
                controller: searchController,
                onChanged: (value) => _runFilter(value),
                decoration: const InputDecoration(
                  hintText: "Izlash...",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black12),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
            //list of words
            Expanded(
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: _foundData.length,
                  itemBuilder: (context, index) {
                    return ZoomTapAnimation(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RouteName.details,
                          arguments: DataModel(
                              id: _foundData[index]['id'],
                              title: _foundData[index]['title'],
                              description: _foundData[index]['description']
                          ),
                        );
                      },
                      child: Padding(
                        key: ValueKey(_foundData[index]['id']),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x0f000000),
                                offset: Offset(0, 2),
                                blurRadius: 15.0,
                              ),
                            ],
                          ),
                          child: ListTile(
                            title: Text(
                              _foundData[index]['title'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              _foundData[index]['description'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
