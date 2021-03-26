import 'package:abstracto_frontend/widgets/home_view/home_content.dart';
import 'package:abstracto_frontend/widgets/nav_drawer/navigation_drawer.dart';
import 'package:abstracto_frontend/widgets/navbar/navigation_bar.dart';
import 'package:abstracto_frontend/widgets/tagline/tagline.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Scaffold(
        drawer: sizingInformation.deviceScreenType == DeviceScreenType.mobile
            ? NavigationDrawer()
            : null,
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20.2, 20.2, 20.0, 10.0),
                child: NavigationBar(),
              ),
              TagLine(),
              Container(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.2, 20.2, 10.0, 10.0),
                child: HomeContent(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
