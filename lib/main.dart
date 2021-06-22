import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'register.dart';
import 'globals.dart' as globals;
import 'base.dart' as base;


//similar spacing
//forgot password
//refactor buttons
//authenticate email and phone
//sliding screen - android and ios
//fix splash screen
//handle dynamic sizing
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
                  base.BaseBar(icon: globals.email, hint: globals.emailHint),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  base.BaseBar(icon: globals.pass, hint: globals.passHint),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  SizedBox( //fuck
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.blue.shade700,
                        backgroundColor: globals.textColor,
                        textStyle: TextStyle(fontSize: globals.chosenFontSize, fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(globals.radius/2)
                        )
                      ),
                      onPressed: () {},
                      child: const Text('LOGIN'),
                    ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    TextButton( //fuck
                      style: TextButton.styleFrom(
                        primary: globals.textColor,
                        backgroundColor: Colors.transparent,
                        textStyle: TextStyle(fontSize: globals.chosenFontSize * 0.75),
                      ),
                      onPressed: () {Navigator.push(context,MaterialPageRoute(builder : (context) => RegPage()));},
                      child: Text("Don't have an account? Register"),
                    ),
                    
                ],
              )
            ), 
        ),
    );
  }
}
