import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent_it/providers/properties.dart';
import 'package:rent_it/providers/property-model.dart';
import 'package:rent_it/providers/user-data-model.dart';
import 'package:rent_it/providers/user-provider.dart';
import 'package:rent_it/widgets/property-card.dart';

class ExploreScreen extends StatefulWidget {
  static const routeName = 'explore-screen';
  ExploreScreen({Key key}) : super(key: key);
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  UserData userData =
      UserData(favorites: [], email: null, firstName: null, lastName: null);
  bool _isInIt = true;
  List<Property> properties;
  ScrollController _scrollController = ScrollController();

  @override
  Future<void> didChangeDependencies() async {
    // print('Start of InitState');
    super.didChangeDependencies();
    // print('Middle of InitState');
    if (_isInIt) {
      await Provider.of<PropertyProvider>(context, listen: false)
          .getPropertyList()
          .then((value) {
        setState(() {
          // print('Property provider Up');
          properties = value;
          // print('Property provider Down');
        });
      });
      await Provider.of<UserProvider>(context, listen: false)
          .getUserData
          .then((value) {
        setState(() {
          // print('User provider Up');
          userData = value;
          // print('User provider Down');
        });
      });
    }
    _isInIt = false;
    // print("End of initState");
  }

  @override
  Widget build(BuildContext context) {
    // print("Inside build");
    return properties == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            // itemExtent: 2,
            controller: _scrollController,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (_, index) {
              // print(userData.favorites);
              // print(userData.firstName);
              // print(properties[index].id);
              bool isFavorite =
                  userData.favorites.contains(properties[index].id);
              print('Inside ExploreScreen ' + isFavorite.toString());
              return PropertyCardWidget(
                  property: Property(
                id: properties[index].id,
                title: properties[index].title,
                imageUrl: properties[index].imageUrl,
                price: properties[index].price,
                rating: properties[index].rating,
                isFavorite: isFavorite,
              ));
            },
            itemCount: properties.length,
          );
  }
}
