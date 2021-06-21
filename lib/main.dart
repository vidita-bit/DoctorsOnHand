import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'register.dart';
import 'globals.dart' as globals;
import 'base.dart' as base;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await authenticate();
  runApp(MyApp());
}

Future<void> authenticate() async {
      UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
      print("done");  
  
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final double radius = 32;
  final Color textColor = Colors.white;
  final double chosenFontSize = 20;
  final double allPadding = 20;
  final double rightPadding = 10;
  final double iconSize = 56;
  final String textBackground = "photos/trans.png";
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    base.BaseContainer baseContainer = base.BaseContainer();
    return baseContainer;
    //  Container(
    //     decoration: BoxDecoration(
    //       image: DecorationImage(
    //         image: AssetImage(globals.background),
    //         fit: BoxFit.cover,
    //       )
    //     ),
    //     child: Scaffold(
    //         backgroundColor: Colors.transparent,
    //         body: Center(
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: <Widget>[
    //               SizedBox(height: MediaQuery.of(context).size.height * 0.1),
    //               Container(
    //                 height: MediaQuery.of(context).size.height * 0.1,
    //                 width: MediaQuery.of(context).size.width * 0.3,
    //                 decoration: BoxDecoration(
    //                   image: DecorationImage(
    //                     image: AssetImage(globals.logo),
    //                   ),
    //                 ),
    //               ),
    //               SizedBox(height: MediaQuery.of(context).size.height * 0.15),
    //               Container(
    //                 width: MediaQuery.of(context).size.width * 0.45,
    //                   decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(radius),
    //                     image: DecorationImage(
    //                               fit: BoxFit.cover,
    //                               image: AssetImage(textBackground),
    //                     ),
    //                   ),
    //                   child: TextField(
    //                           style: TextStyle(color: textColor, fontSize: chosenFontSize),
    //                           cursorColor: Colors.white,
    //                           decoration: InputDecoration(
    //                             hintText: "Email Address",
    //                             hintStyle: TextStyle(color: textColor, fontSize: chosenFontSize),
    //                             border: InputBorder.none,
    //                             isDense: true,
    //                             contentPadding: EdgeInsets.all(allPadding),
    //                             prefixIcon: Padding(
    //                                 padding:EdgeInsets.only(right: rightPadding), 
    //                                 child:Image(
    //                                 image: AssetImage("photos/login_email.png"),
    //                                 width: iconSize,
    //                                 height: iconSize,
    //                                 color: null,
    //                               )
    //                             )
    //                           )
    //                   ),
    //                 ),SizedBox(height: MediaQuery.of(context).size.height * 0.02),
    //                 Container(
    //                 width: MediaQuery.of(context).size.width * 0.45,
    //                   decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(radius),
    //                     image: DecorationImage(
    //                               fit: BoxFit.cover,
    //                               image: AssetImage(textBackground),
    //                     ),
    //                   ),
    //                   child: TextField(
    //                           style: TextStyle(color: textColor, fontSize: chosenFontSize),
    //                           cursorColor: Colors.white,
    //                           autocorrect: false,
    //                           enableSuggestions: false,
    //                           obscureText: true,
    //                           decoration: InputDecoration(
    //                             hintText: "Password",
    //                             hintStyle: TextStyle(color: textColor, fontSize: chosenFontSize),
    //                             border: InputBorder.none,
    //                             isDense: true,
    //                             contentPadding: EdgeInsets.all(allPadding),
    //                             prefixIcon: Padding(
    //                                 padding:EdgeInsets.only(right: rightPadding), 
    //                                 child:Image(
    //                                 image: AssetImage("photos/login_password.png"),
    //                                 width: iconSize,
    //                                 height: iconSize,
    //                                 color: null,
    //                               )
    //                             )
    //                           )
    //                   ),
    //                 ),
    //                 SizedBox(height: MediaQuery.of(context).size.height * 0.03),
    //                 SizedBox(
    //                   width: MediaQuery.of(context).size.width * 0.2,
    //                   height: MediaQuery.of(context).size.height * 0.1,
    //                   child: TextButton(
    //                     style: TextButton.styleFrom(
    //                       primary: Colors.blue.shade700,
    //                       backgroundColor: textColor,
    //                       textStyle: TextStyle(fontSize: chosenFontSize, fontWeight: FontWeight.bold),
    //                       shape: RoundedRectangleBorder(
    //                         borderRadius: BorderRadius.circular(radius/2)
    //                       )
    //                     ),
    //                     onPressed: () {},
    //                     child: const Text('LOGIN'),
    //                   ),
    //                   ),
    //                   SizedBox(height: MediaQuery.of(context).size.height * 0.03),
    //                   TextButton(
    //                     style: TextButton.styleFrom(
    //                       primary: textColor,
    //                       textStyle: TextStyle(fontSize: chosenFontSize * 0.75),
    //                     ),
    //                     onPressed: () {Navigator.push(context,MaterialPageRoute(builder : (context) => RegPage()));},
    //                     child: Text("Don't have an account? Register"),
    //                   ),
                    
    //             ],
    //           )
    //         ), 
    //     ),
    // );
  }
}
