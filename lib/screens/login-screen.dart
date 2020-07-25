// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent_it/providers/auth-provider.dart';
import 'package:rent_it/screens/explore-screen.dart';
import 'package:rent_it/screens/home-screen.dart';
import 'package:rent_it/screens/user-details.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = 'login-screen';
  final numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Image.asset(
          'assets/images/flat-background.jpg',
          fit: BoxFit.cover,
          height: double.infinity,
          // color: Color.fromRGBO(0, 0, 0, 0.3),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            // height: 200,
            decoration: BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 0.6),
            ),
            alignment: Alignment.bottomCenter,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Let\'s start with your Mobile number',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      suffixIcon: FlatButton(
                        child: Icon(
                          Icons.chevron_right,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          // Future<bool> response = authProvider
                          //     .verifyPhoneNumber(numberController.text);
                          // bool status;
                          // await response.then((value) => status = value);
                          // if (status) {
                          //   Navigator.of(context)
                          //       .pushReplacementNamed(ExploreScreen.routeName);
                          // }
                          // Navigator.of(context)
                          //     .pushNamed(UserDetailsScreen.routeName);
                        },
                        color: Colors.redAccent,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Mobile Number',
                    ),
                    controller: numberController,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'OR',
                  style: TextStyle(color: Colors.white54, fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  child: Text(
                    'I\'ll signup later',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                    ),
                  ),
                  onTap: () {
                    // print('Text');
                    Navigator.of(context)
                        .pushReplacementNamed(HomeScreen.routeName);
                  },
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
