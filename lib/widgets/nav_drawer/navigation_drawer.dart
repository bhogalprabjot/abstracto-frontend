import 'package:abstracto_frontend/widgets/nav_drawer/nav_drader_header.dart';
import 'package:abstracto_frontend/widgets/nav_drawer/nav_drawer_item.dart';
import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
          color: Colors.black,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 16)]),
      child: Column(
        children: <Widget>[
          NavigationDrawerHeader(),
          DrawerItem('Services', Icons.miscellaneous_services_outlined),
          DrawerItem('Contact us', Icons.mail),
        ],
      ),
    );
  }
}
