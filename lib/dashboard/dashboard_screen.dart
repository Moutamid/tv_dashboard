import 'package:configurable_expansion_tile_null_safety/configurable_expansion_tile_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tv_dashboard/Constants.dart';
import 'package:tv_dashboard/dashboard/AddTokenFormScreen.dart';
import 'package:tv_dashboard/main.dart';
import 'package:tv_dashboard/utils.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final addTokenFormScreenKey = GlobalKey<_AddTokenFormScreenState>();

  String currentText = TEXT_USERS;

  bool isLoading = true;

  List<DataRow> rowList = [];
  List<DataColumn> columnList = [];
  int number = 0;

  bool isAddButtonVisible = false;
  String addButtonText = 'null';

  String current_token_id = '';
  String current_token_url = '';
  String current_token_push_key = '';

  @override
  void initState() {
    super.initState();
    print('initStateStarted');
    _fetchUsers();
    print('usersFetched');
  }

  void _fetchUsers() async {
    // final snapshot = await FirebaseDatabase.instance.ref('TvWebApp').get();
    isLoading = true;
    columnList.clear();
    currentText = TEXT_USERS;

    isAddButtonVisible = false;

    columnList.add(DataColumn(label: columnText('No.')));
    columnList.add(DataColumn(label: columnText('Device IDs')));
    columnList.add(DataColumn(label: columnText('Actions')));

    databaseReference.child(CHILD_USERS).onValue.listen((event) {
      if (currentText != TEXT_USERS) return;

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
                databaseReference.child(CHILD_USERS).child(child.key.toString()).remove();
              },
            ),
          ),
        ]);

        rowList.add(user);
      }
      setState(() {
        isLoading = false;
      });
    }, onError: (error) {
      print(error);
    });
  }

  void _fetchTokens() async {
    // final snapshot = await FirebaseDatabase.instance.ref('TvWebApp').get();
    isLoading = true;
    columnList.clear();
    currentText = TEXT_TOKENS;

    addButtonText = TEXT_ADD_TOKENS;
    isAddButtonVisible = true;

    columnList.add(DataColumn(label: columnText('ID')));
    columnList.add(DataColumn(label: columnText('Urls')));
    columnList.add(DataColumn(label: columnText('Actions')));

    databaseReference.child(CHILD_TOKENS).onValue.listen((event) {
      if (currentText != TEXT_TOKENS) return;

      rowList.clear();
      for (final child in event.snapshot.children) {
        final map = child.value as Map<dynamic, dynamic>;

        print(child.value);
        print(map['id']);
        print(map['url']);

        final user = DataRow(cells: <DataCell>[
          DataCell(Center(child: Text(map['id'].toString() ?? ''))),
          DataCell(Center(child: Text(map['url'].toString() ?? ''))),
          DataCell(
            Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  child: Icon(
                    Icons.edit_outlined,
                    color: Colors.blue,
                    size: 20,
                  ),
                  onTap: () {
                    print(child.key ?? '');
                    isAddButtonVisible = false;
                    current_token_id = map['id'].toString();
                    current_token_url = map['url'].toString();
                    current_token_push_key = child.key.toString();
                    setState(() {
                      currentText = addButtonText;
                    });
                    /* number++;
                    databaseReference.child(CHILD_CHANNELS).push().set({
                      "id": number,
                      "name": "Name $number",
                      "category": "Category $number",
                      "country": "Country $number",
                      "isHidden": false,
                      "image_url": "https://url$number.com",
                      "streaming_link": "data $number",
                    });*/
                    // databaseReference.child(child.key.toString()).remove();
                    /*setState(() {
                  _fetchUsers();
                });*/
                    // rowList.remove(map[key]);
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  child: Icon(
                    Icons.delete_outlined,
                    color: Colors.red,
                    size: 20,
                  ),
                  onTap: () {
                    print(child.key ?? '');
                    // number++;
                    // databaseReference.child(CHILD_TOKENS)
                    //     .push().set({"id": number, "url": "https://tokenurl$number.com/token.php"});
                    databaseReference.child(CHILD_TOKENS).child(child.key.toString()).remove();
                    /*setState(() {
                  _fetchUsers();
                });*/
                    // rowList.remove(map[key]);
                  },
                ),
              ],
            )),
          ),
        ]);

        rowList.add(user);
      }
      setState(() {
        isLoading = false;
      });
    }, onError: (error) {
      print(error);
    });
  }

  void _fetchChannels() async {
    // final snapshot = await FirebaseDatabase.instance.ref('TvWebApp').get();
    isLoading = true;
    columnList.clear();
    currentText = TEXT_VIEW_ALL_CHANNELS;

    addButtonText = TEXT_ADD_CHANNELS;
    isAddButtonVisible = true;

    columnList.add(DataColumn(label: columnText('ID')));
    columnList.add(DataColumn(label: columnText('Name')));
    columnList.add(DataColumn(label: columnText('Category')));
    columnList.add(DataColumn(label: columnText('Country')));
    columnList.add(DataColumn(label: columnText('Hidden')));
    columnList.add(DataColumn(label: columnText('Image')));
    columnList.add(DataColumn(label: columnText('Streaming Links')));
    columnList.add(DataColumn(label: columnText('Actions')));

    databaseReference.child(CHILD_CHANNELS).onValue.listen((event) {
      if (currentText != TEXT_VIEW_ALL_CHANNELS) return;

      rowList.clear();
      for (final child in event.snapshot.children) {
        final map = child.value as Map<dynamic, dynamic>;

        print(child.value);
        print(map['id']);
        print(map['name']);
        print(map['category']);
        print(map['country']);
        print(map['isHidden']);
        print(map['image_url']);
        print(map['streaming_link']);

        //"id": number,
        //                       "name": "Name $number",
        //                       "category": "Category $number",
        //                       "country": "Country $number",
        //                       "isHidden": false,
        //                       "image_url": "https://url$number.com",
        //                       "streaming_link": "data $number",

        final user = DataRow(cells: <DataCell>[
          DataCell(Center(child: Text(map['id'].toString() ?? ''))),
          DataCell(Center(child: Text(map['name'].toString() ?? ''))),
          DataCell(Center(child: Text(map['category'].toString() ?? ''))),
          DataCell(Center(child: Text(map['country'].toString() ?? ''))),
          DataCell(Center(child: Text(map['isHidden'].toString() ?? ''))),
          DataCell(Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Image.network(
              'https://picsum.photos/250?image=9', //map['image_url'].toString() ?? '',
              width: 70,
              height: 70,
            ),
          ))),
          DataCell(
            Center(
                child: InkWell(
              child: Icon(
                Icons.remove_red_eye_outlined,
                color: Colors.green,
                size: 20,
              ),
              onTap: () {
                print(map['streaming_link'].toString() ?? '');
                // number++;
                // databaseReference.child(CHILD_TOKENS)
                //     .push().set({"id": number, "url": "https://tokenurl$number.com/token.php"});
                // databaseReference.child(child.key.toString()).remove();
                /*setState(() {
                  _fetchUsers();
                });*/
                // rowList.remove(map[key]);
              },
            )),
          ),
          DataCell(
            Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  child: Icon(
                    Icons.edit_outlined,
                    color: Colors.blue,
                    size: 20,
                  ),
                  onTap: () {
                    print(child.key ?? '');
                    // number++;
                    // databaseReference.child(CHILD_TOKENS)
                    //     .push().set({"id": number, "url": "https://tokenurl$number.com/token.php"});
                    // databaseReference.child(child.key.toString()).remove();
                    /*setState(() {
                  _fetchUsers();
                });*/
                    // rowList.remove(map[key]);
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  child: Icon(
                    Icons.delete_outlined,
                    color: Colors.red,
                    size: 20,
                  ),
                  onTap: () {
                    print(child.key ?? '');
                    // number++;
                    // databaseReference.child(CHILD_TOKENS)
                    //     .push().set({"id": number, "url": "https://tokenurl$number.com/token.php"});
                    // databaseReference.child(child.key.toString()).remove();
                    /*setState(() {
                  _fetchUsers();
                });*/
                    // rowList.remove(map[key]);
                  },
                ),
              ],
            )),
          ),
        ]);

        rowList.add(user);
      }
      setState(() {
        isLoading = false;
      });
    }, onError: (error) {
      print(error);
    });
  }

  void _fetchEvents() async {
    // final snapshot = await FirebaseDatabase.instance.ref('TvWebApp').get();
    isLoading = true;
    columnList.clear();
    currentText = TEXT_VIEW_ALL_EVENTS;

    addButtonText = TEXT_ADD_EVENTS;
    isAddButtonVisible = true;

    columnList.add(DataColumn(label: columnText('ID')));
    columnList.add(DataColumn(label: columnText('Name')));
    columnList.add(DataColumn(label: columnText('Category')));
    columnList.add(DataColumn(label: columnText('Country')));
    columnList.add(DataColumn(label: columnText('Hidden')));
    columnList.add(DataColumn(label: columnText('Image')));
    columnList.add(DataColumn(label: columnText('Streaming Links')));
    columnList.add(DataColumn(label: columnText('Actions')));

    databaseReference.child(CHILD_EVENTS).onValue.listen((event) {
      if (currentText != TEXT_VIEW_ALL_EVENTS) return;

      rowList.clear();
      for (final child in event.snapshot.children) {
        final map = child.value as Map<dynamic, dynamic>;

        print(child.value);
        print(map['id']);
        print(map['name']);
        print(map['category']);
        print(map['country']);
        print(map['isHidden']);
        print(map['image_url']);
        print(map['streaming_link']);

        //"id": number,
        //                       "name": "Name $number",
        //                       "category": "Category $number",
        //                       "country": "Country $number",
        //                       "isHidden": false,
        //                       "image_url": "https://url$number.com",
        //                       "streaming_link": "data $number",

        final user = DataRow(cells: <DataCell>[
          DataCell(Center(child: Text(map['id'].toString() ?? ''))),
          DataCell(Center(child: Text(map['name'].toString() ?? ''))),
          DataCell(Center(child: Text(map['category'].toString() ?? ''))),
          DataCell(Center(child: Text(map['country'].toString() ?? ''))),
          DataCell(Center(child: Text(map['isHidden'].toString() ?? ''))),
          DataCell(Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Image.network(
              'https://picsum.photos/250?image=9', //map['image_url'].toString() ?? '',
              width: 70,
              height: 70,
            ),
          ))),
          DataCell(
            Center(
                child: InkWell(
              child: Icon(
                Icons.remove_red_eye_outlined,
                color: Colors.green,
                size: 20,
              ),
              onTap: () {
                print(map['streaming_link'].toString() ?? '');
                // number++;
                // databaseReference.child(CHILD_TOKENS)
                //     .push().set({"id": number, "url": "https://tokenurl$number.com/token.php"});
                // databaseReference.child(child.key.toString()).remove();
                /*setState(() {
                  _fetchUsers();
                });*/
                // rowList.remove(map[key]);
              },
            )),
          ),
          DataCell(
            Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  child: Icon(
                    Icons.edit_outlined,
                    color: Colors.blue,
                    size: 20,
                  ),
                  onTap: () {
                    print(child.key ?? '');
                    // number++;
                    // databaseReference.child(CHILD_TOKENS)
                    //     .push().set({"id": number, "url": "https://tokenurl$number.com/token.php"});
                    // databaseReference.child(child.key.toString()).remove();
                    /*setState(() {
                  _fetchUsers();
                });*/
                    // rowList.remove(map[key]);
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  child: Icon(
                    Icons.delete_outlined,
                    color: Colors.red,
                    size: 20,
                  ),
                  onTap: () {
                    print(child.key ?? '');
                    // number++;
                    // databaseReference.child(CHILD_TOKENS)
                    //     .push().set({"id": number, "url": "https://tokenurl$number.com/token.php"});
                    // databaseReference.child(child.key.toString()).remove();
                    /*setState(() {
                  _fetchUsers();
                });*/
                    // rowList.remove(map[key]);
                  },
                ),
              ],
            )),
          ),
        ]);

        rowList.add(user);
      }
      setState(() {
        isLoading = false;
      });
    }, onError: (error) {
      print(error);
    });
  }

  void _fetchChannelCountries() async {
    // final snapshot = await FirebaseDatabase.instance.ref('TvWebApp').get();
    isLoading = true;
    columnList.clear();
    currentText = TEXT_CHANNEL_COUNTRIES;

    isAddButtonVisible = false;

    columnList.add(DataColumn(label: columnText('ID')));
    columnList.add(DataColumn(label: columnText('Name')));
    columnList.add(DataColumn(label: columnText('Actions')));

    databaseReference.child(CHILD_CHANNEL_COUNTRIES).onValue.listen((event) {
      if (currentText != TEXT_CHANNEL_COUNTRIES) return;

      rowList.clear();
      for (final child in event.snapshot.children) {
        final map = child.value as Map<dynamic, dynamic>;

        print(child.value);
        print(map['id']);
        print(map['name']);

        final user = DataRow(cells: <DataCell>[
          DataCell(Center(child: Text(map['id'].toString() ?? ''))),
          DataCell(Center(child: Text(map['name'].toString() ?? ''))),
          DataCell(
            InkWell(
              child: Center(
                  child: Icon(
                Icons.edit_outlined,
                color: Colors.blue,
                size: 20,
              )),
              onTap: () {
                print(child.key ?? '');
                // number++;
                // databaseReference
                //     .child(CHILD_TOKENS)
                //     .push()
                //     .set({"id": number, "url": "https://tokenurl$number.com/token.php"});
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
      setState(() {
        isLoading = false;
      });
    }, onError: (error) {
      print(error);
    });
  }

  void _fetchChannelCategories() async {
    // final snapshot = await FirebaseDatabase.instance.ref('TvWebApp').get();
    isLoading = true;
    columnList.clear();
    currentText = TEXT_CHANNEL_CATEGORIES;

    isAddButtonVisible = false;

    columnList.add(DataColumn(label: columnText('ID')));
    columnList.add(DataColumn(label: columnText('Name')));
    columnList.add(DataColumn(label: columnText('Actions')));

    databaseReference.child(CHILD_CHANNEL_CATEGORIES).onValue.listen((event) {
      if (currentText != TEXT_CHANNEL_CATEGORIES) return;

      rowList.clear();
      for (final child in event.snapshot.children) {
        final map = child.value as Map<dynamic, dynamic>;

        print(child.value);
        print(map['id']);
        print(map['name']);

        final user = DataRow(cells: <DataCell>[
          DataCell(Center(child: Text(map['id'].toString() ?? ''))),
          DataCell(Center(child: Text(map['name'].toString() ?? ''))),
          DataCell(
            InkWell(
              child: Center(
                  child: Icon(
                Icons.edit_outlined,
                color: Colors.blue,
                size: 20,
              )),
              onTap: () {
                print(child.key ?? '');
                // number++;
                // databaseReference
                //     .child(CHILD_TOKENS)
                //     .push()
                //     .set({"id": number, "url": "https://tokenurl$number.com/token.php"});
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
      setState(() {
        isLoading = false;
      });
    }, onError: (error) {
      print(error);
    });
  }

  void _fetchEventCountries() async {
    // final snapshot = await FirebaseDatabase.instance.ref('TvWebApp').get();
    isLoading = true;
    columnList.clear();
    currentText = TEXT_EVENT_COUNTRIES;

    isAddButtonVisible = false;

    columnList.add(DataColumn(label: columnText('ID')));
    columnList.add(DataColumn(label: columnText('Name')));
    columnList.add(DataColumn(label: columnText('Actions')));

    databaseReference.child(CHILD_EVENT_COUNTRIES).onValue.listen((event) {
      if (currentText != TEXT_EVENT_COUNTRIES) return;

      rowList.clear();
      for (final child in event.snapshot.children) {
        final map = child.value as Map<dynamic, dynamic>;

        print(child.value);
        print(map['id']);
        print(map['name']);

        final user = DataRow(cells: <DataCell>[
          DataCell(Center(child: Text(map['id'].toString() ?? ''))),
          DataCell(Center(child: Text(map['name'].toString() ?? ''))),
          DataCell(
            InkWell(
              child: Center(
                  child: Icon(
                Icons.edit_outlined,
                color: Colors.blue,
                size: 20,
              )),
              onTap: () {
                print(child.key ?? '');
                // number++;
                // databaseReference
                //     .child(CHILD_TOKENS)
                //     .push()
                //     .set({"id": number, "url": "https://tokenurl$number.com/token.php"});
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
      setState(() {
        isLoading = false;
      });
    }, onError: (error) {
      print(error);
    });
  }

  void _fetchEventCategories() async {
    // final snapshot = await FirebaseDatabase.instance.ref('TvWebApp').get();
    isLoading = true;
    columnList.clear();
    currentText = TEXT_EVENT_CATEGORIES;

    isAddButtonVisible = false;

    columnList.add(DataColumn(label: columnText('ID')));
    columnList.add(DataColumn(label: columnText('Name')));
    columnList.add(DataColumn(label: columnText('Actions')));

    databaseReference.child(CHILD_EVENT_CATEGORIES).onValue.listen((event) {
      if (currentText != TEXT_EVENT_CATEGORIES) return;

      rowList.clear();
      for (final child in event.snapshot.children) {
        final map = child.value as Map<dynamic, dynamic>;

        print(child.value);
        print(map['id']);
        print(map['name']);

        final user = DataRow(cells: <DataCell>[
          DataCell(Center(child: Text(map['id'].toString() ?? ''))),
          DataCell(Center(child: Text(map['name'].toString() ?? ''))),
          DataCell(
            InkWell(
              child: Center(
                  child: Icon(
                Icons.edit_outlined,
                color: Colors.blue,
                size: 20,
              )),
              onTap: () {
                print(child.key ?? '');
                // number++;
                // databaseReference
                //     .child(CHILD_TOKENS)
                //     .push()
                //     .set({"id": number, "url": "https://tokenurl$number.com/token.php"});
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
      setState(() {
        isLoading = false;
      });
    }, onError: (error) {
      print(error);
    });
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
                          currentTextOfBar(),
                          isLoading
                              ? CircularProgressIndicator()
                              : (currentText == TEXT_ADD_TOKENS ||
                                      currentText == TEXT_ADD_CHANNELS ||
                                      currentText == TEXT_ADD_EVENTS)
                                  ? Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Column(
                                          children: [
                                            if (currentText == TEXT_ADD_TOKENS)
                                              AddTokenFormScreen(
                                                  key: addTokenFormScreenKey,
                                                  current_token_id: current_token_id,
                                                  current_token_url: current_token_url,
                                                  current_token_push_key: current_token_push_key,
                                                  currentText: currentText,
                                                  isAddButtonVisible: isAddButtonVisible),
                                            if (currentText == TEXT_ADD_CHANNELS) addChannelForm(),
                                            if (currentText == TEXT_ADD_EVENTS) addChannelForm(),
                                          ],
                                        ),
                                      ),
                                    )
                                  // DATA CELLS
                                  : Expanded(
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: ConstrainedBox(
                                            constraints: BoxConstraints(
                                                minWidth: MediaQuery.of(context).size.width),
                                            child: DataTable(
                                                dataRowColor:
                                                    MaterialStateProperty.all<Color>(Colors.grey.shade50),
                                                headingRowColor:
                                                    MaterialStateProperty.all<Color>(Colors.white),
                                                headingRowHeight: 30,
                                                // dataRowHeight: 30,
                                                columns: columnList,
                                                rows: rowList),
                                          ),
                                        ),
                                      ),
                                    )
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

  Column addChannelForm() {
    final TextEditingController _controllerChannelName = TextEditingController();

    return Column(
      children: [
        FormTextField('Channel name', _controllerChannelName),
        SizedBox(
          height: 40,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: OutlinedButton(
            onPressed: () {
              String data = _controllerChannelName.text;
              print('URl: $data');
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            child: Text(
              'Add',
              style: TextStyle(color: Colors.blue, fontSize: 12, decoration: TextDecoration.none),
            ),
          ),
        )
      ],
    );
  }

  Padding currentTextOfBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            child: Text(
              currentText,
              style: TextStyle(fontSize: 25, color: Colors.black),
            ),
            alignment: Alignment.centerLeft,
          ),
          if (isAddButtonVisible)
            OutlinedButton(
              onPressed: () {
                setState(() {
                  isAddButtonVisible = false;
                  currentText = addButtonText;
                  if (currentText == TEXT_ADD_TOKENS) {
                    current_token_id = '';
                    current_token_url = '';
                    current_token_push_key = '';
                  }
                });
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              child: Text(
                addButtonText,
                style: TextStyle(color: Colors.blue, fontSize: 12, decoration: TextDecoration.none),
              ),
            )
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

  Container sideBarOptions() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //DASHBOARD
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Dashboard',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    decoration: TextDecoration.none),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            //USERS
            Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 5),
              child: InkWell(
                onTap: () {
                  setState(() {
                    _fetchUsers();
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
                      TEXT_USERS,
                      style: currentText == TEXT_USERS ? textStyleBold() : textStyleNormal(),
                    ),
                  ],
                ),
              ),
            ),
            //TOKENS
            InkWell(
              onTap: () {
                setState(() {
                  _fetchTokens();
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
                    Text(TEXT_TOKENS,
                        style: currentText == TEXT_TOKENS ? textStyleBold() : textStyleNormal()),
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
                      TEXT_CHANNELS,
                      style: currentText == TEXT_CHANNELS ? textStyleBold() : textStyleNormal(),
                    ),
                  ],
                ),
                childrenBody: Column(
                  children: [
                    InkWell(
                      child: Row(
                        children: [
                          SizedBox.square(
                            dimension: 15,
                          ),
                          Text(
                            TEXT_VIEW_ALL_CHANNELS,
                            style: currentText == TEXT_VIEW_ALL_CHANNELS
                                ? textStyleBold()
                                : textStyleNormal(),
                          ),
                        ],
                      ),
                      onTap: () {
                        setState(() {
                          _fetchChannels();
                        });
                      },
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _fetchChannelCountries();
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
                              TEXT_CHANNEL_COUNTRIES,
                              style: currentText == TEXT_CHANNEL_COUNTRIES
                                  ? textStyleBold()
                                  : textStyleNormal(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _fetchChannelCategories();
                        });
                      },
                      child: Row(
                        children: [
                          SizedBox.square(
                            dimension: 15,
                          ),
                          Text(
                            TEXT_CHANNEL_CATEGORIES,
                            style: currentText == TEXT_CHANNEL_CATEGORIES
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
                      TEXT_EVENTS,
                      style: currentText == TEXT_EVENTS ? textStyleBold() : textStyleNormal(),
                    ),
                  ],
                ),
                childrenBody: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          _fetchEvents();
                        });
                      },
                      child: Row(
                        children: [
                          SizedBox.square(
                            dimension: 15,
                          ),
                          Text(
                            TEXT_VIEW_ALL_EVENTS,
                            style:
                                currentText == TEXT_VIEW_ALL_EVENTS ? textStyleBold() : textStyleNormal(),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _fetchEventCountries();
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
                              TEXT_EVENT_COUNTRIES,
                              style: currentText == TEXT_EVENT_COUNTRIES
                                  ? textStyleBold()
                                  : textStyleNormal(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _fetchEventCategories();
                        });
                      },
                      child: Row(
                        children: [
                          SizedBox.square(
                            dimension: 15,
                          ),
                          Text(
                            TEXT_EVENT_CATEGORIES,
                            style: currentText == TEXT_EVENT_CATEGORIES
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
            InkWell(
              onTap: () {
                setState(() {
                  currentText = TEXT_SCRAPING;

                  isAddButtonVisible = false;
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
                    Text(TEXT_SCRAPING,
                        style: currentText == TEXT_SCRAPING ? textStyleBold() : textStyleNormal()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
