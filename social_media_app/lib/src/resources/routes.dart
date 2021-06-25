import 'package:flutter/widgets.dart';
import 'package:social_media_app/social_media.dart';

class Routes {
  Routes._();

  static const wrapper = '/';
  static const welcome = '/welcome';
  static const signin = '$welcome/signin';
  static const signup = '$welcome/signup';
  static const terms = '/termsAndConditions';

  static const dashboard = '/dashboard';
  static const chat = '$dashboard/chat';
  static const profile = '$dashboard/profile';

  static Map<String, WidgetBuilder> routes = {
    wrapper: (_) => Wrapper(),
    welcome: (_) => WelcomeScreen(),
    signup: (_) => SignupScreen(),
    signin: (_) => SigninScreen(),
    terms: (_) => TermsAndConditionsScreen(),

    dashboard: (_) => DashboardScreen(),
    chat: (_) => ChatScreen(),
    profile: (_) => ProfileScreen(),
  };
}
