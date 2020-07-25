import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:rent_it/providers/property-model.dart';

class PropertyProvider extends ChangeNotifier {
  List<Property> properties = [
    //   Property(
    //       id: 'id1',
    //       title: 'ArtHouse NewYork City',
    //       price: 6000,
    //       rating: 4.4,
    //       imageUrl:
    //           'https://cdn.home-designing.com/wp-content/uploads/2018/01/flying-pendant-lights-colourful-stools-kitsch-living-room-1024x683.jpg'),
    //   Property(
    //       id: 'id2',
    //       title: 'ArtHouse NewYork City',
    //       price: 6000,
    //       rating: 4.4,
    //       imageUrl:
    //           'https://arrivae.sgp1.cdn.digitaloceanspaces.com/assets/made_by_you_stories/priyanka_and_anand/01.jpg'),
    //   Property(
    //       id: 'id3',
    //       title: 'ArtHouse NewYork City',
    //       price: 6000,
    //       rating: 4.4,
    //       imageUrl:
    //           'https://cdn.home-designing.com/wp-content/uploads/2019/02/master-bedroom-closet-ideas.jpg'),
    //   Property(
    //       id: 'id4',
    //       title: 'ArtHouse NewYork City',
    //       price: 6000,
    //       rating: 4.4,
    //       imageUrl:
    //           'https://www.homehubinteriors.com/wp-content/uploads/2018/08/Master-Bedroom-View-01-1080x675.jpg'),
  ];

  Future<List<Property>> getPropertyList() async {
    List<Property> properties = [];
    final firestoreInstance = Firestore.instance;
    await firestoreInstance
        .collection('properties')
        .getDocuments()
        .then((value) {
      value.documents.forEach((element) {
        properties.add(Property(
          id: element.documentID,
          title: element.data['title'],
          price: element.data['price'],
          rating: element.data['rating'],
          imageUrl: element.data['imageUrl'],
        ));
      });
    }).catchError((onError) => print('Error = ' + onError.message));
    return properties;
  }

  Future<Property> getPropertyById(String propertyId) async {
    Property result;
    final firestoreInstance = Firestore.instance;
    await firestoreInstance
        .collection('properties')
        .document(propertyId)
        .get()
        .then((value) {
      result = Property(
          id: value.documentID,
          title: value.data['title'],
          price: value.data['price'],
          rating: value.data['rating'],
          imageUrl: value.data['imageUrl']);
    });
    return result;
  }
}
