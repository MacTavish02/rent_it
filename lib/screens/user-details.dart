import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent_it/providers/user-provider.dart';
import 'package:rent_it/screens/home-screen.dart';

class UserDetailsScreen extends StatefulWidget {
  static const routeName = 'user-details-screen';

  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  bool _agreeToTerms = false;
  final _form = GlobalKey<FormState>();
  String firstName;
  String lastName;
  String email;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _form,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'First Name *',
                        contentPadding: EdgeInsets.all(10),
                      ),
                      onSaved: (newValue) => firstName = newValue,
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Flexible(
                    child: TextFormField(
                      onSaved: (newValue) => lastName = newValue,
                      decoration: InputDecoration(
                        hintText: 'Last Name *',
                        contentPadding: EdgeInsets.all(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                onSaved: (newValue) => email = newValue,
                decoration: InputDecoration(
                  hintText: 'Email',
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
            ),
            CheckboxListTile(
              value: _agreeToTerms,
              onChanged: (value) {
                setState(() {
                  _agreeToTerms = value;
                });
              },
              title: Text('I agree to terms and conditions'),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: double.infinity,
                child: RaisedButton(
                  onPressed: _agreeToTerms
                      ? () {
                          _form.currentState.save();
                          userProvider.saveUserData(firstName, lastName, email);
                          Navigator.of(context)
                              .pushReplacementNamed(HomeScreen.routeName);
                        }
                      : null,
                  child: Text(
                    'Update Profile',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
