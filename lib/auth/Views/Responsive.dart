
import 'package:flutter/widgets.dart';

class Responsive extends StatelessWidget {
  const Responsive({super.key,
    required this.mobile,
    required this.desktop,
    required this.tablet,
  });  
  final Widget mobile;
  final Widget desktop;
  final Widget tablet;

  
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }
  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= 600 && MediaQuery.of(context).size.width < 1200;
  }
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1200;
  }

  @override
  Widget build(BuildContext context) {
    if (isDesktop(context)) {
      return desktop;
    } else if (isTablet(context)) {
      return tablet;
    } else {
      return mobile;
    }
  }

}