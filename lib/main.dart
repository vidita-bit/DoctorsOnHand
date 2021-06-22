import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'register.dart';
import 'globals.dart' as globals;
import 'base.dart' as base;


//forgot password
//authenticate email and phone
//sliding screen - android and ios
//fix splash screen
//handle dynamic sizing
//SQL injection
//drop down list doctor, patient, admin
//one line, bold "I am a"
//email and phone could be used 
//registration obscure text and make password and password
//registration email or phone number
//if both allow chosing authentication
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
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(globals.background),
            fit: BoxFit.cover,
          )
        ),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  base.BaseLogo(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                  base.BaseBar(icon: globals.email, hint: globals.emailHint, validate: () {}),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  base.BaseBar(icon: globals.pass, hint: globals.passHint, validate: () {}),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                  SizedBox( 
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: base.BaseButton(text: "LOGIN", primary: Colors.blue.shade700, secondary: globals.textColor, fontSize: globals.chosenFontSize, weight: FontWeight.bold, fxn: () {})
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  base.BaseButton(text: "Don't have an account? Register", primary: globals.textColor, secondary: Colors.transparent, fontSize: globals.chosenFontSize * 0.75, fxn: () {Navigator.push(context,MaterialPageRoute(builder : (context) => RegPage()));})
                ],
              )
            ), 
        ),
    );
  }
}
