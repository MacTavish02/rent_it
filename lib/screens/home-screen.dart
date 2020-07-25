import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent_it/providers/user-data-model.dart';
import 'package:rent_it/providers/user-provider.dart';
import 'package:rent_it/screens/bookings-screen.dart';
import 'package:rent_it/screens/cart-screen.dart';
import 'package:rent_it/screens/explore-screen.dart';
import 'package:rent_it/screens/favorites-screen.dart';
import 'package:rent_it/screens/profile-screen.dart';
import 'package:rent_it/widgets/main-drawer.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'home-screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  final List<Widget> screens = [
    ExploreScreen(key: PageStorageKey('explore-page')),
    FavoritesScreen(key: PageStorageKey('favorite-page')),
    BookingsScreen(),
    CartScreen(),
    ProfileScreen()
  ];

  final PageStorageBucket _pageStorageBucket = PageStorageBucket();
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
    return Scaffold(
      key: _drawerKey,
      drawer: MainDrawerWidget(context: context),
      bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: true,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          currentIndex: selectedIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.explore,
                color: Colors.black38,
              ),
              title: Text(
                'Explore',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              activeIcon: Icon(
                Icons.explore,
                color: Colors.blueAccent,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite_border,
                color: Colors.black45,
              ),
              activeIcon: Icon(
                Icons.favorite,
                color: Colors.redAccent,
              ),
              title: Text(
                'Favorites',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.art_track,
                color: Colors.black54,
              ),
              title: Text(
                'Bookings',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              activeIcon: Icon(
                Icons.art_track,
                color: Colors.green,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.black54,
              ),
              title: Text(
                'Cart',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              activeIcon: Icon(
                Icons.shopping_cart,
                color: Colors.green,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline,
                color: Colors.black54,
              ),
              activeIcon: Icon(
                Icons.person,
                color: Colors.black54,
              ),
              title: Text(
                'Profile',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ]),
      body: PageStorage(
        bucket: _pageStorageBucket,
        child: Stack(
          children: <Widget>[
            screens[selectedIndex],
            Positioned(
              left: 0,
              top: 25,
              child: MaterialButton(
                color: Theme.of(context).primaryColor,
                child: Icon(
                  Icons.menu,
                  size: 25,
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(10),
                shape: CircleBorder(),
                onPressed: () => _drawerKey.currentState.openDrawer(),
              ),
            ),
            Positioned(
              right: 0,
              top: 25,
              child: MaterialButton(
                color: Theme.of(context).primaryColor,
                child: Icon(
                  Icons.notifications,
                  size: 25,
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(10),
                shape: CircleBorder(),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
