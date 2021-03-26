import 'package:abstracto_frontend/widgets/home_view/home_content_desktop.dart';
import 'package:abstracto_frontend/widgets/home_view/home_content_mobile.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      desktop: HomeContentDesktop(),
      mobile: HomeContentMobile(),
    );
  }
}
