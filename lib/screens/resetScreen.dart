import 'package:flutter/material.dart';
import '../globals.dart' as globals;
import '../base.dart';
import '../main.dart';

class ResetScreen extends StatelessWidget {
  const ResetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: new LinearGradient(
            colors: [
              Colors.blue.shade700,
              Colors.white,
              Colors.blue.shade700,
              Colors.white,
              Colors.blue.shade700,
            ],
          ),
        ),
        child: Center(
          child: IntrinsicWidth(
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.shade700.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            selectedTileColor: Colors.black,
                            title: Text(
                              "A reset link will be sent to your email if it is registered!",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: BaseButton(
                            text: "LOGIN (after you reset the password)",
                            primary: Colors.blue.shade700,
                            secondary: globals.textColor,
                            fontSize: MediaQuery.of(context).size.width * 0.006,
                            weight: FontWeight.bold,
                            fxn: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => LoginPage(),
                                ),
                                (route) => false,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
