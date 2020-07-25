import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent_it/providers/auth-provider.dart';
import 'package:rent_it/providers/properties.dart';
import 'package:rent_it/providers/user-provider.dart';
import 'package:rent_it/screens/property-details-screen.dart';
import 'package:rent_it/screens/explore-screen.dart';
import 'package:rent_it/screens/login-screen.dart';
import 'package:rent_it/screens/profile-screen.dart';
import 'package:rent_it/screens/user-details.dart';
import './screens/home-screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => PropertyProvider()),
        ChangeNotifierProvider(create: (ctx) => AuthProvider()),
        ChangeNotifierProvider(create: (ctx) => UserProvider()),
      ],
      child: MaterialApp(
        home: HomeScreen(),
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.green,
          // primaryColor: Colors.purpleAccent,
        ),
        routes: {
          ExploreScreen.routeName: (ctx) => ExploreScreen(),
          LoginScreen.routeName: (ctx) => LoginScreen(),
          ProfileScreen.routeName: (ctx) => ProfileScreen(),
          PropertyDetailsScreen.routeName: (ctx) => PropertyDetailsScreen(),
          UserDetailsScreen.routeName: (ctx) => UserDetailsScreen(),
          HomeScreen.routeName: (ctx) => HomeScreen()
        },
      ),
    );
  }
}
