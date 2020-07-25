import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:rent_it/providers/user-data-model.dart';

class UserProvider extends ChangeNotifier {
  saveUserData(String firstName, String lastName, String email) async {
    Firestore firestoreInstance = Firestore.instance;
    String uid;
    await uId.then((value) => uid = value);
    print(uid);
    firestoreInstance.collection('users').document(uid).setData({
      'First Name': firstName,
      'Last Name': lastName,
      'Email': email,
    });
  }

  Future<String> get uId async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseUser user;
    await firebaseAuth.currentUser().then((value) => user = value);
    return user.uid;
  }

  switchFavorites(String propertyId, bool isFavorite) async {
    Firestore firestore = Firestore.instance;
    String uid;
    await uId.then((value) => uid = value);
    firestore.collection('users').document(uid).updateData({
      'Favorites': isFavorite
          ? FieldValue.arrayRemove([propertyId])
          : FieldValue.arrayUnion([propertyId])
    });
    notifyListeners();
  }

  Future<UserData> get getUserData async {
    Firestore firestore = Firestore.instance;
    String uid;
    await uId.then((value) => uid = value);
    UserData result;
    await firestore.collection('users').document(uid).get().then((value) {
      result = UserData(
        firstName: value.data['First Name'],
        lastName: value.data['Last Name'],
        email: value.data['Email'],
        favorites: value.data['Favorites'],
      );
    });
    return result;
  }

  Future<bool> isFavorite(String propertyId) async {
    bool isFavorite;
    await getUserData.then((value) {
      isFavorite = value.favorites.contains((element) => element == propertyId);
    });
    return isFavorite;
  }
}
