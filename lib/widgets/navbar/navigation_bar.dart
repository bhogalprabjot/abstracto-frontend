import 'package:abstracto_frontend/widgets/navbar/navbar_iems.dart';
import 'package:abstracto_frontend/widgets/navbar/navigation_bar_mobile.dart';
import 'package:abstracto_frontend/widgets/navbar/navigation_bar_tablet_desktop.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class NavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      tablet: NavigationBarTabletDesktop(),
      mobile: NavigationBarMobile(),
    );
  }
}
