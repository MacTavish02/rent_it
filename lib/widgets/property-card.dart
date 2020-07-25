import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent_it/providers/property-model.dart';
import 'package:rent_it/providers/user-provider.dart';
import 'package:rent_it/screens/property-details-screen.dart';

class PropertyCardWidget extends StatefulWidget {
  final Property property;
  bool isFavorite;
  PropertyCardWidget({this.property});

  @override
  _PropertyCardWidgetState createState() => _PropertyCardWidgetState();
}

class _PropertyCardWidgetState extends State<PropertyCardWidget> {
  bool firstTime = true;
  bool isFavorite;

  // _PropertyCardWidgetState() {
  //   Provider.of<UserProvider>(context)
  //       .isFavorite(widget.property.id)
  //       .then((value) {
  //     setState(() {
  //       isFavorite = value;
  //     });
  //   });
  // }

  @override
  // ignore: must_call_super
  void initState() {
    super.initState();
    setState(() {
      isFavorite = widget.property.isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    // if (firstTime) {
    //   isFavorite = widget.property.isFavorite;
    // }

    isFavorite = widget.property.isFavorite;

    firstTime = false;
    // print('Inside Property Card Build' + isFavorite.toString());
    final userProvider = Provider.of<UserProvider>(context);
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .pushNamed(PropertyDetailsScreen.routeName, arguments: {
        'id': widget.property.id,
        'imageUrl': widget.property.imageUrl
      }),
      child: Container(
        child: Stack(
          children: <Widget>[
            Hero(
              tag: Key('key' + widget.property.id),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(widget.property.imageUrl),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin: const EdgeInsets.only(top: 180),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Theme.of(context).primaryColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'FOR RENT',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${widget.property.price.toString()} \u{20B9}',
                            style: priceTextStyle,
                          ),
                        ),
                      ],
                    ),
                    ListTile(
                      title: Text(
                        widget.property.title,
                        style: titleTextStyle,
                      ),
                      subtitle: Text('property.address'),
                      trailing: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: Icon(isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border),
                          onPressed: () {
                            userProvider.switchFavorites(
                                widget.property.id, isFavorite);
                            setState(() {
                              isFavorite = !isFavorite;
                            });
                          },
                          color: Colors.red,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final TextStyle priceTextStyle = const TextStyle(
    color: Colors.black,
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
  );

  final TextStyle titleTextStyle = const TextStyle(
    color: Colors.black,
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
  );
}
