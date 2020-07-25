import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent_it/providers/auth-provider.dart';
import 'package:rent_it/screens/profile-screen.dart';
import 'package:rent_it/widgets/drawer-button.dart';

class MainDrawerWidget extends StatefulWidget {
  final BuildContext context;
  MainDrawerWidget({this.context});
  @override
  _MainDrawerWidgetState createState() => _MainDrawerWidgetState(context);
}

class _MainDrawerWidgetState extends State<MainDrawerWidget> {
  FirebaseUser user;

  _MainDrawerWidgetState(BuildContext context) {
    Provider.of<AuthProvider>(context).getCurrentUser.then((value) {
      print('Test inside future');
      setState(() {
        user = value;
      });
    });
    print('Test outside Future');
  }

  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: DrawerHeader(
              decoration: BoxDecoration(),
              child: ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed(ProfileScreen.routeName);
                },
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: user == null || user.photoUrl == null
                      ? Image.asset('assets/images/user.jpg')
                      : Image.network(user.photoUrl),
                ),
                title: Text(
                  'Hi ${user == null ? 'Guesft' : user.email}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                trailing: Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          DrawerButtonWidget(
            icon: Icons.account_balance_wallet,
            title: 'All Wallets',
            onTapFunction: () {},
          ),
          DrawerButtonWidget(
            icon: Icons.person_add,
            title: 'Invite and Earn',
            onTapFunction: () {},
          ),
          DrawerButtonWidget(
            icon: Icons.help,
            title: 'Need Help?',
            onTapFunction: () {},
          ),
          DrawerButtonWidget(
            icon: Icons.assignment,
            title: 'List your property',
            onTapFunction: () {},
          ),
          DrawerButtonWidget(
            icon: Icons.security,
            title: 'Privary Policy',
            onTapFunction: () {},
          ),
          DrawerButtonWidget(
            icon: Icons.format_align_right,
            title: 'Terms & Conditions',
            onTapFunction: () {},
          ),
        ],
      ),
    );
  }
}
