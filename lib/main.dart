import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tv_dashboard/Constants.dart';
import 'package:tv_dashboard/dashboard_screen.dart';
import 'package:tv_dashboard/utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyBku9zNVC3UY9bLZQBUbTDZQCQ13_H_aBQ',
          appId: '1:890062472575:web:460336de0a8e4cc104464a',
          messagingSenderId: '890062472575',
          projectId: 'sweet-nutrition',
          databaseURL: 'https://sweet-nutrition-default-rtdb.firebaseio.com'));

  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // var email = prefs.getString('email');
  // print(email);
  // runApp(email == null ? MyApp() : DashboardScreen());

  // runApp(MyApp());
  runApp(DashboardScreen());
}

/*
class MyAppp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}
*/
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String emailStr = 'null';
  String passwordStr = 'null';

  bool isEmailCorrect = true;
  bool isPasswordCorrect = true;

  bool hidePassword = true;

  SharedPreferences? _prefs;
  bool isLoggedIn = false;

  /*@override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) {
      setState(() {
        this._prefs = value;
      });

      if (_prefs?.getBool('login') ?? false)
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DashboardScreen(),
          ),
        );
    });
  }*/

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
                  Expanded(
                    flex: 6,
                    child: Container(
                      height: 250,
                      width: 250,
                      child: Image.asset("login.png"),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'TvChannel Login',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              decoration: TextDecoration.none),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                          child: TextField(
                            onChanged: (text) {
                              emailStr = text.characters.toString();

                              if (text == 'Admin123@gmail.com')
                                setState(() {
                                  isEmailCorrect = true;
                                });
                              else
                                setState(() {
                                  isEmailCorrect = false;
                                });
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: Colors.black45,
                                size: 15,
                              ),
                              hintText: 'Email',
                              errorText: isEmailCorrect ? null : 'Email is wrong!',
                              hintStyle: TextStyle(color: Colors.grey.shade500),
                              fillColor: Colors.grey.shade200,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: TextField(
                            obscureText: hidePassword,
                            onChanged: (text) {
                              passwordStr = text.characters.toString();

                              if (text == 'Admin123')
                                setState(() {
                                  isPasswordCorrect = true;
                                });
                              else
                                setState(() {
                                  isPasswordCorrect = false;
                                });
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.lock_outlined,
                                color: Colors.black45,
                                size: 15,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  hidePassword ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
                                  color: Colors.black45,
                                  size: 15,
                                ),
                                onPressed: () {
                                  setState(() {
                                    hidePassword = !hidePassword;
                                  });
                                },
                              ),
                              hintText: 'Password',
                              errorText: isPasswordCorrect ? null : 'Password is wrong!',
                              hintStyle: TextStyle(color: Colors.grey.shade500),
                              fillColor: Colors.grey.shade200,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            )),
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.all(20),
                            ),
                          ),
                          onPressed: () async {
                            /*if (emailStr != 'Admin123@gmail.com') {
                              showToast(context, Colors.red, 'Email is wrong');
                              return;
                            }
                            if (passwordStr != 'Admin123') {
                              showToast(context, Colors.red, 'Password is wrong');
                              return;
                            }*/

                            // setLoginStatusToTrue();

                            showToast(context, Colors.green, 'Success!');

                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setString('email', emailStr);
                            // Navigator.pushReplacement(context,
                            //     MaterialPageRoute(builder: (BuildContext ctx) => DashboardScreen()));
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DashboardScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Login',
                            style: textStyleBold(),
                          ),
                        ),
                      ],
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

  Future<void> setLoginStatusToTrue() async {
    await _prefs?.setBool('login', true);
  }
}
