import 'package:flutter/material.dart';
import 'package:rent_it/screens/login-screen.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = 'profile-screen';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final user = null;

  @override
  Widget build(BuildContext context) {
    if (user == null)
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
      });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}
