import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final String textBackground = "photos/trans.png";
final String background = "photos/bg.jpg";
final String logo = "photos/logo.png";
final String email = "photos/login_email.png";
final String pass = "photos/login_password.png";
final String emailHint = "Email Address";
final String passHint = "Password";
final double radius = 32;
final Color textColor = Colors.white;
final double chosenFontSize = 20;
final double allPadding = 20;
final double rightPadding = 10;
final double iconSize = 64;
final CollectionReference userCollection = FirebaseFirestore.instance.collection("Users");
final CollectionReference adminCollection = FirebaseFirestore.instance.collection("Admin");

GlobalKey<FormFieldState> roleKey = GlobalKey<FormFieldState>();
GlobalKey<FormFieldState> passKey = GlobalKey<FormFieldState>();
GlobalKey<FormFieldState> conPassKey = GlobalKey<FormFieldState>();
GlobalKey<FormFieldState> emailKey = GlobalKey<FormFieldState>();
GlobalKey<FormFieldState> fNameKey = GlobalKey<FormFieldState>();
GlobalKey<FormFieldState> lNameKey = GlobalKey<FormFieldState>();
GlobalKey<FormFieldState> phoneKey = GlobalKey<FormFieldState>();
GlobalKey<FormFieldState> passLoginKey = GlobalKey<FormFieldState>();
GlobalKey<FormFieldState> emailLoginKey = GlobalKey<FormFieldState>();
GlobalKey<FormFieldState> emailResetKey = GlobalKey<FormFieldState>();

final List<GlobalKey<FormFieldState>> loginKeys = [passLoginKey, emailLoginKey];

final List<GlobalKey<FormFieldState>> regKeys = [passKey, conPassKey, emailKey, fNameKey, lNameKey, roleKey, phoneKey];
final Map keyMap = {conPassKey : passKey};

