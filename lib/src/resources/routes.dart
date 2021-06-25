import 'package:flutter/widgets.dart';
import 'package:social_media_app/social_media.dart';
class Routes {
  Routes._();

  static const home = '/';

  static Map<String, WidgetBuilder> routes = {
    home: (_) => Home(),
  };
}
