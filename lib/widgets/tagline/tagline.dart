import 'package:abstracto_frontend/widgets/tagline/tagline_desktop.dart';
import 'package:abstracto_frontend/widgets/tagline/tagline_mobile.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class TagLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      desktop: TaglineDesktop(),
      mobile: TaglineMobile(),
    );
  }
}
