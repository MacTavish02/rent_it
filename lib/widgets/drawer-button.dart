import 'package:flutter/material.dart';

class DrawerButtonWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onTapFunction;

  DrawerButtonWidget({this.icon, this.title, this.onTapFunction});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapFunction,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color.fromRGBO(0, 0, 0, 0.1),
            ),
          ),
        ),
        height: 60,
        alignment: Alignment.center,
        child: ListTile(
          leading: Icon(icon),
          title: Text(title),
        ),
      ),
    );
  }
}
