import 'package:configurable_expansion_tile_null_safety/configurable_expansion_tile_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:tv_dashboard/Constants.dart';
import 'package:tv_dashboard/main.dart';
import 'package:tv_dashboard/utils.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String currentText = "Users";

  List<DataRow> rowList = [];

  @override
  void initState() {
    super.initState();
    print('initStateStarted');
    _fetchUsers();
    print('usersFetched');
  }

  void _fetchUsers() async {
    // final snapshot = await FirebaseDatabase.instance.ref('TvWebApp').get();

    databaseReference.onValue.listen((event) {
      rowList.clear();
      for (final child in event.snapshot.children) {
        final map = child.value as Map<dynamic, dynamic>;

        print(child.value);
        print(map['nmbr']);
        print(map['id']);

        final user = DataRow(cells: <DataCell>[
          DataCell(Center(child: Text(map['nmbr'].toString() ?? ''))),
          DataCell(Center(child: Text(map['id'].toString() ?? ''))),
          DataCell(
            InkWell(
              child: Center(
                  child: Icon(
                Icons.delete_outlined,
                color: Colors.red,
                size: 20,
              )),
              onTap: () {
                print(child.key ?? '');

                // databaseReference.push().set({"id": "newnew", "nmbr": 3});
                // databaseReference.child(child.key.toString()).remove();
                /*setState(() {
                  _fetchUsers();
                });*/
                // rowList.remove(map[key]);
              },
            ),
          ),
        ]);

        rowList.add(user);
      }
      setState(() {});
    }, onError: (error) {
      print(error);
    });

    /*final map = snapshot.value as Map<dynamic, dynamic>;

    map.forEach((key, value) {
      print(value.toString());
      print(value.length);

      // });
    });

    print(_currentList.length);
    print(rowList.length);

    setState(() {
      rowList.clear();
      rowList = _currentList;
      print(rowList.length);
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Overlay(
        initialEntries: [
          OverlayEntry(
            builder: (context) => Scaffold(
              backgroundColor: Colors.white,
              body: Row(
                children: [
                  sideBarOptions(),
                  Expanded(
                    flex: 6,
                    child: Container(
                      // scrollDirection: Axis.vertical,
                      // SingleScroll
                      color: Colors.grey.shade100,
                      child: Column(
                        children: [
                          topBar(context),
                          Padding(
                            padding: const EdgeInsets.only(top: 20, left: 30),
                            child: Align(
                              child: Text(
                                currentText,
                                style: TextStyle(fontSize: 25, color: Colors.black),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width),
                              child: DataTable(
                                  dataRowColor: MaterialStateProperty.all<Color>(Colors.grey.shade50),
                                  headingRowColor: MaterialStateProperty.all<Color>(Colors.white),
                                  headingRowHeight: 30,
                                  dataRowHeight: 30,
                                  columns: [
                                    DataColumn(
                                      label: columnText('No.'),
                                      numeric: true,
                                    ),
                                    DataColumn(
                                      label: columnText('Device IDs'),
                                    ),
                                    DataColumn(
                                      label: columnText('Actions'),
                                    ),
                                  ],
                                  rows: rowList),
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
        ],
      ),
    );
  }

  Expanded columnText(String text) {
    return Expanded(
      child: Center(
        child: Text(text, style: textStyleBold(), textAlign: TextAlign.center),
      ),
    );
  }

  Padding topBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
      child: Container(
        // color: Colors.white,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Welcome Admin',
                style: textStyleBold(),
              ),
              TextButton(
                  child: Text(
                    'logout',
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MyApp(),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Expanded sideBarOptions() {
    return Expanded(
      flex: 1,
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Column(
            children: [
              //DASHBOARD
              Text(
                'Dashboard',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    decoration: TextDecoration.none),
              ),
              SizedBox(
                height: 40,
              ),
              //USERS
              Padding(
                padding: const EdgeInsets.only(left: 8, bottom: 5),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      currentText = 'Users';
                    });
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.person_outline,
                        color: Colors.black45,
                        size: 15,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Users',
                        style: currentText == 'Users' ? textStyleBold() : textStyleNormal(),
                      ),
                    ],
                  ),
                ),
              ),
              //TOKENS
              GestureDetector(
                onTap: () {
                  setState(() {
                    currentText = 'Tokens';
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Row(
                    children: [
                      Icon(
                        Icons.note_alt_outlined,
                        color: Colors.black45,
                        size: 15,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Tokens',
                          style: currentText == 'Tokens' ? textStyleBold() : textStyleNormal()),
                    ],
                  ),
                ),
              ),
              //CHANNELS
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: ConfigurableExpansionTile(
                  animatedWidgetFollowingHeader: Icon(
                    Icons.expand_more,
                    color: Color(0xFF707070),
                  ),
                  header: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.videocam_outlined,
                        color: Colors.black45,
                        size: 15,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Channels',
                        style: currentText == 'Channels' ? textStyleBold() : textStyleNormal(),
                      ),
                    ],
                  ),
                  childrenBody: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            currentText = 'View All Channels';
                          });
                        },
                        child: Row(
                          children: [
                            SizedBox.square(
                              dimension: 15,
                            ),
                            Text(
                              'View All Channels',
                              style: currentText == 'View All Channels'
                                  ? textStyleBold()
                                  : textStyleNormal(),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            currentText = 'Channel Countries';
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              SizedBox.square(
                                dimension: 15,
                              ),
                              Text(
                                'Channel Countries',
                                style: currentText == 'Channel Countries'
                                    ? textStyleBold()
                                    : textStyleNormal(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            currentText = 'Channel Categories';
                          });
                        },
                        child: Row(
                          children: [
                            SizedBox.square(
                              dimension: 15,
                            ),
                            Text(
                              'Channel Categories',
                              style: currentText == 'Channel Categories'
                                  ? textStyleBold()
                                  : textStyleNormal(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // EVENTS
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: ConfigurableExpansionTile(
                  animatedWidgetFollowingHeader: Icon(
                    Icons.expand_more,
                    color: Color(0xFF707070),
                  ),
                  header: Row(
                    children: [
                      Icon(
                        Icons.event,
                        color: Colors.black45,
                        size: 15,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Events',
                        style: currentText == 'Events' ? textStyleBold() : textStyleNormal(),
                      ),
                    ],
                  ),
                  childrenBody: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            currentText = 'View All Events';
                          });
                        },
                        child: Row(
                          children: [
                            SizedBox.square(
                              dimension: 15,
                            ),
                            Text(
                              'View All Events',
                              style:
                                  currentText == 'View All Events' ? textStyleBold() : textStyleNormal(),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            currentText = 'Events Countries';
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              SizedBox.square(
                                dimension: 15,
                              ),
                              Text(
                                'Events Countries',
                                style: currentText == 'Events Countries'
                                    ? textStyleBold()
                                    : textStyleNormal(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            currentText = 'Events Categories';
                          });
                        },
                        child: Row(
                          children: [
                            SizedBox.square(
                              dimension: 15,
                            ),
                            Text(
                              'Events Categories',
                              style: currentText == 'Events Categories'
                                  ? textStyleBold()
                                  : textStyleNormal(),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              //SCRAPING
              GestureDetector(
                onTap: () {
                  setState(() {
                    currentText = 'Scraping';
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.black45,
                        size: 15,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Scraping',
                          style: currentText == 'Scraping' ? textStyleBold() : textStyleNormal()),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
