import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ivoc/fab_bottom_app_bar.dart';
import 'package:ivoc/fab_with_icons.dart';
import 'package:ivoc/fragments/habit.dart';
import 'package:ivoc/fragments/login_screen.dart';
import 'package:ivoc/fragments/register_screen.dart';
import 'package:ivoc/fragments/VData.dart';
import 'package:ivoc/fragments/picture.dart';
import 'package:ivoc/fragments/favorite.dart';
import 'package:ivoc/layout.dart';
import 'package:http/http.dart' show get;


class MyApp extends StatefulWidget{

  final drawerItems = [
    new DrawerItem("登入", Icons.home),
    new DrawerItem("建立帳號", Icons.add),
  ];
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AppState();
  }
}

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}
class AppState extends State<MyApp>{
  String _lastSelected = 'TAB: 0';

  void _selectedTab(int index) {
    setState(() {
      _lastSelected = 'TAB: $index';
      if(index==0){
        _selectedDrawerIndex = 0;
      }else{
      _selectedDrawerIndex = 2+index;
      }
      print(_selectedDrawerIndex);
    });
  }

  void _selectedFab(int index) {
    setState(() {
      _lastSelected = 'FAB: $index';
    });
  }
  int _selectedDrawerIndex = 0;
  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new LoginScreen();
      case 1:
        return new RegisterScreen();
      case 2:
        return new Habit();
      case 3 :
        return new Favorite();
      case 4 :
        return new VData();
      case 5 :
        return new picture();
      default:
        return new Text("Error");
    }
  }
  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    List<Widget> drawerOptions = [];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(
          new ListTile(
            leading: new Icon(d.icon),
            title: new Text(d.title),
            selected: i == _selectedDrawerIndex,
            onTap: () => _onSelectItem(i),
          )
      );
    }
    return MaterialApp(
      home: Scaffold(
        body: _getDrawerItemWidget(_selectedDrawerIndex),
        appBar: AppBar(
          backgroundColor: Color(0xff5c6bc0),
          title: Text("ivoc"),
        ),
          drawer: new Drawer(
            child: Container(
              color: Color(0xFFF3E5F5),
              child: new Column(
                children: <Widget>[
                  new UserAccountsDrawerHeader(
                      accountName: new Text("beta test"), accountEmail: null,decoration: BoxDecoration(
                    color: const Color(0xFFE1BEE7),
                    image: DecorationImage(
                      image: ExactAssetImage('images/flowers.png'),
                      fit: BoxFit.cover,
                    ),
                  ), ),
                  new Column(children: drawerOptions)
                ],
              ),
            ),
            ),
        bottomNavigationBar: FABBottomAppBar(
          centerItemText: '添加',
          color: Colors.grey,
          selectedColor: Colors.red,
          notchedShape: CircularNotchedRectangle(),
          onTabSelected: _selectedTab,
          items: [

            FABBottomAppBarItem(iconData: Icons.star, text: '首頁'),
            FABBottomAppBarItem(iconData: Icons.collections, text: '我的最愛'),
            FABBottomAppBarItem(iconData: Icons.account_circle, text: '我的單字'),
            FABBottomAppBarItem(iconData: Icons.dashboard, text: '圖文搭配'),

          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _buildFab(
            context),
      ),
    );
  }
  Widget _buildFab(BuildContext context) {
    final icons = [ Icons.collections, Icons.camera_alt, Icons.search ];
    return AnchoredOverlay(
      showOverlay: true,
      overlayBuilder: (context, offset) {
        return CenterAbout(
          position: Offset(offset.dx, offset.dy - icons.length * 35.0),
          child: FabWithIcons(
            icons: icons,
            onIconTapped: _selectedFab,
          ),
        );
      },
      child: FloatingActionButton(
        onPressed: () { },
        tooltip: 'Increment',
        child: Icon(Icons.add),
        elevation: 2.0,
      ),
    );
  }
}