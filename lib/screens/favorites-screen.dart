import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent_it/providers/properties.dart';
import 'package:rent_it/providers/property-model.dart';
import 'package:rent_it/providers/user-provider.dart';
import 'package:rent_it/widgets/property-card.dart';

class FavoritesScreen extends StatefulWidget {
  FavoritesScreen({Key key}) : super(key: key);
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  bool _isInIt = true;
  List favorites;
  List<Property> favoriteProperties = [];
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInIt) {
      Provider.of<UserProvider>(context, listen: false)
          .getUserData
          .then((value) {
        setState(() {
          favorites = value.favorites;
        });
        final propertyProvider =
            Provider.of<PropertyProvider>(context, listen: false);
        favorites.forEach((element) {
          propertyProvider.getPropertyById(element).then((value) {
            setState(() {
              favoriteProperties.add(value);
            });
          });
        });
      });
    }
    _isInIt = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorites',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: favorites == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              // itemExtent: 2,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (_, index) {
                return PropertyCardWidget(
                    property: Property(
                        id: favoriteProperties[index].id,
                        title: favoriteProperties[index].title,
                        imageUrl: favoriteProperties[index].imageUrl,
                        price: favoriteProperties[index].price,
                        rating: favoriteProperties[index].rating,
                        isFavorite: true));
              },
              itemCount: favoriteProperties.length,
            ),
    );
  }
}
