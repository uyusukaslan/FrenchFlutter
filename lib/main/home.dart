import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:french/main.dart';
import 'package:french/main/lesson/stories.dart';
import 'package:french/main/profile.dart';
import 'package:french/main/study.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

void main() => runApp(Home());

class Home extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => HomeState();
}


class HomeState extends State<Home> {

  int _page = 0;

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        backgroundColor: Colors.white,
        fontFamily: 'playfair_display',
        textTheme: GoogleFonts.nunitoTextTheme(),
      ),
      home: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: buildBody(context),
            bottomNavigationBar: buildNavbar(),
          ),
      ),

    );
  }

  Widget buildNavbar() {

    PersistentTabController _controller;

    _controller = PersistentTabController(initialIndex: 1);


    return PersistentTabView(
      context,
      navBarHeight: 60,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: false,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style6, // Choose the nav bar style with this property.
    );
    
    /*CurvedNavigationBar(
      height: 70,
      backgroundColor: Colors.transparent,
      animationDuration: const Duration(milliseconds: 400),
      items: const <Widget>[
        Icon(Icons.school, size: 30,),
        Icon(Icons.add, size: 30,),
        Icon(Icons.person, size: 30,),
      ],
      onTap: (index){
        setState(() {
          _page = index;
        });
      },
    );*/
  }

  // AppBar buildAppBar() {
  //   return AppBar(
  //     backgroundColor: Colors.white,
  //     title: Text("Gallus", style: TextStyle(color: Colors.blueGrey, fontSize: 23, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, letterSpacing: 1, fontFamily: 'playfair_display'),),
  //     actions: const [
  //       Padding(
  //         padding: EdgeInsets.only(right: 20.0),
  //         child: CircleAvatar(
  //           backgroundColor: Colors.black,
  //         ),
  //       ),
  //       Padding(
  //         padding: EdgeInsets.only(right: 20.0),
  //         child: CircleAvatar(
  //           backgroundColor: Colors.black,
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget buildBody(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        color: Colors.transparent,
        child: changePage(_page),
      ),
    );
  }

  List<Widget> _buildScreens() {
    return [
      Stories(),
      Study(),
      Profile()
    ];
  }

  Widget changePage(int page){
    switch (page){
      case 0: return Stories();
      case 1: return Study();
      case 2: return Profile();
    }
    return Profile();
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        textStyle: TextStyle(fontSize: 14),
        icon: Icon(CupertinoIcons.book),
        title: ("Hikayeler"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),

      PersistentBottomNavBarItem(
        textStyle: TextStyle(fontSize: 14),
        icon: Icon(CupertinoIcons.home, ),
        title: ("Öğren"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),

      PersistentBottomNavBarItem(
        textStyle: TextStyle(fontSize: 14),
        icon: Icon(CupertinoIcons.profile_circled),
        title: ("Profil"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }
}
