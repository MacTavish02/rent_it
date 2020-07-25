import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent_it/providers/properties.dart';
import 'package:rent_it/providers/property-model.dart';

class PropertyDetailsScreen extends StatefulWidget {
  static const routeName = 'details-screen';

  @override
  _PropertyDetailsScreenState createState() => _PropertyDetailsScreenState();
}

class _PropertyDetailsScreenState extends State<PropertyDetailsScreen> {
  String propertyId;
  Property propertyData;
  String imageUrl;
  bool _isInit = true;
  @override
  @override
  void didChangeDependencies() {
    if (_isInit) {
      final arguments =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      propertyId = arguments['id'];
      imageUrl = arguments['imageUrl'];
      Provider.of<PropertyProvider>(context)
          .getPropertyById(propertyId)
          .then((value) {
        setState(() {
          propertyData = value;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // print(propertyData.id);
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Hero(tag: Key('key' + propertyId), child: Image.network(imageUrl)),
            Padding(
              padding: const EdgeInsets.all(40),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.only(top: 180),
                child: Container(
                  width: double.infinity,
                  // height: double.infinity,
                  padding: const EdgeInsets.all(20),
                  child: propertyData == null
                      ? Center(child: CircularProgressIndicator())
                      : Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(2)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'For Rent',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '${propertyData.price.toString()} \u{20B9}',
                                    style: priceTextStyle,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(propertyData.title, style: titleTextStyle),
                                IconButton(
                                    icon: Icon(Icons.favorite_border),
                                    onPressed: () {}),
                              ],
                            )
                          ],
                        ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 25,
              child: MaterialButton(
                color: Colors.white,
                child: Icon(
                  Icons.arrow_back,
                  size: 25,
                  color: Colors.black,
                ),
                padding: const EdgeInsets.all(10),
                shape: CircleBorder(),
                onPressed: () {
                  Navigator.of(context).pop();
                },
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
    fontSize: 20.0,
    fontWeight: FontWeight.w500,
  );
}
